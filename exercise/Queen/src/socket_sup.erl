%% @author Administrator
%% @doc @todo Add description to socket_sup.


-module(socket_sup).
-behaviour(supervisor).
-export([init/1, start_link/0]).

-define(TCP_OPTIONS, [binary, {packet, 0}, {active, false}, {reuseaddr, true}, {nodelay, false}, {delay_send, true}, {send_timeout, 5000}, {keepalive, true}, {exit_on_close, true}]).

%% ====================================================================
%% API functions
%% ====================================================================

%% ====================================================================
%% Behavioural functions
%% ====================================================================

%% init/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/supervisor.html#Module:init-1">supervisor:init/1</a>
%% -spec init(Args :: term()) -> Result when
%% 	Result :: {ok, {SupervisionPolicy, [ChildSpec]}} | ignore,
%% 	SupervisionPolicy :: {RestartStrategy, MaxR :: non_neg_integer(), MaxT :: pos_integer()},
%% 	RestartStrategy :: one_for_all
%% 					 | one_for_one
%% 					 | rest_for_one
%% 					 | simple_one_for_one,
%% 	ChildSpec :: {Id :: term(), StartFunc, RestartPolicy, Type :: worker | supervisor, Modules},
%% 	StartFunc :: {M :: module(), F :: atom(), A :: [term()] | undefined},
%% 	RestartPolicy :: permanent
%% 				   | transient
%% 				   | temporary,
%% 	Modules :: [module()] | dynamic.
%% ====================================================================
%% init([]) ->
%%     AChild = {'AName',{'AModule',start_link,[]},
%% 	      permanent,2000,worker,['AModule']},
%%     {ok,{{one_for_all,0,1}, [AChild]}}.

init([]) ->
	process_flag(trap_exit, true),
	case gen_tcp:listen(9090, ?TCP_OPTIONS) of
		{ok, Lsocket} ->
			Child = {socket_work, {socket_work, start_link, [Lsocket]},
					 permanent, 1000, worker, [socket_work]},
			{ok, {{one_for_one, 100, 5}, [Child]}};
		{error, Reason} ->
			{stop, Reason}
	end.

%% ====================================================================
%% Internal functions
%% ====================================================================

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

