-module (count).
-export ([countdown/1, countup/1]).

countdown(From) when From > 0 ->
	io:format("Current From ~w ~n", [From]),
	countdown(From-1);

countdown(_) ->
	io:format("blastoff!~n").

countup(Limit) ->
	countup(1, Limit).

countup(Current, Limit) when Current =< Limit ->
	io:format("Current: ~w, Limit ~w ~n.", [Current, Limit]),
	countup(Current+1, Limit);

countup(_, _) -> 
	io:format("Over ! ~n.").
