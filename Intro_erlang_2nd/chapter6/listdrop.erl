-module (listdrop).
-export ([fall/1]).

falls(List) -> falls(List, []).
falls([], Results) -> Results;
falls([Head|Tail], Results) ->
	falls(Tail, [drop:fall_velocity(Head) | Results]).
