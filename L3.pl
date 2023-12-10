/* Augustina Petraitytė, 4 kursas, 2 grupė */
/* Užduoties variantai: 1.9; 2.8; 3.2; 4.4 */


/* 1.9  knelyg(S,K) - skaičių sąrašo S nelyginių elementų kiekis yra K. */

knelyg([], 0).

knelyg([H|T], K) :-
    H mod 2 =:= 1,  % Tikriname, ar H nelyginis
    knelyg(T, K1), !,
    K is K1 + 1.

knelyg([H|T], K) :-
    H mod 2 =:= 0,  % Tikriname, ar H lyginis
    knelyg(T, K), !.

/* PAVYZDŽIAI

?- knelyg([2,2,2],K). 
K = 0.

?- knelyg([1,2,3,7,8,7,7,14], K). 
K = 5.

?- knelyg([1,8,3,7,5,2],5).       
false.                      - nes K = 4

knelyg([1,8,3,7,5,2],4). 
true.
*/





/* 2.8 i_pozicija(S,I,K,R) - sąrašas R gautas į duotąjį sąrašą S, prieš I-ąjį elementą įterpus K. */

i_pozicija(S, 1, K, [K|S]).

i_pozicija([H|T], I, K, [H|R]) :-
    I > 1,
    I1 is I - 1,
    i_pozicija(T, I1, K, R), !.

/* PAVYZDŽIAI

?- i_pozicija([1,2,8,9,7,6,3,1],6,900,R).          
R = [1, 2, 8, 9, 7, 900, 6, 3, 1]

?- i_pozicija([1,2,8,9],1,1000,R).         
R = [1000, 1, 2, 8, 9]

?- i_pozicija([1,2,3],2,8,[1,8,2,3]). 
true.

?- i_pozicija([20,2],5,123,R). 
false.                          - sąrašas S turi tik 2 elementus, tad negali įterpti į 5 poziciją
*/





/*
    3.2  bendri(S1,S2,R) - sąrašas R susideda iš bendrų duotųjų sąrašų S1 ir S2 elementų. Pavyzdžiui:
    ?- bendri([a,b,c,d],[d,b,e],R).
    R = [b,d].
*/

bendri([], _, []).

bendri([H|T], S2, [H|R]) :-
    priklauso_sarasui(H, S2), !,
    bendri(T, S2, R).

bendri([_|T], S2, R) :- bendri(T, S2, R).

priklauso_sarasui(X, [X|_]).

priklauso_sarasui(X, [_|T]) :- priklauso_sarasui(X, T).

/* PAVYZDŽIAI

?- bendri([a,b],[d,b,e],R).        
R = [b].

?- bendri([k,l],[d,b,e],R). 
R = [].

bendri([k, l],[],R).
R = [].

?- bendri([],[d,b,e],R).
R = [].
*/





/*
    4.4  skirt(S1,S2,Skirt) - S1 ir S2 yra skaičiai vaizduojami skaitmenų sąrašais. 
    Skirt - tų skaičių skirtumas vaizduojama skaitmenų sąrašu. Laikykite, kad S1 yra ne mažesnis už S2.
*/

skirt(S1, S2, Skirt) :-
    sarasas_i_skaiciu(S1, R1),
    sarasas_i_skaiciu(S2, R2),
    R is R1 - R2,
    skaicius_i_sarasa(R, Skirt), !.

skaicius_i_sarasa(R, Skirt) :- skaicius_i_sarasa(R, [], Skirt).

skaicius_i_sarasa(0, Skirt, Skirt).

skaicius_i_sarasa(S, Sarasas, Skirt) :-
    Skaicius is S mod 10,
    i_pozicija(Sarasas, 1, Skaicius, Sarasas1),
    S1 is S div 10,
    skaicius_i_sarasa(S1, Sarasas1, Skirt).

sarasas_i_skaiciu(S, Rezultatas) :- sarasas_i_skaiciu(S, 0, Rezultatas).

sarasas_i_skaiciu([H|T], Prefix, Rezultatas) :-
    Prefix1 is Prefix * 10 + H,
    sarasas_i_skaiciu(T, Prefix1, Rezultatas).

sarasas_i_skaiciu([], Rezultatas, Rezultatas).

/* PAVYZDŽIAI

?- skirt([9,4,6],[4,4],Skirt).       
Skirt = [9, 0, 2].

?- skirt([9,4,6],[],Skirt).    
Skirt = [9, 4, 6].

?- skirt([1,0,0],[1,0,0],Skirt). 
Skirt = [].
*/