isa(dark_behemoth, skin).
isa(the_strings_of_suradan, c).
isa(stranger_in_the_wandering_isles, skin).

price(skin, 100).
rarity(skin, mythical).
attribute(skin, universal).
item_count(skin, 1).

rarity(the_strings_of_suradan, immortal).
attribute(dark_behemoth, strength).
attribute(the_strings_of_suradan, agility).
attribute(stranger_in_the_wandering_isles, agility).
item_count(the_strings_of_suradan, 2).
item_count(stranger_in_the_wandering_isles, 3).

rarity(X, Method):-
  isa(X, SuperX),
  rarity(SuperX, Method).

attribute(X, Method):-
  isa(X, SuperX),
  attribute(SuperX, Method).


item_count(X, Method):-
  isa(X, SuperX),
  item_count(SuperX, Method).

fact(Fact):- Fact,!.
fact(Fact) :- 
  Fact=..[Rel,Arg1,Arg2],
  isa(Arg1,SuperArg),
  SuperFact=..[Rel,SuperArg,Arg2],
  fact(SuperFact).
