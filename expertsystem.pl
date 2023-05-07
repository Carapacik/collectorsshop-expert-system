% Category
property(0,"The International 2022").
property(1,"Aghanims Labyrinth").
property(2,"The International 2016").
property(3,"Dota Plus").

% Rarity
property(4,"Mythical").
property(5,"Immortal").
property(6,"Common").

% Attribute
property(7,"Strength").
property(8,"Agility").
property(9,"Intelligence").
property(10,"Universal").

% Type
property(11,"Set").
property(12,"Item").
property(13,"Tool").

% Video
property(14,"Have video").
property(15,"Without video").

property_group([0,1,2,3]).
property_group([4,5,6]).
property_group([7,8,9,10]).
property_group([11,12,13]).
property_group([14,15]).

item("Rising Glory", 999, [2,4,7,11,14]).
item("Stranger in the Wandering Isles", 699, [1,4,8,11,14]).
item("Dark Behemoth", 1499, [0,4,7,11,14]).
item("The strings of Suradan", 2699, [0,5,8,12,15]).
item("Blue Horizons", 999, [0,4,7,11,14]).
item("Pyrexae Polymorph Perfected", 699, [1,4,10,11,14]).
item("Year Dota Plus", 3050, [3,6,10,13,15]).

:- dynamic item/3.

ask_to_add_item(Answers) :-
  nl, write("Не удалось найти скин с указанными свойствами. Хотите добавить новый предмет с этими свойствами? (y/n)"), nl,
  read(Answer),
  (member(Answer, ['y', 'yes']) ->
    write("Введите название предмета: "), nl,
    read(ItemName),
    write("Введите цену предмета: "), nl,
    read(ItemPrice),
    assertz(item(ItemName, ItemPrice, Answers)),
    write("Новый предмет добавлен."), nl, nl
  ;
    write("Не добавлено."), nl, nl
  ).

check(Answers, _) :-
  item(X, Y, Answers), nl,
  write("Скин найден, это - "),  write(X), nl,
  write("Цена предмета - "), write(Y), nl,
  write("Свойства - "), write(Answers), nl, nl,
  main.
check(Answers, Q) :-
  property(Q, _),
  Q1 is Q + 1,
  run(Q1, Answers), !.
check(Answers, _) :-
  \+ item(_, _, Answers),
  ask_to_add_item(Answers), main, !.

last_in_same_group(Q) :-
  property_group(Group),
  member(Q, Group),
  Q1 is Q + 1,
  not(member(Q1, Group)).

belongs_to_same_group(Q1, Q2) :-
  property_group(Group),
  member(Q1, Group),
  member(Q2, Group).

answered_in_same_group(Answers, Q) :-
  member(Answer, Answers),
  belongs_to_same_group(Q, Answer).

prompt(Answer, Answers, AnswersNew, Q) :-
  (member(Answer, ['y','yes']) ->
    append(Answers, [Q], AnswersNew), !
  ;
    Q1 is Q + 1,
    last_in_same_group(Q1),
    append(Answers, [Q1], AnswersNew)
  ).
prompt(_, AnswersNew, AnswersNew, _).

run(Q, Answers) :-
  property(Q, Question),
  (answered_in_same_group(Answers, Q) ->
    check(Answers, Q)
  ;
    write("Скин обладает свойством - "), write( Question ), write("? (y/n)"), nl,
    read(Answer),
    prompt(Answer, Answers, AnswersNew, Q),
    check(AnswersNew, Q)
  ).

process(1):-
  run(0, []).
process(_) :-
  write("Выход из программы").

main :-
  write("1 - Начать поиск"), nl,
  write("0 - Выход"), nl,
  read(Choice),
  process(Choice).
