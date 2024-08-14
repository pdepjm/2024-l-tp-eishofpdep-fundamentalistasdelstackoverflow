
% Punto 1 %
jugador(ana,romanos).
jugador(beto,incas).
jugador(carola,romanos).
jugador(dimitri,romanos).
jugador(elsa).

desarrollo(ana,herreria).
desarrollo(ana,forja).
desarrollo(ana,emplumado).
desarrollo(ana,laminas).

desarrollo(beto,herreria).
desarrollo(beto,forja).
desarrollo(beto,fundicion).

desarrollo(carola,herreria).

desarrollo(dimitri,herreria).
desarrollo(dimitri,fundicion).
% Punto 1 %

% Punto 2 %
romanoOMetalero(Jugador) :- 
    desarrollo(Jugador,fundicion).
romanoOMetalero(Jugador) :- 
    jugador(Jugador, romanos).

expertoEnMetales(Jugador):-
    desarrollo(Jugador,herreria),
    desarrollo(Jugador,forja),
    romanoOMetalero(Jugador).
% Punto 2 %

% Punto 3 %
esPopular(Civilizacion):-
    jugador(Jugador1,Civilizacion),
    jugador(Jugador2,Civilizacion),
    Jugador1 \= Jugador2.
% Punto 3 %

% Punto 4 %
alcanceGlobal(Tecnologia):-
    desarrollo(_,Tecnologia),
    forall(jugador(Jugador,_), desarrollo(Jugador,Tecnologia)).
% Punto 4 %

% Punto 5 %
esLider(Civilizacion):-
    jugador(_,Civilizacion),
    forall(desarrollo(_,Tecnologia), alcanzo(Civilizacion,Tecnologia)).

alcanzo(Civilizacion,Tecnologia):-
    jugador(Jugador,Civilizacion),
    desarrollo(Jugador,Tecnologia).
% Punto 5 %

% Punto 6 %
unidades(ana, jinete(jinete1, caballo)).
unidades(ana, piquero(piquero1, nivel(1), escudo)).
unidades(ana, piquero(piquero2, nivel(2), noEscudo)).
unidades(beto, campeon(campeon1, vida(100))).
unidades(beto, campeon(campeon2, vida(80))).
unidades(beto, piquero(piquero3, nivel(1), escudo)).
unidades(beto, jinete(jinete2, camello)).
unidades(carola, piquero(piquero4, nivel(3), noEscudo)).
unidades(carola, piquero(piquero5, nivel(2), escudo)).
unidades(dimitri).

jinete(Jinete, Animal) :-
    unidades(_, jinete(Jinete, Animal)).
piquero(Piquero, nivel(Nivel), Escudo) :-
    unidades(_, piquero(Piquero, nivel(Nivel), Escudo)).
campeon(Campeon, Vida) :-
    unidades(_, campeon(Campeon, vida(Vida))).

% Punto 6 %

% Punto 7 %
vida(Campeon, Vida) :-
    campeon(Campeon, Vida).

vida(Jinete, 90) :-
    jinete(Jinete, caballo).

vida(Jinete, 80) :-
    jinete(Jinete, camello).

vidaPiquero(Piquero, 50) :-
    piquero(Piquero, nivel(1), _).

vidaPiquero(Piquero, 65) :-
    piquero(Piquero, nivel(2), _).

vidaPiquero(Piquero, 70) :-
    piquero(Piquero, nivel(3), _).

vida(Piquero, Vida) :-
    piquero(Piquero, _, escudo),
    vidaPiquero(Piquero, VidaAux),
    Vida is VidaAux * 1.1.

vida(Piquero, Vida) :-
    piquero(Piquero, _, noEscudo),
    vidaPiquero(Piquero, Vida).

tieneMasVidaQue(Unidad1, Unidad2) :-
    vida(Unidad1, Vida1),
    vida(Unidad2, Vida2),
    Vida1 >= Vida2.

esUnidadDe(Jugador, Unidad) :-
    unidades(Jugador, piquero(Unidad, _, _)).
esUnidadDe(Jugador, Unidad) :-
    unidades(Jugador, campeon(Unidad, _)).
esUnidadDe(Jugador, Unidad) :-
    unidades(Jugador, jinete(Unidad, _)).

unidadConMasVida(Jugador, UnidadMejor) :-
    esUnidadDe(Jugador, UnidadMejor),
    forall(esUnidadDe(Jugador, Unidad), tieneMasVidaQue(UnidadMejor, Unidad)).
% Punto 7 %

% Punto 8 %
leGana(Campeon, Piquero) :-
    campeon(Campeon, _),
    piquero(Piquero, _, _).

leGana(Jinete, Campeon) :-
    jinete(Jinete, _),
    campeon(Campeon, _).

leGana(Piquero, Jinete) :-
    piquero(Piquero, _, _),
    jinete(Jinete, _).

leGana(JineteA, JineteB) :-
    jinete(JineteA, camello),
    jinete(JineteB, caballo).

noHayVentaja(Unidad1, Unidad2) :-
    campeon(Unidad1, _),
    campeon(Unidad2, _).
noHayVentaja(Unidad1, Unidad2) :-
    piquero(Unidad1, _, _),
    piquero(Unidad2, _, _).
noHayVentaja(Unidad1, Unidad1) :-
    jinete(Unidad1, camello),
    jinete(Unidad2, camello).
noHayVentaja(Unidad1, Unidad2) :-
    jinete(Unidad1, caballo),
    jinete(Unidad2, caballo).

leGana(Unidad1, Unidad2) :-
    noHayVentaja(Unidad1, Unidad2),
    vida(Unidad1, Vida1),
    vida(Unidad2, Vida2),
    Vida1 > Vida2.
% Punto 8 %

% Punto 9 %
cantidadPiqueros(Jugador, Cantidad, Escudo) :-
    jugador(Jugador, _),
    findall(P, (esUnidadDe(Jugador, P), piquero(P, _, Escudo)) ,Piqueros),
    length(Piqueros, Cantidad).

sobreviveAsedio(Jugador) :-
    jugador(Jugador, _),
    cantidadPiqueros(Jugador, ConEscudo, escudo),
    cantidadPiqueros(Jugador, SinEscudo, noEscudo),
    ConEscudo > SinEscudo.
% Punto 9 %

% Punto 10 %
dependencia(herreria).
dependencia(emplumado, herreria).
dependencia(punzon, emplumado).

dependencia(molino).
dependencia(collera, molino).
dependencia(arado, collera).

dependencia(laminas, herreria).
dependencia(malla, laminas).
dependencia(placas, malla).

dependencia(forja, herreria).
dependencia(fundicion, forja).
dependencia(horno, fundicion).

tecnologia(Tecnologia) :-
    dependencia(Tecnologia).
tecnologia(Tecnologia) :-
    dependencia(Tecnologia, _).

revisarDependencias(_, Tecnologia) :-
    dependencia(Tecnologia).

revisarDependencias(Jugador, Tecnologia) :-
    dependencia(Tecnologia, Dependencia),
    desarrollo(Jugador, Dependencia),
    revisarDependencias(Jugador, Dependencia).

puedeDesarrollar(Jugador, Tecnologia) :-
    jugador(Jugador,_),
    tecnologia(Tecnologia),
    not(desarrollo(Jugador, Tecnologia)),
    revisarDependencias(Jugador, Tecnologia).
% Punto 10 %