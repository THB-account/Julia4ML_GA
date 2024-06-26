
"""
    optimize(starting_point,objective,ga::GeneticAlgorithm;iterations=100,rng=default_rng())

    Executes optimization process

- `starting_point`: (Vector) Initial candidate.
- `objective`: (Function) Fitness function to evaluate population. 
- `iterations`: (Integer) Maximum number of iterations.
- `rng`: Instance of a random number generator to produce reproducible results. Default is `Random.default_rng()`.

Returns final population's fittest populant.

Population is initialized and build. 
Then the optimization is executed using the provided fitness function.
"""
function optimize(
    starting_population::A,
    objective,ga::GeneticAlgorithm;
    
    iterations::Int = 100, 
    time_limit=NaN, 
    obj_bound=NaN,
    
    trace_optimization::Bool = false,
    
    rng::AbstractRNG = default_rng()
) where {A<:AbstractArray}
    """
        1. initialize population
            1.1 build population
            1.2 initialize population
        2. evaluate population on objective and set state
        3. start optimization loop
    """
    trace = OptimizationTrace()

    terminator = Terminator(max_iter=iterations, time_limit=time_limit, obj_bound=obj_bound)

    if length(starting_population) != ga.populationSize
        throw(ArgumentError("starting_population must have length of GeneticAlgorithm::populationSize"))
    end
   
    #rng = MersenneTwister(1234)
    state = GeneticAlgorithmState(starting_population, objective)
    
    while terminate!(terminator, state)
        update_state!(ga, state, objective, rng)
        if trace_optimization
            append!(trace,state)
        end
    end

    min_fitness ,idx_fittest = findmin(state.populationFitness,dims=1)

    
    return OptimizationResult(state.population[idx_fittest] ,min_fitness,trace)
end
