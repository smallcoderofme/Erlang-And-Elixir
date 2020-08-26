-module(list_test).
-export([concat/0, get/0]).

concat() ->
    ThingsToBuy = [{apples, 10}, {pears, 6}, {milk, 3}],
    io:format("ThingsToBuy: ~w!~n", [ThingsToBuy]),
    ThingsToBuy1 = [{oranges, 4}, {newspaper, 1}|ThingsToBuy],
    io:format("ThingsToBuy1: ~w!~n", [ThingsToBuy1]),
    io:format("[{oranges, 4}, {newspaper, 1}|ThingsToBuy]: ~w!~n", [ThingsToBuy1]).

get() -> 
    ThingsToBuy = [{apples, 10}, {pears, 6}, {milk, 3}],
    ThingsToBuy1 = [{oranges, 4}, {newspaper, 1}|ThingsToBuy],
    [Buy1|ThingsToBuy2]=ThingsToBuy1,
    io:format("Buy1:~w, ThingsToBuy2:~w!~n", [Buy1, ThingsToBuy2]).
