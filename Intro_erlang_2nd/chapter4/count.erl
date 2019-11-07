-module(count).
-export([countdown/1, countup/2]).

countdown(From) when From > 0 ->
    io:format("~w!~n", [From]),
    countdown(From-1);
countdown(From) ->
    io:format("blastoff!~w!~n", [From]).

countup(Count, Limit) when Count =< Limit ->
    io:format("~w!~n", [Count]),
    countup(Count+1, Limit);

countup(Count, Limit) ->
    io:format("Finished.~w~w~n", [Count, Limit]).