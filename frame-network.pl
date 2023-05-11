skin(rarity, mythical).
skin(attribute, universal).
skin(price, 100).
skin(item_count, 1).

dark_behemoth(instance_of, skin).
dark_behemoth(item_count, 2).
dark_behemoth(attribute, strength).

the_strings_of_suradan(instance_of, skin).
the_strings_of_suradan(attribute, agility).

stranger_in_the_wandering_isles(instance_of, skin).
stranger_in_the_wandering_isles(attribute, agility).

parent(Frame, ParentFrame) :-
    (Query =.. [Frame, instance_of, ParentFrame]; Query =.. [Frame, instanse_of, ParentFrame]),
    call(Query).

value(Frame, Slot, Value) :-
    value(Frame, Frame, Slot, Value).

value(Frame, SuperFrame, Slot, Value) :-
    Query =.. [SuperFrame, Slot, Information],
    call(Query),
    process(Information, Frame, Value), !.
value(Frame, SuperFrame, Slot, Value) :-
    parent(SuperFrame, ParentSuperFrame),
    value(Frame, ParentSuperFrame, Slot, Value).

process(execute(Goal, Frame, Value), Frame, Value) :-
    call(Goal).
process(Value, _, Value).
