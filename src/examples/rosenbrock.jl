function solve_rosenbrock(a::Real, b::Real;
    iterations=1000,
    populationSize=100,
    eliteSize=5,
    crossoverRate=0.4,
    mutationRate=0.6,
    selection=roulette_wheel_inv, 
    mutation=gaussian_displacement, 
    crossover=k_point,
    rng=default_rng())

    initpop = init_gaussian(Float64[0.,0.], populationSize, rng)

    fitnessFun = x -> (a-x[1])^2 +b*(x[2]-x[1]^2)^2

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