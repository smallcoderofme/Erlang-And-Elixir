-module(eval_atom).

-export([test/0]).


eval({integer, _, Value}, Bindings) ->
    {ok, Value, Bindings};
eval({atom, _, Value}, Bindings) ->
    {ok, Value, Bindings}.

eval_string(S, Bindings) ->
    eval(parse_util:expr(S), Bindings).

test(eval_integer) ->
    {ok, 1, []} = eval_string("1.", []),
    {ok, 2, []} = eval_string("2.", []),
    {ok, 3, []} = eval_string("3.", []),
    ok;
test(eval_atom) ->
    {ok, a, []} = eval_string("a.", []),
    {ok, b, []} = eval_string("b.", []),
    {ok, c, []} = eval_string("c.", []),
    ok.

test() ->
    test(eval_integer),
    test(eval_atom),
    ok.
