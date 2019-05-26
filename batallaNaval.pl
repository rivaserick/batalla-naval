#!/usr/bin/env gprolog --consult-file

% Simplest possible battleship game:
%   - single player
%   - one ship, hardcoded at position row 2, col 1
%   - loop endlessly until you hit the ship

board([[0, 0],
       [1, 0]]).

row_at(X, Row) :-
  board(Board),
  nth(X, Board, Row).

column_at(Y, Row, Cell) :-
  nth(Y, Row, Cell).

ship_at(X, Y) :-
  row_at(X, Row),
  column_at(Y, Row, Cell),
  Cell = 1.

fire_at(X, Y, State) :-
  (ship_at(X, Y) ->
    write('¡Buen disparo!'), nl, nl;
    write('Dispara de nuevo'), nl, nl).

prompt_number(Prompt, Number) :-
  write(Prompt),
  write(': '),
  read_integer(Number).

:- initialization(main).
main :-
  repeat,
  write('#######################################').
  write('     Bienvenidos a Batalla Naval').
  write('#######################################').
  nl,prompt_number('Ingresa la fila a donde quieres disparar: ', Row),
  nl,prompt_number('Ingresa la columna de disparo: ', Col),
  fire_at(Row, Col, State),
  (ship_at(Row, Col) ->
    write('¡Ganaste!'), nl, halt ;
    write('Sigue intentando...'), nl, fail).
