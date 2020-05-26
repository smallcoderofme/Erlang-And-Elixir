-module (record_drop).
-export ([fall_velocity/1]).
-include ("tower.hrl").

% fall_velocity(#tower{}=T) ->
	% fall_velocity(T#tower.planemo, T#tower.height).
fall_velocity(#tower{planemo=Name, height=Height}=T) ->
	io:format("From planemo ~p height ~p drop velocity ~p. ~n", [ Name, Height, fall_velocity(T#tower.planemo, T#tower.height)]).

fall_velocity(earth, Distance) when Distance >= 0 -> math:sqrt(2 * 9.8 * Distance);
fall_velocity(moon, Distance) when Distance >= 0 -> math:sqrt(2 * 1.6 * Distance);
fall_velocity(mars, Distance) when Distance >= 0 -> math:sqrt(2 * 3.71 * Distance).