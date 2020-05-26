-module (bounce).
-export ([report/1]).

% report(Count) ->
% 	receive 
% 		X -> io:format("receive times: ~p input: ~p ~n.", [Count, X]),
% 			report(Count+1)
% 	end.

report(Count) ->
	NewCount = 
		receive
			X -> io:format("receive times: ~p input: ~p ~n.", [Count, X]),
				Count+1,
		end,
	report(NewCount).