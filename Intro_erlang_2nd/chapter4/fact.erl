-module (fact).
-export ([factorial/1, factorial2/1, exchange/1]).

factorial(N) when N > 1 ->
	N * factorial(N-1);

factorial(N) when N =<1 ->
	1.


factorial2(N) -> factorial2(N, 1).
factorial2(N, Result) when N > 1 ->
	factorial2(N-1, N*Result);
factorial2(N, Result) when N =< 1 ->
	Result.

exchange([]) -> 0;
exchange(L) ->
	[F|T] = L,
	[S|_] = T,
	[S,F].