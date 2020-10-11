-module (name_server1).
-export ([init/0, add/2, find/1, handle/2]).
-import (server3, [rpc/2]).


add( Name, Place ) ->
	io:format("name add ~w~n", [self()]),
	rpc( name_server, { add, Name, Place }).


find(Name) ->
	io:format("name find ~w~n", [self()]),
	rpc( name_server, { find, Name }).

% callback
init() ->
 	io:format("name init ~w~n", [self()]),
	dict:new().

handle({ add, Name, Place }, Dict) ->
	{ ok, dict:store(Name, Place, Dict) };

handle({ find, Name }, Dict ) ->
	{ dict:find(Name, Dict), Dict}.

% 4> server1:start(name_server, name_server).
% true
% 5> name_server:add(joe, "at home").
% ok
% 6> name_server:find(joe).
% {ok,"at home"}