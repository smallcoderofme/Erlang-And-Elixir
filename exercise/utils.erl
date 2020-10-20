-module (utils).
-export ([generate_pokers/0, pokers_sort/2, get_pokers_type/1, compare2B/2, compare2S/2]).
-include ("records.hrl").
% lists:sort(fun utils:compare/2, Pokers).
compare2B(#poker{} = A, #poker{} = B) ->
	if
		A#poker.value > B#poker.value -> true;
		true -> false
	end.
compare2S(#poker{} = A, #poker{} = B) ->
	if
		A#poker.value < B#poker.value -> true;
		true -> false
	end.

generate_pokers() ->
	lists:seq(1,54).

get_pokers_type(_L) ->
	Type = #poker_type{},
	Type.
