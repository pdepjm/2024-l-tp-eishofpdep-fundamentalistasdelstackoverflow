
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
expertoEnMetales(Jugador):-
    desarrollo(Jugador,herreria),
    desarrollo(Jugador,forja),
    desarrollo(Jugador,fundicion).

expertoEnMetales(Jugador):-
    desarrollo(Jugador,herreria),
    desarrollo(Jugador,forja),
    jugador(Jugador,romanos).
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
campeon(campeon1).
campeon(campeon2).
aCaballo(jinete1).
aCamello(jinete2).
piquero(piquero1, nivel(1)).
piquero(piquero2, nivel(2)).
piquero(piquero3, nivel(1)).
piquero(piquero4, nivel(3)).
piquero(piquero5, nivel(2)).
tieneEscudo(piquero1).
tieneEscudo(piquero3).
tieneEscudo(piquero5).

jinete(Unidad) :-
    aCaballo(Unidad).
jinete(Unidad) :-
    aCamello(Unidad).

unidades(ana, [jinete1, piquero1, piquero2]).
unidades(beto, [campeon1, campeon2, piquero3, jinete2]).
unidades(carola, [piquero4, piquero5]).
unidades(dimitri, []).
% Punto 6 %

% Punto 7 %
vida(campeon1, 100).
vida(campeon2, 80).

vida(Jinete, 90) :-
    aCaballo(Jinete).

vida(Jinete, 80) :-
    aCamello(Jinete).

vidaPiquero(Piquero, 50) :-
    piquero(Piquero, nivel(1)).

vidaPiquero(Piquero, 65) :-
    piquero(Piquero, nivel(2)).

vidaPiquero(Piquero, 70) :-
    piquero(Piquero, nivel(3)).

vida(Piquero, Vida) :-
    tieneEscudo(Piquero),
    vidaPiquero(Piquero, VidaAux),
    Vida is VidaAux * 1.1.

vida(Piquero, VidaAux) :-
    not(tieneEscudo(Piquero)),
    vidaPiquero(Piquero, VidaAux).

tieneMasVidaQue(Unidad1, Unidad2) :-
    vida(Unidad1, Vida1),
    vida(Unidad2, Vida2),
    Vida1 >= Vida2.

unidadConMasVida(Jugador, Unidad) :-
    unidades(Jugador,Cola),
    member(Unidad, Cola),
    forall(member(Miembro, Cola), tieneMasVidaQue(Unidad, Miembro)).
% Punto 7 %

% Punto 8 %
leGana(Campeon, Piquero) :-
    campeon(Campeon),
    piquero(Piquero,_).

leGana(Jinete, Campeon) :-
    jinete(Jinete),
    campeon(Campeon).

leGana(Piquero, Jinete) :-
    piquero(Piquero, _),
    jinete(Jinete).

leGana(JineteA, JineteB) :-
    aCamello(JineteA),
    aCaballo(JineteB).

noHayVentaja(Unidad1, Unidad2) :-
    campeon(Unidad1),
    campeon(Unidad2).
noHayVentaja(Unidad1, Unidad2) :-
    piquero(Unidad1, _),
    piquero(Unidad2, _).
noHayVentaja(Unidad1, Unidad2) :-
    aCaballo(Unidad1),
    aCaballo(Unidad2).
noHayVentaja(Unidad1, Unidad2) :-
    aCamello(Unidad1),
    aCamello(Unidad2).

leGana(Unidad1, Unidad2) :-
    noHayVentaja(Unidad1, Unidad2),
    vida(Unidad1, Vida1),
    vida(Unidad2, Vida2),
    Vida1 > Vida2.
% Punto 8 %

% Punto 9 %
cantidadPiqueros([Cabeza | Cola], ConEscudo, SinEscudo) :-
    piquero(Cabeza,_),
    tieneEscudo(Cabeza),
    cantidadPiqueros(Cola, ConEscudoAux , SinEscudo),
    ConEscudo is ConEscudoAux + 1.

cantidadPiqueros([Cabeza | Cola], ConEscudo, SinEscudo) :-
    piquero(Cabeza,_),
    not(tieneEscudo(Cabeza)),
    cantidadPiqueros(Cola, ConEscudo, SinEscudoAux),
    SinEscudo is SinEscudoAux + 1.

cantidadPiqueros([Cabeza | Cola], ConEscudo, SinEscudo) :-
    not(piquero(Cabeza,_)),
    cantidadPiqueros(Cola, ConEscudo, SinEscudo).

cantidadPiqueros([], 0, 0).

sobreviveAsedio(Jugador) :-
    unidades(Jugador, Cola),
    cantidadPiqueros(Cola, ConEscudo, SinEscudo),
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