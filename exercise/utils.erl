-module (utils).
-export ([generate_pokers_indexes/0, generate_pokers_indexes/2, get_pokers_type/1, compare2B/2, compare2S/2, number_of/3]).
-include ("records.hrl").
% lists:sort(fun utils:compare/2, Pokers).
compare2S(#poker{} = A, #poker{} = B) ->
	if
		A#poker.value > B#poker.value -> true;
		true -> false
	end.
compare2B(#poker{} = A, #poker{} = B) ->
	if
		A#poker.value < B#poker.value -> true;
		true -> false
	end.

generate_pokers_indexes() ->
	lists:seq(1,54).

generate_pokers_indexes(From, To) when From < 54, From > 0; To < 54, To > 0 ->
	lists:seq(From, To).

get_pokers_type(L) ->
	lists:sort(fun compare2S/2, L),
	Type = #poker_type{total=L},
	check(L, Type),
	Type.

check(PL, Type) ->
	[adapter(P, PL, Type) || P <- PL ].

adapter(#poker{} = P, PL, #poker_type{} = T) -> 
	I = number_of(P, PL, 0),
	io:format("adapter I(number): ~w ~n", [I]),
	if
		P#poker.index == 54 -> add_poker(P, T#poker_type.jokers);
		P#poker.index == 53 -> add_poker(P, T#poker_type.jokers);
		I==1 				-> add_poker(P, T#poker_type.single);
		I==2 				-> add_poker(P, T#poker_type.double);
		I==3 				-> add_poker(P, T#poker_type.triple);
		I==4 				-> add_poker(P, T#poker_type.quadruple)
	end.

add_poker(P, L) -> 
	N = is_exist(P, L, 0),
	io:format("add_poker N(number): ~w ~n", [N]),
	if
		N == 0 ->
			[ P|L ];
		true ->  
			L
	end.

is_exist(#poker{} = Cp, [#poker{} = H|Pt], I) ->
	if
		H#poker.index == Cp#poker.index ->
			is_exist(Cp, Pt, I+1);
		true ->
			is_exist(Cp, Pt, I)
	end;

is_exist(_, [], I) ->
	I.

number_of(#poker{} = Cp, [#poker{} = H|Pt], I) ->
	if
		H#poker.value == Cp#poker.value ->
			number_of(Cp, Pt, I+1);
		true ->
			number_of(Cp, Pt, I)
	end;

number_of(_, [], I) ->
	I.