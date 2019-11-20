-module (types).
-export ([test/1]).

test(Iter) ->
	_ = Iter + 1,
	atom1().

% Atom
atom1() ->
	bit_string(),
	io:format("Type Atom: ~w. ~n", [atom1]).

% Bit String
bit_string() ->
	tuple1(),
	Bin1 = <<10, 20>>,
	X = binary_to_list(Bin1),
	io:format("Type Bit String ~w. ~n", [X]).

% Tuple
tuple1() ->
	map1(),
	P = {john, 24, {june, 25}},
	io:format("Type Tuple ~w. ~n", [tuple_size(P)]).

% Map
map1() -> 
	list1(),
	M1 = #{name=>john, age=>25},
	io:format("Type Map: ~w. ~n", [map_size(M1)]).

% List
list1() ->
	L = [10, 20 , 30],
	io:format("Type List: ~w. ~n", [length(L)]).
	

