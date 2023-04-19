% Category
property(0,"The International 2022").
property(1,"Aghanims Labyrinth").
property(2,"The International 2016").
property(3,"Подписка Dota Plus").

% Rarity
property(4,"Mythical").
property(5,"Immortal").
property(6,"Common").

% Attribute
property(7,"Ловкость").
property(8,"Интеллект").
property(9,"Сила").

% Type
property(10,"Инструмент").
property(11,"Набор").
property(12,"Предмет").

% Video
property(13,"С видео").
property(14,"Без видео").

property_group([0,1,2,3]).
property_group([4,5,6]).
property_group([7,8,9]).
property_group([10,11,12]).
property_group([13,14]).

item("Rising Glory", 999, [2,4,9,11,13]).
item("Pyrexae Polymorph Perfected", 699, [1,4,8,11,13]).
item("Dark Behemoth", 1499, [0,4,9,11,13]).
item("The strings of Suradan", 2699, [0,5,7,12,14]).
item("Blue Horizons", 999, [0,4,9,11,13]).
item("Crimson Dawn", 249, [0,4,9,11,13]).
item("Year Dota+", 3050, [3,6,9,10,14]).

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
