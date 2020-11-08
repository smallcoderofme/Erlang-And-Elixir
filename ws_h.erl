-module(ws_h).

-export([init/2]).
-export([websocket_init/1]).
-export([websocket_handle/2]).
-export([websocket_info/2]).
% -export ([websocket_terminate/3]).
-export ([terminate/3]).

init(Req, Opts) ->
	% ets:new(gate_conn, [bag, named_table]),
	#{pid := Pid} = Req,
	gate_cb:add(Pid),

	% ets:insert(gate_conn, { gate, Pid }),
	% io:format("Pid list: ~w ~n", [gate_cb:lookup()]),
	{cowboy_websocket, Req, Opts}.

websocket_init(State) ->
	% erlang:start_timer(1000, self(), <<"Hello!">>),
	{[{text, <<"Immediately Hello!">>}], State}.
	% self()! {[{text, <<"Hello Response">>}], State},
	% {[], State}.

websocket_handle({text, Msg}, State) ->
	% self()! {text, <<"Insert message">>},
	lists:foreach(
		fun({_, CurrPid}) -> 
			CurrPid ! { chat, <<"Boardcast message", Msg/binary>> }
		end,
		gate_cb:lookup()
		),
	{[], State};

websocket_handle(_Data, State) ->
	{[], State}.

websocket_info({chat, Msg}, State)->
	io:format("chat ~w~n", [Msg]),
    {[{text,Msg}], State};

websocket_info({timeout, _Ref, Msg}, State) ->
	erlang:start_timer(1000, self(), <<"How' you doin'?">>),
	{[{text, Msg}], State};

websocket_info(_Info, State) ->
	{[], State}.
 
terminate(Reason, PartialReq, State) ->
	io:format("terminate Reason: ~w, PartialReq: ~w, State: ~w , Pid: ~w ~n", [Reason, PartialReq, State, self()]),
	gate_cb:remove(self()),
	% case Reason of
	% 	{remote, 1001, _} ->	
	% 		io:format("refresh.~n");
	% 	{timeout} ->
	% 		io:format("timeout.~n");
	% 	{error, closed} ->
	% 		io:format("closed page.~n")
	% end,
	ok.

