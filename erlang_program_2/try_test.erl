-module (try_test).
-export ([demo/0]).


generate_exception(1) -> a;
generate_exception(2) -> throw(a);
generate_exception(3) -> exit(a);
generate_exception(4) -> {"EXIT", a};
generate_exception(5) -> error(a).

catcher(C) ->
	try generate_exception(C) of
		Val -> {C, normal, Val}
	catch
		throw:X -> {C, caught, throw, X};
		exit:X -> {C, caught, exited, X};
		error:X -> {C, caught, error, X}
	end.

demo() ->
	[catcher(I) || I <- [1,2,3,4,5]].


