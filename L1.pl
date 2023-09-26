/* Augustina Petraitytė, 4 kursas, 2 grupė */
/* Užduoties variantai: 4; 8; 29; 30 */

/*DUOMENYS*/

/* asmuo(Vardas, Lytis, Amžius, Pomėgis); */

asmuo(druella, moteris, 75, menas).
asmuo(cygnus, vyras, 75, skaityti).
asmuo(sirius, vyras, 50, skaityti).

asmuo(bellatrix, moteris, 54, protmusiai).
asmuo(tom, vyras, 59, futbolas).
asmuo(delphini, moteris, 29, muzika).
asmuo(matheo, vyras, 21, menas).

asmuo(narcissa, moteris, 52, menas).
asmuo(lucius, vyras, 56, futbolas).
asmuo(draco, vyras, 30, protmusiai).
asmuo(astoria, moteris, 29, sachmatai).
asmuo(scorpius, vyras, 8, futbolas).

asmuo(andromeda, moteris, 55, muzika).
asmuo(ed, vyras, 60, sachmatai).
asmuo(nymphadora, moteris, 33, augalai).
asmuo(remus, vyras, 36, skaityti).
asmuo(edward, vyras, 8, augalai).

/* mama(Mama, Vaikas); */

mama(druella, bellatrix).
mama(druella, andromeda).
mama(druella, narcissa).
mama(druella, sirius).

mama(bellatrix, delphini).
mama(bellatrix, matheo).

mama(andromeda, nymphadora).
mama(nymphadora, edward).

mama(narcissa, draco).
mama(astoria, scorpius).

/* pora(Vyras, Žmona). */

pora(cygnus, druella).
pora(tom, bellatrix).
pora(ed, andromeda).
pora(remus, nymphadora).
pora(lucius, narcissa).
pora(draco, astoria).

/*UŽDUOTYS*/

/* 4. sunus(Sunus, TevasMama) - Pirmasis asmuo (Sunus) yra antrojo (TevasMama) sūnus; */

sunus(Sunus, Mama) :- mama(Mama, Sunus), asmuo(Sunus, vyras, _, _).
sunus(Sunus, Tevas) :- pora(Tevas, Mama), sunus(Sunus, Mama).

/*
    ?- sunus(draco, narcissa).      true
    ?- sunus(draco, lucius).        true
    ?- sunus(matheo, tom).          true
    ?- sunus(scorpius, astoria).    true
    ?- sunus(nymphadora, ed).       false (nymphadora yra ed dukra)
    ?- sunus(remus, ed).            false (ed yra remus uošvis)
    ?- sunus(edward, ed).           false (edward yra ed anūkas)
    ?- sunus(Sunus, TevasMama).     visos sunaus ir tevo ar mamos kombinacijos
*/

/* 8. brolis_ir_sesuo(Brolis, Sesuo) - Pirmasis asmuo (Brolis) yra antrojo (Sesuo) brolis, o antrasis yra pirmojo sesuo */

brolis_ir_sesuo(Brolis, Sesuo) :-
    mama(Mama, Brolis), mama(Mama, Sesuo),
    asmuo(Brolis, vyras, _, _), asmuo(Sesuo, moteris, _, _).

/*
    ?- brolis_ir_sesuo(matheo, delphini).       true
    ?- brolis_ir_sesuo(sirius, andromeda).      true
    ?- brolis_ir_sesuo(sirius, narcissa).       true
    ?- brolis_ir_sesuo(sirius, nymphadora).     false (sirius yra nymphadora dėdė)
    ?- brolis_ir_sesuo(bellatrix, narcissa).    false (bellatrix ir narcissa - seserys)
    ?- brolis_ir_sesuo(draco, astoria).         false (draco ir astoria yra pora)
    ?- brolis_ir_sesuo(Brolis, Sesuo).          visos brolių ir seserų kombinacijos
*/

/* 29. bendraamziai(Asmuo1, Asmuo2) - Asmenys Asmuo1 ir Asmuo2 yra vienodo amžiaus*/

bendraamziai(Asmuo1, Asmuo2) :-
    asmuo(Asmuo1, _, Amzius, _), asmuo(Asmuo2, _, Amzius, _),
    Asmuo1 \= Asmuo2.

/*
    ?- bendraamziai(druella, cygnus).           true
    ?- bendraamziai(astoria, delphini).         true
    ?- bendraamziai(edward, scorpius).          true
    ?- bendraamziai(matheo, scorpius).          false (matheo 21, scorpius 8)
    ?- bendraamziai(lucius, sirius).            false (lucius 56, sirius 50)
    ?- bendraamziai(sirius, bellatrix).         false (sirius 50, bellatrix 54)
    ?- bendraamziai(Asmuo1, Asmuo2).            visos bendraamžių kombinacijos
*/

/* 30. nepilnametis(Nepilnametis) - Asmuo Nepilnametis yra jaunesnis, nei 18 metų */

nepilnametis(Nepilnametis) :- asmuo(Nepilnametis, _, Amzius, _), Amzius < 18.

/*
    ?- nepilnametis(scorpius).          true
    ?- nepilnametis(edward).            true
    ?- nepilnametis(draco).             false (draco 30)
    ?- nepilnametis(nymphadora).        false (nymphadora 33)
    ?- nepilnametis(Nepilnametis).      visi nepilnamečiai
*/