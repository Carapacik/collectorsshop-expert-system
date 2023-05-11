isa(dark_behemoth, skin).
isa(the_strings_of_suradan, skin).
isa(stranger_in_the_wandering_isles, skin).

price(skin, 100).

rarity(skin, mythical).
rarity(the_strings_of_suradan, immortal).
rarity(X, Method) :-
    isa(X, SuperX),
    rarity(SuperX, Method).

attribute(skin, universal).
attribute(dark_behemoth, strength).
attribute(stranger_in_the_wandering_isles, agility).
attribute(the_strings_of_suradan, agility).
attribute(X, Method) :-
    isa(X, SuperX),
    attribute(SuperX, Method).

item_count(skin, 1).
item_count(dark_behemoth, 2).
item_count(stranger_in_the_wandering_isles, 3).
item_count(X, Method) :-
    isa(X, SuperX),
    item_count(SuperX, Method).

fact(Fact) :- Fact.
fact(Fact) :-
    Fact =.. [Rel, Arg1, Arg2],
    isa(Arg1, SuperArg),
    SuperFact =.. [Rel, SuperArg, Arg2],
    fact(SuperFact).
