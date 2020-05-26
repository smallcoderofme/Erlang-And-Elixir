-module (overall).
-export ([product/1]).

product([]) -> 0;

product(List) -> product(List, 1).

product([], Prod) -> Prod;

product([Head|Tail], Prod) -> product(Tail, Head * Prod).
