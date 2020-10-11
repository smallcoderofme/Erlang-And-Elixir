-module (server1).
-export ([start/2, rpc/2]).

start(Name, Mod) ->
	register(Name, spawn(fun() -> loop(Name, Mod, Mod:init()) end)).


rpc(Name, Request) ->
	io:format("server1 rpc ~w Name ~w ~n", [self(), Name]),
	Name ! { self(), Request },
	receive
		{ Name, Response } ->
			io:format("server1 rpc Response: ~w~n", [Response]),
			Response
	end.

loop(Name, Mod, State) ->
	io:format("server1 loop ~w Name ~w ~n", [self(), Name]),
	receive
		{ From, Request } ->
			{ Response, State1 } = Mod:handle(Request, State),
			From ! { Name, Response },
			loop(Name, Mod, State1)
	end.