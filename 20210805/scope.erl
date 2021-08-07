-module(scope).

-export([base/1, mult2/1, map/2, max/1]).

base(A) ->
	B = A + 1,
	F = fun() -> A * B end,
	F().

mult2(X) ->
	X * 2.

map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F,T)].


max([H|T]) -> max2(H, T).

max2(Max, []) -> Max;
max2(Max, [H|T]) when H > Max -> max2(H, T);
max2(Max, [_|T]) -> max2(Max, T). 

% max([H|T]) -> max2(T, H).

% max2([], Max) -> Max;
% max2([H|T], Max) when H > Max -> max2(T, H);
% max2([_|T], Max) -> max2(T, Max).