-module (lib_misc).
-export ([
	for/3, 
	quicksort/1, 
	pythag/1, 
	perms/1, 
	odds_and_evens1/1, 
	odds_and_evens2/1,
	count_characters/1,
	count_characters/2]).

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

perms([]) -> [[]];
perms(L) -> [[H|T] || H <- L, T <- perms(L--[H])].

odds_and_evens1(L) ->
	Odds  = [X||X<-L, (X rem 2) =:=0],
	Evens = [X||X<-L, (X rem 2) =:=1],
	{Odds, Evens}.

odds_and_evens2(L) ->
	odds_and_evens_cal(L, [], []).

odds_and_evens_cal([H|T], Odds, Evens) ->
	if
	 (H rem 2) =:= 0 -> odds_and_evens_cal(T, [H|Odds], Evens);
	 (H rem 2) =:= 1 -> odds_and_evens_cal(T, Odds, [H|Evens])
	end;

odds_and_evens_cal([], Odds, Evens) ->
	{Odds, Evens}.

count_characters(Str) ->
	count_characters(Str, #{}).

count_characters([H|T], #{ H := N }=X) ->
	% io:format('ass map to X: X = ~w H = ~w N = ~w~n.', [X, H, N]),
	count_characters(T, X#{ H := N + 1});
count_characters([H|T], X) -> 
	% io:format('create new character: X = ~w, H = ~w ~n.', [X, H]),
	count_characters(T, X#{ H => 1 });
count_characters([], X) ->
	X.
	
