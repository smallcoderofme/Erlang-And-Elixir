-module (ml).
-export ([loop/1]).

-ifdef (debug_flag).
-define (DEBUG(X), io:format('DEBUG mod ~p: file ~p line ~p value ~p ~n', [?MODULE, ?FILE, ?LINE, X])).
-else.
-define (DEBUG(X), void).
-endif.

loop(0) ->
	done;
loop(N) ->
	?DEBUG(N),
	loop(N-1).