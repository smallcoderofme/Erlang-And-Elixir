-module (pid_send_test).
-behaviour (gen_server).
-export ([start/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record (state, {}).

start() ->
	gen_server:start_link(?MODULE, [], []).

init([]) ->
	process_flag(trap_exit, true),
	erlang:send_after(5*1000, self(), {send, <<123,15>>}),
	{ok, #state{}}.

handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info({send, Bin},State) ->
    io:format("Get message from pid: ~w ~n", [Bin]),
	{noreply,State};

handle_info({stop},State) ->
	{stop,normal,State};

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.