parent(discount, purchase).
parent(promocode, purchase).
parent(delivery, purchase).
parent(purchase, refund).
parent(discount, like).
parent(delivery, like).

p(promocode, 0.02).
p(discount, 0.1).
p(delivery, 0.1).
p(purchase, [], 0.1).
p(purchase, [delivery], 0.2).
p(purchase, [promocode], 0.2).
p(purchase, [discount], 0.4).
p(purchase, [not(delivery)], 0.05).
p(purchase, [not(promocode)], 0.02).
p(purchase, [not(discount)], 0.05).
p(like, [discount], 0.2).
p(like, [not(discount)], 0.1).
p(like, [delivery], 0.3).
p(like, [not(delivery)], 0.2).
p(refund, [purchase], 0.05).

prob([X|Xs], Cond, P) :- !,
    prob(X, Cond, Px),
    prob(Xs, [X|Cond], PRest),
    P is Px * PRest.
prob([], _, 1) :- !.
prob(X, Cond, 1) :- member(X, Cond), !.
prob(X, Cond, 0) :- member(not(X), Cond), !.
prob(not(X), Cond, P) :- !,
    prob(X, Cond, P0),
    P is 1 - P0.
prob(X, Cond0, P) :-
    delete(Y, Cond0, Cond),
    predecessor(X, Y), !,
    prob(X, Cond, Px),
    prob(Y, [X|Cond], PyGivenX),
    prob(Y, Cond, Py),
    P is Px * PyGivenX / Py.
prob(X, _, P) :- p(X, P), !.
prob(X, Cond, P) :- !,
    findall((Cond1, Pi), p(X, Cond1, Pi), CPlist),
    sum_probs(CPlist, Cond, P).

sum_probs([], _, 0).
sum_probs([(Cond1, P1)|CondsProbs], Cond, P) :-
    prob(Cond1, Cond, PC1),
    sum_probs(CondsProbs, Cond, PRest),
    P is P1 * PC1 + PRest.

predecessor(X, not(Y)) :- !,
    predecessor(X, Y).
predecessor(X, Y) :- parent(X, Y).
predecessor(X, Z) :- parent(X, Y),
    predecessor(Y, Z).
member(X, [X|_]).
member(X, [_|L]) :- member(X, L).

delete(X, [X|L], L).
delete(X, [Y|L], [Y|L2]) :- delete(X, L, L2).
