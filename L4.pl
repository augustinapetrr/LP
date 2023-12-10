/* Augustina Petraitytė, 4 kursas, 2 grupė */
/* Užduoties variantas: 4 */
/* UŽDUOTIS: Domino kauliukų dėstymas. Duotas domino kauliukų sąrašas. Nustatykite, kaip galima sudėti juos į uždarą grandinę. */


domino(Sarasas) :- 
    domino_seka(Sarasas,Rez), 
    uzdara_seka(Rez), !, 
    spausdinti(Rez), !.


domino_seka(Sarasas, Rez) :- domino_seka(Sarasas, _, Rez).

domino_seka([], _, []) :- !.

domino_seka(Seka, X, [X:Y|Rez]) :-
    select(Kauliukas, Seka, Likutis),
    ar_tinka(Kauliukas, X:Y),
    domino_seka(Likutis, Y, Rez).


ar_tinka(X:Y, X:Y).
ar_tinka(X:Y, Y:X).


uzdara_seka([X1:_|Likutis]) :- last(Likutis, _:Yn), X1==Yn.


spausdinti(Seka) :-
    /* patikrinti ar nelyginis skaičius kauliukų */
    length(Seka, Length),
    Length mod 2 =:= 1,
    /* paskaičiuojama kiek kauliukų viršuje ir jie išspausdinami */
    TempLength is (Length - 3) div 2,
    virsus(Seka, TempLength),
    /* tvarkomi ir spausdinami šonai */
    sonai_ir_apacia(Seka, Length, TempLength), !.


sonai_ir_apacia(Seka, Last, NotLast) :-
    index_kauliukas(Last, Seka, Item1), % kairėje
    index_kauliukas(NotLast + 1, Seka, Item2), % dešinės viršutinis
    index_kauliukas(NotLast + 2, Seka, Item3), % dešinės apatinis
    isskaidymas(Item2, X2, Y2),
    write(X2), nl,
    isskaidymas(Item3, X3, Y3),
    NewDice =.. [':', Y2, X3],
    append([], [Item1, NewDice], Sides),
    spausdinti_sonus(Sides, Last, NotLast, 1, 1), nl,
    reverse_pairs(Sides, SwapedSides),
    spausdinti_sonus(SwapedSides, Last, NotLast, 1, 1), nl, 
    TempLength is (Last - 3) div 2,
    apacia(Seka, TempLength, Last,  1, Apacia),
    reverse_both(Apacia, ReversedApacia),
    virsus(ReversedApacia, TempLength),
    write(Y3), !.


isskaidymas(X:Y, X, Y).


spausdinti(Seka, Rez) :-
    /* patikrinti ar lyginis skaičius kauliukų */
    length(Seka, Length),
    Length mod 2 =:= 0,
    /* paskaičiuojama kiek kauliukų viršuje ir jie išspausdinami */
    TempLength is (Length - 2) div 2,
    virsus(Seka, TempLength), nl,
    /* tvarkomi ir spausdinami šonai */
    sonai(Seka, Length, TempLength),
    /* atskiriama, apverčiama ir išspausdinama apačia */
    apacia(Seka, TempLength, Length,  1, Apacia),
    reverse_both(Apacia, ReversedApacia),
    virsus(ReversedApacia, TempLength).


virsus([], _).

virsus([X|List], Len) :-
    Len =:= 0, !.

virsus([X|List], Len) :-
    TempLength is Len - 1,
    write(X), write(' '),
    virsus(List, TempLength).


sonai(Seka, Last, NotLast) :-
    index_kauliukas(Last, Seka, Item1),
    index_kauliukas(NotLast + 1, Seka, Item2),
    append([], [Item1, Item2], Sides), 
    spausdinti_sonus(Sides, Last, NotLast, 1, 0), nl,
    reverse_pairs(Sides, SwapedSides),
    spausdinti_sonus(SwapedSides, Last, NotLast, 1, 0), nl, !.


spausdinti_sonus([_:Y|List], Length, Len, Temp, Status) :-
    Temp =:= 1,
    write(Y),
    NewTemp is Temp + 1,
    spausdinti_sonus(List, Length, Len, NewTemp, Status), !. 

% nelyginių tarpai
spausdinti_sonus(List, Length, Len, Temp, 1) :-
    Temp < (Len * 3 + Len + 1),
    NewTemp is Temp + 1,
    write(' '),
    spausdinti_sonus(List, Length, Len, NewTemp, 1), !. 

% nelyginių tarpai: išskirtinis atvejis 5
spausdinti_sonus(List, 5, Len, Temp, 1) :-
    Temp < 5,
    NewTemp is Temp + 1,
    write(' '),
    spausdinti_sonus(List, Length, Len, NewTemp, 1), !. 

% lyginių tarpai
spausdinti_sonus(List, Length, Len, Temp, 0) :-
    Temp < (Len * 3 + Len - 1),
    NewTemp is Temp + 1,
    write(' '),
    spausdinti_sonus(List, Length, Len, NewTemp, 0), !. 

% nelyginių tarpai: išskirtinis atvejis 4
spausdinti_sonus(List, 4, Len, Temp, 1) :-
    Temp < 3,
    NewTemp is Temp + 1,
    write(' '),
    spausdinti_sonus(List, Length, Len, NewTemp, 1), !. 

spausdinti_sonus([X:_|List], Length, Len, Temp, _) :-
    Temp =:= Length + 1,
    write(X), !.

% išskirtinis atvejis 5
spausdinti_sonus([X:_|List], 5, Len, Temp, _) :-
    Temp =:= 5,
    write(X), !.

% išskirtinis atvejis 4
spausdinti_sonus([X:_|List], 4, Len, Temp, _) :-
    Temp =:= 3,
    write(X), !.


apacia([], _, _, _, []).

apacia(_, _, FullLength, ApaciaLength, []) :-
    ApaciaLength =:= FullLength, !.

apacia([X|List], Length, FullLength, ApaciaLength, Rez) :-
    ApaciaLength =< Length + 1,
    NewApaciaLength is ApaciaLength + 1,
    apacia(List, Length, FullLength, NewApaciaLength, Rez), !.

apacia([X|List], Length, FullLength, ApaciaLength, [X|Rez]) :-
    ApaciaLength > Length + 1, 
    ApaciaLength < FullLength,
    NewApaciaLength is ApaciaLength + 1,
    apacia(List, Length, FullLength, NewApaciaLength, Rez), !.


index_kauliukas(1, [Item|_], Item).

index_kauliukas(Index, [_|Tail], Item) :-
    Index > 1,
    NextIndex is Index - 1,
    index_kauliukas(NextIndex, Tail, Item).


reverse_pairs([], []).
reverse_pairs([X:Y | Rest], [Y:X | NewRest]) :-
    reverse_pairs(Rest, NewRest).

reverse_list(List, ReversedList) :-
    reverse(List, ReversedList).

reverse_both(List, ReversedList) :-
    reverse_pairs(List, Temp),
    reverse_list(Temp, ReversedList).

/*
?- domino_seka([1:5,5:3,3:2,4:2,4:1,6:1,1:6], R). 
R = [1:5, 5:3, 3:2, 2:4, 4:1, 1:6, 6:1] .

?- domino([1:5,5:3,3:2,4:2,4:1,6:1,1:6]).
1:5 5:3 3
1       2
6       2
6:1 1:4 4
true.

?- domino_seka([1:5,5:3,3:2,4:2,6:1], R).         
R = [4:2, 2:3, 3:5, 5:1, 1:6] .

?- domino([1:5,5:3,3:2,4:2,6:1]).    
false.                                  - nėra uždara

?- domino_seka([1:5,3:2,6:1,5:2,3:6],R). 
R = [1:5, 5:2, 2:3, 3:6, 6:1] .

?- domino([1:5,3:2,6:1,5:2,3:6]). 
1:5 5
1   2
6   2
6:3 3
true.
*/