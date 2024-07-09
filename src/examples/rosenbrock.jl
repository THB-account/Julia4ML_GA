"""
    solve_rosenbrock(a, b;
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

Solves the rosenbrock problem. Minimizes the function ``(a-x)^2 + b*(y-x^2)^2``.
The global minimum ``(x,y)`` is at ``(a,a^2)``.
More information: https://en.wikipedia.org/wiki/Rosenbrock_function

- `a`: First parameter of rosenbrock function.
- `b`: Second parameter of rosenbrock function.
- `starting_point`: Start point + gaussian noise.
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
function solve_rosenbrock(a::Real, b::Real; starting_point::AbstractVector=Float64[0.,0.],
    iterations=1000, 
    time_limit=NaN, 
    obj_bound=NaN,
    populationSize=100,
    eliteSize=5,
    crossoverRate=0.4,
    mutationRate=0.6,
    selection=roulette_wheel_inv, 
    mutation=gaussian_displacement, 
    crossover=k_point,
    rng=default_rng())

    initpop = init_gaussian(populationSize, starting_point, rng)

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
        time_limit=time_limit,
        obj_bound=obj_bound,
        rng=rng
    )

    best_solution = argmin(result)[1]
    return best_solution
end