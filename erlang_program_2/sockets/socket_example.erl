-module (socket_example).
-export ([start_nano_server/0, nano_client_eval/1]).

start_nano_server() -> 
	{ ok, Listen } = gen_tcp:listen(2345, [binary, { packet, 0 }, { reuseaddr, true }, {active, true}]),
	{ ok, Socket } = gen_tcp:accept(Listen),
	gen_tcp:close(Listen),
	loop(Socket).

loop(Socket) -> 
	receive
		{ tcp, Socket, Bin } ->
			io:format("Server receive binary = ~p ~n", [Bin]),
			Str = binary_to_term(Bin),
			io:format("Server (unpacked) = ~p ~n", [Str]),
			Reply = lib_misc: string2value(Str),
			io:format("Server replying = ~p ~n", [Reply]),
			gen_tcp:send(Socket, term_to_binary(Reply)),
			loop(Socket);
		{ tcp_passive, Socket} -> 
			io:format("Server tcp_passive ~n"),
			loop(Socket);
		{ tcp_closed, Socket} -> 
			io:format("Server socket closed. ~n")
	end.


nano_client_eval(Str) ->
	{ ok, Socket } = gen_tcp:connect("localhost", 2345, [binary, {packet, 0}]),
	ok = gen_tcp:send(Socket, term_to_binary(Str)),
	receive
		{ tcp, Socket, Bin } ->
			io:format("Client receive binary = ~p ~n", [Bin]),
			Val = binary_to_term(Bin),
			io:format("Client result = ~p ~n", [Val]),
			gen_tcp:close(Socket)
	end.
