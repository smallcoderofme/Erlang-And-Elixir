-module (lib_misc).
-export ([for/3, quicksort/1, pythag/1]).

for(Max, Max, F) -> [F(Max)];

for(I, Max, F) ->
	[F(I) | for(I+1, Max, F)].

quicksort([]) -> [];
quicksort([H|T]) ->
	quicksort([X || X <- T, X < H])
	++ [H] ++
	quicksort([X || X <- T, X >= H]).

pythag(N) -> 
	[{A,B,C} ||
		A<- lists:seq(1,N),
		B<- lists:seq(1,N),
		C<- lists:seq(1,N),
		A+B+C =< N,
		A*A+B*B =:= C*C
	].