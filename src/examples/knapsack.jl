function solve_knapsack(mass::Vector{<:Real}, utility::Vector{<:Real}, maxMass::Real;
    iterations=100,
    populationSize=50,
    eliteSize=5,
    crossoverRate=0.8,
    mutationRate=0.1,
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
        rng=rng
    )

    best_solution = argmin(result)[1]
    return best_solution
end