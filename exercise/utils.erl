-module (utils).
-export ([generate_pokers/0, pokers_sort/2, get_pokers_type/1, compare/2]).
-include ("records.hrl").

compare([#poker{} = A], [#poker{} = B]) ->
	if
		A#poker.value > B#poker.value -> true;
		true -> false
	end.

generate_pokers() ->
	lists:seq(1,54).

pokers_sort(s2b, L) ->
	lists:keysort(L, 2);

pokers_sort(b2s, L) ->
	lists:reverse(lists:keysort(L, 2)).


get_pokers_type(_L) ->
	Type = #poker_type{},
	Type.
