-module (performance).

-export ([test_apply/3]).
-export ([test_m_fun/3]).

rec(Type, Max, Max, _M, _F, _A, StartTime) -> 
	Dur =erlang:system_time(microsecond) - StartTime,
	io:format("Call type: ~w timer cost: ~w. ~n", [Type, Dur]);

rec(Type, Curr, Max, M, F, A, StartTime) -> 
	case Type of
		"apply" ->
			apply(M,F,A);
		"m:f" ->
			drop:fall_velocity({earth, 12})
	end,
	rec(Type, Curr+1, Max, M, F, A, StartTime).



test_apply(M,F,A) ->
	rec("apply", 1, 10000, M, F, A, erlang:system_time(microsecond)).

test_m_fun(M,F,A) ->
	rec("m:f", 1, 10000, M, F, A, erlang:system_time(microsecond)).