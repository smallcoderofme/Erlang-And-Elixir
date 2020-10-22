-module (utils).
-export ([generate_pokers_indexes/0, generate_pokers_indexes/2, get_pokers_type/1, compare2B/2, compare2S/2, number_of/3]).
-include ("records.hrl").
% lists:sort(fun utils:compare/2, Pokers).
compare2S(#poker{} = A, #poker{} = B) ->
	if
		A#poker.v > B#poker.v -> true;
		true -> false
	end.
compare2B(#poker{} = A, #poker{} = B) ->
	if
		A#poker.v < B#poker.v -> true;
		true -> false
	end.

generate_pokers_indexes() ->
	lists:seq(1,54).

generate_pokers_indexes(From, To) when From < 55, From > 0; To < 54, To > 0 ->
	lists:seq(From, To).

get_pokers_type(L) ->
	R = lists:sort(fun compare2S/2, L),
	Res = adapter(R,[],[],[],[],[],R),
	[S, D, T, Q, J] = Res,
	#poker_type{a=R, s=S, d=D, t=T, q=Q, j=J}.

adapter([H|L], S, D, T, Q, J, A) ->
	case number_of(H, A, 0) of
		1 when H#poker.i > 52  -> 
			 adapter(L, [H|S], D, T, Q, [H|J], A);
		1 when H#poker.i < 53 -> 
			 adapter(L, [H|S], D, T, Q, J, A);
		2 when lists:member(H, D) -> adapter(L, S, [H|D], T, Q, J, A);
		3 when lists:member(H, T) -> adapter(L, S, D, [H|T], Q, J, A);
		4 when lists:member(H, Q) -> adapter(L, S, D, T, [H|Q], J, A)
	end;

adapter([], S, D, T, Q, J, _A) ->
	[S, D, T, Q, J].

number_of(#poker{} = Cp, [#poker{} = H|Pt], I) ->
	if
		H#poker.v == Cp#poker.v ->
			number_of(Cp, Pt, I+1);
		true ->
			number_of(Cp, Pt, I)
	end;

number_of(_, [], I) ->
	I.