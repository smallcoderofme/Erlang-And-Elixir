-module (str).
-export ([strcon/2]).

strcon(Str1, Str2)->
	string:concat(Str1, Str2).