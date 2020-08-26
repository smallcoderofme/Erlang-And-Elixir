-module(string_test).
-export([define/0]).

define() ->
    Name = "Sun",
    io:format("Name: ~w~n", [Name]),
    L = [83,117,114,112,114,105,115,101],
    L1 = [1,83,117,114,112,114,105,115,101],
    io:format("L: ~w~n", [L]),
    io:format("L1: ~w~n", [L1]),
    I = $S,
    io:format("I = $S : ~w~n", [I]),
    I1 = [I-32, $u, $p, $r, $i, $s, $e],
    io:format("I1: ~w~n", [I1]),
    X = "a\x{221e}b",
    io:format("~ts~n", [X]).
