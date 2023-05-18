%%% COMPONENTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

component(temperature_knob, 'ROOT').
component(cooking_mode_knob, 'ROOT').
component(power_grid_connection, 'ROOT').
component(internal_light, 'ROOT').


%%% PROBLEMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

problem('Cooker does not turn on', 'ROOT').
problem('Cooker does not heat up', 'ROOT').
problem('Internal light is not working', 'ROOT').


%%% REASONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

reason('Cooker does not turn on', 'ROOT', 'Faulty power grid connection').
reason('Cooker does not turn on', 'ROOT', 'Faulty temperature knob').

reason('Cooker does not heat up', 'ROOT', 'Faulty temperature knob').
reason('Cooker does not heat up', 'ROOT', 'Faulty power grid connection').

reason('Internal light is not working', 'ROOT', 'Faulty internal light bulb').
reason('Internal light is not working', 'ROOT', 'Faulty power grid connection').

reason('Cooking mode is not changing', 'ROOT', 'Faulty mode knob').
reason('Cooking mode is not changing', 'ROOT', 'Fan is not moving').
reason('Cooking mode is not changing', 'ROOT', 'Fan is not moving').


%%% SOLUTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

solution('Power grid connection is not established', 'ROOT', 'Check if the power grid connection is properly established').
solution('Faulty temperature knob', 'ROOT', 'Inspect and replace the temperature knob if faulty').

solution('Faulty temperature knob', 'ROOT', 'Verify that the temperature knob is functioning correctly').
solution('Faulty power grid connection', 'ROOT', 'Ensure the power grid connection is working and supplying power to the cooker').

solution('Faulty internal light bulb', 'ROOT', 'Replace the internal light bulb if faulty').
solution('Faulty power grid connection', 'ROOT', 'Check if the power grid connection is providing power to the cooker').


%%% PRINTING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

solve_problem(Problem) :-
    problem(Problem, 'ROOT'),
    format('Problem: '), write(Problem), nl, nl,
    print_reason_solution_pairs(Problem, 'ROOT', _).

print_reason_solution_pairs(Problem, _, Reason) :-
    reason(Problem, 'ROOT', Reason),
    print_reason(Reason),
    print_solutions(Reason, 'ROOT'), nl,
    fail.

print_reason_solution_pairs(_, _, _).

print_reason(Reason) :-
    format('    Reason:   '), write(Reason), nl.

print_solutions(Reason, _) :-
    solution(Reason, 'ROOT', Solution),
    format('        Solution: '), write(Solution), nl,
    fail.

print_solutions(_, _).

%
:- discontiguous solve_problem/1.
solve_problem(problems(Index)) :-
    problems(Index, Problem),
    solve_problem(Problem).

problems :-
    findall(Problem, problem(Problem, 'ROOT'), Problems),
    print_problems(Problems).

problems(Index) :-
    integer(Index),
    findall(Problem, problem(Problem, 'ROOT'), Problems),
    nth1(Index, Problems, Problem),
    format('Problem ~w: ~w~n', [Index, Problem]).

print_problems([]).
print_problems([Problem|Rest]) :-
    write('- '), write(Problem), nl,
    print_problems(Rest).

problems(Index, Problem) :-
    integer(Index),
    findall(P, problem(P, 'ROOT'), Problems),
    nth1(Index, Problems, Problem).

:- discontiguous problems/1.
problems(Problems) :-
    findall(Problem, problem(Problem, 'ROOT'), Problems).


%%% COMMANDS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%?- problems
%?- problems(1)
%?- solve_problem('Cooker does not turn on').
%?- solve_problem(problems(1)).

