-module (rev).
-export ([reve/2]).

% reve([]) -> [];
% reve([H | T]) -> reve(T) ++ [H].

reve([X|T], Acc) -> reve(T, [X|Acc]);
reve([], Acc) -> Acc.