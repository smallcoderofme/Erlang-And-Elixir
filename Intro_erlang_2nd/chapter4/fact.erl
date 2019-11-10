-module (fact).
-export ([factorial/1, factorial1/1, factorial2/1]).

factorial(N) when N > 1 ->
	N * factorial(N-1);

factorial(N) when N =<1 ->
	1.

factorial1(N) ->
	factorial1(1, N, 1).

factorial1(Current, N, Result) when Current <= N ->
	CurrResult = Current * Result,
	io:format("current result ~w ~n", CurrResult),
	factorial1(Current+1, N, CurrResult).

factorial1(Current, N, Result) ->
	io:format("finish!"),
	Result.


factorial2(N) -> factorial2(N, 1).
factorial2(N, Result) when N > 1 ->
	factorial2(N-1, N*Result);
factorial2(N, Result) when N =< 1 ->
	Result.