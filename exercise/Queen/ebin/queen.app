{
	application, queen,
	[
		{description, "call me queen"},
		{vsn, "0.0.1"},
		{modules, [queen_app]},
		{registered, [queen_app]},
		{applications, [kernel, stdlib]},
		{mod, {queen_app, []}}
	]	
}.