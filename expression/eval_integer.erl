-module(eval_integer).

-export([test/0]).


eval({integer, _, Value}, Bindings) ->
    {ok, Value, Bindings}.

eval_string(S, Bindings) ->
    eval(parse_util:expr(S), Bindings).

test(eval_integer) ->
    {ok, 1, []} = eval_string("1.", []),
    {ok, 2, []} = eval_string("2.", []),
    {ok, 3, []} = eval_string("3.", []),
    ok.

test() ->
    test(eval_integer),
    ok.
