"""
    solve_knapsack(mass, utility, maxMass;
    iterations, 
    time_limit, 
    obj_bound,
    populationSize,
    eliteSize,
    crossoverRate,
    mutationRate,
    selection, 
    mutation, 
    crossover,
    rng)

Solves the knapsack problem.
More information: https://en.wikipedia.org/wiki/Knapsack_problem

- `mass`: Mass of each item.
- `utility`: Utility of each item.
- `maxMass`: Maximum mass of all items in knapsack.
- `max_iterations`: Maximum number of iterations in optimisation process. Default is `NaN`.
- `time_limit`: Time in seconds after which the optimization should be terminated. Default is `NaN`.
- `obj_bound`: Threshold on (or after) which the optimization should be terminated. Default is `NaN`.
- `rng`: An instance of a random number generator to produce reproducible results.
- `population_size`: Number of populants to be maintained.
- `eliteSize`: Number of populants selected as elite.
- `crossoverRate`: Probability of crossover for two populants.
- `mutationRate`: Probability of mutation.
- `selection`: Function to select populants for next iteration.
- `muation`: Mutation function.
- `crossover`: Crossover function.
- `rng`: An instance of a random number generator to produce reproducible results.

Returns optimization result
"""
function solve_knapsack(mass::Vector{<:Real}, utility::Vector{<:Real}, maxMass::Real;
    iterations=100, 
    time_limit=NaN, 
    obj_bound=NaN,
    populationSize=50,
    eliteSize=5,
    crossoverRate=0.8,
    mutationRate=0.8,
    selection=roulette_wheel, 
    mutation=bit_inversion, 
    crossover=k_point,
    rng=default_rng())


    initpop = init_uniform_binary_population(populationSize, length(mass), rng)

    fitnessFun = n -> (sum(mass .* n) <= maxMass) ? -sum(utility .* n) : -0.001

    result = Julia4ML_GA.optimize(
        initpop,
        x -> fitnessFun(x),
        Julia4ML_GA.GeneticAlgorithm(
            populationSize=populationSize,
            selection=selection,
            mutation=mutation,
            crossover=crossover,
            eliteSize=eliteSize,
            crossoverRate=crossoverRate,
            mutationRate=mutationRate
        );
        iterations=iterations,
        time_limit=time_limit, 
        obj_bound=obj_bound,
        rng=rng
    )

    best_solution = argmin(result)[1]
    return best_solution
end