-module (module_test).
-export ([area/1, test/0]).

test() -> 
	12 = area({rectangle, 3, 4}),
	144 = area({squre, 12}),
	tests_worked.

area({rectangle, Width, Height}) ->
	Width * Height;

area({squre, Side}) ->
	Side * Side.