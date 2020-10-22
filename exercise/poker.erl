-module (poker).
-export ([generate_poker/1]).
-include ("records.hrl").

generate_poker(I) when I > 0 ->
	V = I rem 13,
	Result = if
		I > 54 -> throw(poker_index_error);
		I == 54 -> #poker{ i=54, v=54, n=54, s=0, us=0 };
		I == 53 -> #poker{ i=53, v=53, n=53, s=0, us=0 };
		I < 53 -> "next"
	end,

	Ret = if
		Result == "next" ->
			if
				V == 0 -> #poker{ i=I, v=13, n=13, s=0, us=0}; 
				V == 1 -> #poker{ i=I, v=14, n=1, s=0, us=0};
				V == 2 -> #poker{ i=I, v=20, n=2, s=0, us=0};
				true   -> #poker{ i=I, v=V, n=V, s=0, us=0 }
			end;
		Result /= "next" -> 
			Result
	end,
	Ret.

