%% @author Administrator
%% @doc @todo Add description to socket_work.


-module(socket_work).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3, start_link/1]).

%% ====================================================================
%% API functions
%% ====================================================================
%% -export([]).



%% ====================================================================
%% Behavioural functions
%% ====================================================================
-record(state, {socket,ref}).

%% init/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:init-1">gen_server:init/1</a>
-spec init(Args :: term()) -> Result when
	Result :: {ok, State}
			| {ok, State, Timeout}
			| {ok, State, hibernate}
			| {stop, Reason :: term()}
			| ignore,
	State :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================
%% 然后就是等客户端connect了，当客户端有connect时，accept进程会收到一条{inet_async, LSock, Ref, {ok, Sock} 这样的消息，
init(Lsocket) ->
	process_flag(trap_exit, true),
	State = #state{socket = Lsocket},
	case accept(State) of
		{noreply, State1} -> {ok, State1};
		Other -> Other
    end.


accept(State = #state{socket=LSock}) ->
	case prim_inet:async_accept(LSock, -1) of
		{ok, Ref} -> {noreply, State#state{ref=Ref}};
		Error -> {stop, {cannot_accept, Error}, State}
	end.

%% handle_call/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_call-3">gen_server:handle_call/3</a>
-spec handle_call(Request :: term(), From :: {pid(), Tag :: term()}, State :: term()) -> Result when
	Result :: {reply, Reply, NewState}
			| {reply, Reply, NewState, Timeout}
			| {reply, Reply, NewState, hibernate}
			| {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason, Reply, NewState}
			| {stop, Reason, NewState},
	Reply :: term(),
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity,
	Reason :: term().
%% ====================================================================
handle_call(Request, From, State) ->
    Reply = ok,
    {reply, Reply, State}.


%% handle_cast/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_cast-2">gen_server:handle_cast/2</a>
-spec handle_cast(Request :: term(), State :: term()) -> Result when
	Result :: {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason :: term(), NewState},
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================
handle_cast(Msg, State) ->
    {noreply, State}.


%% handle_info/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_info-2">gen_server:handle_info/2</a>
-spec handle_info(Info :: timeout | term(), State :: term()) -> Result when
	Result :: {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason :: term(), NewState},
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================

handle_info({inet_async, LSock, Ref, {ok, Sock}}, State = #state{socket=LSock, ref=Ref}) ->
	case set_sockopt(LSock, Sock) of
		ok -> ok;
		{error, Reason} -> exit({set_sockopt, Reason})
	end,
    {ok, Child} = supervisor:start_child(client_sup, [Sock]),
	ok = gen_tcp:controlling_process(Sock, Child),
	accept(State);

handle_info(Info, State) ->
    {noreply, State}.

set_sockopt(LSock, Sock) ->
	true = inet_db:register_socket(Sock, inet_tcp),
	case prim_inet:getopts(LSock, [active, nodelay, keepalive, delay_send, priority, tos]) of
		{ok, Opts} ->
			case prim_inet:setopts(Sock, Opts) of
				ok -> ok;
				Error -> gen_tcp:close(Sock),
						Error
			end;
		Error ->
			gen_tcp:close(Sock),
			Error
	end.
%% terminate/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:terminate-2">gen_server:terminate/2</a>
-spec terminate(Reason, State :: term()) -> Any :: term() when
	Reason :: normal
			| shutdown
			| {shutdown, term()}
			| term().
%% ====================================================================
terminate(Reason, State) ->
    ok.


%% code_change/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:code_change-3">gen_server:code_change/3</a>
-spec code_change(OldVsn, State :: term(), Extra :: term()) -> Result when
	Result :: {ok, NewState :: term()} | {error, Reason :: term()},
	OldVsn :: Vsn | {down, Vsn},
	Vsn :: term().
%% ====================================================================
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


%% ====================================================================
%% Internal functions
%% ====================================================================

start_link(Lsocket) ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, Lsocket, []).
