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
    # println(min_cost)
    return population
end

function solve_tsp(cost_matrix::Matrix{<:Real};
    iterations=100,
    populationSize=50,
    eliteSize=5,
    crossoverRate=0.8,
    mutationRate=0.1,
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
        rng=rng
    )

    best_solution = argmin(result)[1]
    return best_solution, get_traveling_cost(cost_matrix, best_solution)
end