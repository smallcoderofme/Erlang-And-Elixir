-module (overall).
-export ([product/1]).

product([]) -> 0;
product(List) -> product(List, 1).
product([], Product) -> Product;
product([Head|Tail], Product) -> product(Tail, Head * Product).