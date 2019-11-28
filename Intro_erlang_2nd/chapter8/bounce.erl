-module (bounce).
-export ([report/1]).

report(Count) ->
	receive
		X -> io:format("Receive #~p: ~p~n", [Count, X]),
		% keep the process alive
		report(Count+1)
	end.