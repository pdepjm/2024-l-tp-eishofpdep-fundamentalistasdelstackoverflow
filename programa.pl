
% Punto 1 %
jugador(ana,romanos).
jugador(beto,incas).
jugador(carola,romanos).
jugador(dimitri,romanos).
jugador(elsa).

desarrollo(ana,herreria).
desarrollo(ana,forja).
desarrollo(ana,emplumado).
desarrollo(ana,lamina).

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