/* Augustina Petraitytė, 4 kursas, 2 grupė */
/* Užduoties variantai: 2.3; 5.2 */

/* 2.3 studentas A yra vyresnis už kito kurso studentą B */

/* DUOMENYS */

/* studentas(Vardas, Kursas); */
studentas(adele, 1).
studentas(laura, 1).
studentas(martynas, 1).

studentas(kotryna, 2).
studentas(lukas, 2).
studentas(gediminas, 2).

studentas(matas, 3).
studentas(rasa, 3).
studentas(kamile, 3).

studentas(olegas, 4).
studentas(titas, 4).
studentas(ema, 4).

/* yraVyresnis(StudentoVardas1, StudentoVardas2). */

yraVyresnis(lukas, olegas).
yraVyresnis(olegas, kamile).
yraVyresnis(kamile, titas).
yraVyresnis(titas, rasa).
yraVyresnis(rasa, ema).
yraVyresnis(ema, matas).
yraVyresnis(matas, martynas).
yraVyresnis(martynas, gediminas).
yraVyresnis(gediminas, kotryna).
yraVyresnis(kotryna, adele).
yraVyresnis(adele, laura).

/* UŽDUOTIS */

skirtingiKursai(StudentasA, StudentasB) :- studentas(StudentasA, KursasA), studentas(StudentasB, KursasB), KursasA \= KursasB.

vyresnis(StudentasA, StudentasB) :- yraVyresnis(StudentasA, StudentasB).
vyresnis(StudentasA, StudentasC) :- yraVyresnis(StudentasA, StudentasB), vyresnis(StudentasB, StudentasC).

vyresnis_ir_kitas_kursas(StudentasA, StudentasB) :- 
    skirtingiKursai(StudentasA, StudentasB), 
    vyresnis(StudentasA, StudentasB).

/*
    ?- vyresnis_ir_kitas_kursas(olegas, kamile).         true
    ?- vyresnis_ir_kitas_kursas(titas, kotryna).         true
    ?- vyresnis_ir_kitas_kursas(laura, gediminas).       false, gediminas vyresnis už laurą
    ?- vyresnis_ir_kitas_kursas(rasa, matas).            false, rasa vyresnė, tačiau jie tame pačiame kurse
    ?- vyresnis_ir_kitas_kursas(lukas, Studentas).       visi jaunesni 1, 3 ir 4 kurso studentai (lukas yra 2 kurse)
*/


/* ---------------------------------------------------------------------------------------------------------------------------------------- */


/* 5.2 dalybos sveikoji dalis (div)*/

/* Kadangi paremta teigiamu daliniu ir teigiamu dalikliu, tai nustoja 
"rekursyviDalyba" kartotis, kai dalinys tampa mažesniu už daliklį */
rekursyviDalyba(Dalinys, Daliklis, Dalmuo, Dalmuo) :-
    Dalinys < Daliklis.

/* Rekursyviai atimamas daliklis iš dalinio. (Paremta teigiamu daliniu ir teigiamu dalikliu) */
rekursyviDalyba(Dalinys, Daliklis, LaikinasDalmuo, Dalmuo) :-
    Dalinys >= Daliklis,
    NaujasDalinys is Dalinys - Daliklis,
    NaujasLaikinasDalmuo is LaikinasDalmuo + 1,
    rekursyviDalyba(NaujasDalinys, Daliklis, NaujasLaikinasDalmuo, Dalmuo).

/* teigiamas div teigiamas = teigiamas */
dalyba(Dalinys, Daliklis, Dalmuo) :-
    Dalinys > 0, Daliklis > 0,
    rekursyviDalyba(Dalinys, Daliklis, 0, Dalmuo).

/* teigiamas div neigiamas = neigiamas */
dalyba(Dalinys, Daliklis, Dalmuo) :-
    Dalinys > 0, Daliklis < 0,
    rekursyviDalyba(Dalinys, -Daliklis, 0, LaikinasDalmuo),
    Dalmuo is -LaikinasDalmuo.

/* neigiamas div teigiamas = neigiamas */
dalyba(Dalinys, Daliklis, Dalmuo) :-
    Dalinys < 0, Daliklis > 0,
    rekursyviDalyba(-Dalinys, Daliklis, 0, LaikinasDalmuo),
    Dalmuo is -LaikinasDalmuo.

/* neigiamas div neigiamas = teigiamas */
dalyba(Dalinys, Daliklis, Dalmuo) :-
    Dalinys < 0, Daliklis < 0,
    rekursyviDalyba(-Dalinys, -Daliklis, 0, Dalmuo).

/* nulis div daliklis = nulis */
dalyba(0, Daliklis, Dalmuo) :-
    Dalmuo is 0.

/*
    ?- dalyba(18, 6, Div).      Div = 3.
    ?- dalyba(18, -6, Div).     Div = -3.
    ?- dalyba(-18, -6, Div).    Div = 3.
    ?- dalyba(-18, 6, Div).     Div = -3.
    ?- dalyba(0, 6, Div).       Div = 0.
    ?- dalyba(-18, 0, Div).     false - dalyba iš nulio negalima
*/