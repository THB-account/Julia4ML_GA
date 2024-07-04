function get_traveling_cost(cost_matrix::Matrix{<:Real}, traveling_order::Vector{<:Integer})
    if length(traveling_order) > length(Set(traveling_order))
        return sum(cost_matrix)
    end
    sum_costs = 0
    for (index, el) in enumerate(traveling_order)
        next_index = index + 1
        if next_index > length(traveling_order)
            next_index = 1
        end
        sum_costs += cost_matrix[traveling_order[index], traveling_order[next_index]]
    end
    return sum_costs
end

function init_tsp_population(population_size::Integer, cost_matrix::Matrix{<:Real}, rng)
    population = Vector{Vector{Int}}(undef, population_size)

    tspopulationSize = size(cost_matrix)[1]

    traveling_order = collect(1:tspopulationSize)

    min_cost = sum(cost_matrix)
    for i in 1:population_size
        population[i] = shuffle(rng, traveling_order)
        if get_traveling_cost(cost_matrix, population[i]) < min_cost
            min_cost = get_traveling_cost(cost_matrix, population[i])
        end
    end
    return population
end

"""
    solve_tsp(cost_matrix;
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

Solves the traveling salesman problem.
More information: https://en.wikipedia.org/wiki/Travelling_salesman_problem

- `cost_matrix`: cost matrix of traveling salesman problem.
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
function solve_tsp(cost_matrix::Matrix{<:Real};
    iterations=100, 
    time_limit=NaN, 
    obj_bound=NaN,
    populationSize=50,
    eliteSize=5,
    crossoverRate=0.6,
    mutationRate=0.4,
    selection=rank_selection, 
    mutation=displacement, 
    crossover=partially_mapped,
    rng=default_rng())

    initpop = init_tsp_population(populationSize, cost_matrix, rng)

    fitnessFun = x -> get_traveling_cost(cost_matrix, x)

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
    return best_solution, get_traveling_cost(cost_matrix, best_solution)
end