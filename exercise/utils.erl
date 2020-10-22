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
	Res = adapter(R,[],[],[],[]),
	[S, D, T, Q] = Res,
	[H1,H2|_Tt] = R,
	Bj = if
		H1#poker.i =:= 54 -> 
			H1;
		true -> undefined
	end,
	Sj = if
		H2#poker.i =:= 53 -> H2;
		true -> undefined
	end,
	JL = if
		Bj =/= undefined, Sj =/= undefined -> [Bj,Sj];
		true -> []
	end,
	% io:format("Test jokers: ~w ~w ~n", [Bj, Sj]),
	#poker_type{s=S, d=D, t=T, q=Q, j=JL, bj=Bj, sj=Sj}.

adapter([#poker{}=H|L], S, D, T, Q) ->
	Count = number_of(H, L, 0),
	Ret = if
		Count =:= 0 					->		 
			adapter(L, [H|S], D, T, Q);
		Count =:= 1 					-> 
			[_|N] = L,
			adapter(N, S, [H|D], T, Q);
		Count =:= 2 					-> 
			[_,_|N] = L,
			adapter(N, S, D, [H|T], Q);
		Count =:= 3 					-> 
			[_,_,_|N] = L,
			adapter(N, S, D, T, [H|Q]);
		true 						->
			adapter(L, S, D, T, Q)
	end,
	Ret;

adapter([], S, D, T, Q) ->
	[S, D, T, Q].

number_of(#poker{} = Cp, [#poker{} = H|Pt], I) ->
	if
		H#poker.v =:= Cp#poker.v ->
			number_of(Cp, Pt, I+1);
		true ->
			number_of(Cp, Pt, I)
	end;

number_of(_, [], I) ->
	I.