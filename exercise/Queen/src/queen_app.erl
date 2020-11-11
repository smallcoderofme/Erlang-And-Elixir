%% @author Administrator
%% @doc @todo Add description to queen_app.


-module(queen_app).
-behaviour(application).
-export([start/2, stop/1, go/0]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([]).



%% ====================================================================
%% Behavioural functions
%% ====================================================================

%% start/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/apps/kernel/application.html#Module:start-2">application:start/2</a>
%% -spec start(Type :: normal | {takeover, Node} | {failover, Node}, Args :: term()) ->
%% 	{ok, Pid :: pid()}
%% 	| {ok, Pid :: pid(), State :: term()}
%% 	| {error, Reason :: term()}.
%% %% ====================================================================
%% start(Type, StartArgs) ->
%%     case 'TopSupervisor':start_link(StartArgs) of
%% 		{ok, Pid} ->
%% 			{ok, Pid};
%% 		Error ->
%% 			Error
%%     end.

%% stop/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/apps/kernel/application.html#Module:stop-1">application:stop/1</a>
-spec stop(State :: term()) ->  Any :: term().
%% ====================================================================
stop(_State) ->
    ok.

%% ====================================================================
%% Internal functions
%% ====================================================================


go() ->
	application:start(queen).

start(_Type, _StartArgs) ->
	io:format("App begin: ~p ~n", [self()]),
	client_sup:start_link(),
	socket_sup:start_link(),
	{ok, self()}.
	
