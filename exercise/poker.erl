-module (poker).
-export ([generate_poker/1]).
-include ("records.hrl").

generate_poker(I) when I > 0 ->
	V = I rem 13,
	Result = if
		I == 54 -> #poker{ index=54, value=54, num=54, selected=0, unselected=0 };
		I == 53 -> #poker{ index=53, value=53, num=53, selected=0, unselected=0 };
		I < 53 -> "next"
	end,

	Ret = if
		Result == "next" ->
			if
				V == 0 -> #poker{ index=I, value=13, num=13, selected=0, unselected=0}; 
				V == 1 -> #poker{ index=I, value=14, num=1, selected=0, unselected=0};
				V == 2 -> #poker{ index=I, value=20, num=2, selected=0, unselected=0};
				true   -> #poker{ index=I, value=V, num=V, selected=0, unselected=0 }
			end;
		Result /= "next" -> 
			Result
	end,
	Ret.

