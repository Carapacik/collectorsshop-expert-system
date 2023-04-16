cond(0,"The International 2022").
cond(1,"Aghanims Labyrinth").
cond(2,"The International 2016").
cond(3,"Подписка Dota Plus").

cond(4,"Mythical").
cond(5,"Immortal").
cond(6,"Common").

cond(7,"Ловкость").
cond(8,"Интеллект").
cond(9,"Сила").

cond(10,"Инструмент").
cond(11,"Набор").
cond(12,"Предмет").

cond(13,"С видео").
cond(14,"Без видео").

immutable_cond([0,1,2,3]).
immutable_cond([4,5,6]).
immutable_cond([7,8,9]).
immutable_cond([10,11,12]).
immutable_cond([13,14]).

item("Rising Glory", "999", [2,4,9,11,13]).
item("Pyrexae Polymorph Perfected", "699", [1,4,8,11,13]).
item("Dark Behemoth", "1499", [0,4,9,11,13]).
item("The strings of Suradan", "2699", [0,5,7,12,14]).
item("Blue Horizons", "999", [0,4,9,11,13]).
item("Crimson Dawn", "249", [0,4,9,11,13]).
item("Годовая подписка Dota+", "3050", [3,6,10,14]).

promt(Answer, Answers, AnswersNew, Q) :-
  member(Answer, ['y','yes']),
  append(Answers, [Q], AnswersNew), !.

promt(_, AnswersNew, AnswersNew, _).
  check(Answers, _) :-
  item(X, Y, Answers),
  nl,
  write('Скин найден, это - '),
  write(X),
  nl,
  write('Цена предмета: ' ),
  write(Y),
  nl.

check(Answers, Q) :-
  Q1 is Q + 1,
  run(Q1, Answers), !.

run(Q, Answers) :-
  cond(Q, Question),
  write("Скин обладает свойством - "), write( Question ), write("?"), nl,
  write("Впишите y или n"), nl,
  read(Answer),
  promt(Answer, Answers, AnswersNew, Q),
  check(AnswersNew, Q).

process(1):-
  run(0, []).
process(_) :-
  write( "Выход из программы" ).

main :-
  write( "1 - Начать поиск" ), nl,
  write( "0 - Выход" ), nl,
  read( Choice ),
  process( Choice ).
