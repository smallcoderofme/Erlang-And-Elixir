-module (func_test).
-export ([print/0]).

print() ->
	io:format("Double = fun(X) -> 2*X end.").