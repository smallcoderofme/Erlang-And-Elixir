-module(tuple_test).
-export([define/0]).

define() ->
    F = { firstName, shuai },
    L = { lastName, sun},
    P = {person, F, L},
    io:format("Person of: ~w ~n", [P]),
    Point = {point, 10, 23},
    {point, X, Y} = Point,
    io:format("Point of: X = ~w, Y = ~w ~n", [X, Y]),
    Person = {person, {name, sun, shuai}, {age, 29}},
    {_,{_, Who, _}, _} = Person,
    io:format("Person name: ~w ~n", [Who]).