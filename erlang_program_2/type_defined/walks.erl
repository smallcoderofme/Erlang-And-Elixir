-module (walks).
-export ([plan_route/2]).
-export_type ([point/0]).
-type point()		::{integer(), integer()}.
-type route()		::[{go, direction(), integer()}].
-type direction()	::north | south | east | west.
-spec plan_route(point(), point()) -> route().

plan_route({X1, Y1}, {X2, Y2}) -> [{go, north, X1 + X2 + Y1 + Y2}].