-module(eval_list).

-export([test/0]).


eval({integer, _, Value}, Bindings) ->
    {ok, Value, Bindings};
eval({atom, _, Value}, Bindings) ->
    {ok, Value, Bindings};
eval({var, _, Var}, Bindings) ->
    case bindings:lookup(Var, Bindings) of
        {ok, Value} ->
            {ok, Value, Bindings};
        none ->
            {error, {unbound, Var}}
    end;
eval({nil, _}, Bindings) ->
    {ok, [], Bindings};
eval({cons, _, H, T}, Bindings) ->
    case eval(H, Bindings) of
        {ok, H1, Bindings1} ->
            case eval(T, Bindings1) of
                {ok, T1, Bindings2} ->
                    {ok, [H1|T1], Bindings2};
                Error ->
                    Error
            end;
        Error ->
            Error
    end.

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
    ok;
test(eval_var) ->
    {ok, 1, [{'X', 1}]} = eval_string("X.", [{'X', 1}]),
    {error, {unbound, 'X'}} = eval_string("X.", []),
    ok;
test(eval_list) ->
    {ok, [], []} = eval_string("[].", []),
    {ok, [1,2], []} = eval_string("[1,2].", []),
    {ok, [1,2], [{'X', 1}, {'Y', 2}]} = eval_string("[X,Y].", [{'X', 1}, {'Y', 2}]),
    ok.

test() ->
    test(eval_integer),
    test(eval_atom),
    test(eval_var),
    test(eval_list),
    ok.
