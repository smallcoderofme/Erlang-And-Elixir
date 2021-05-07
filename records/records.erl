-module (records).
-include ("records.hrl").
-export ([included/0]).

included() ->
	#inc{some_field="Some Value"}.