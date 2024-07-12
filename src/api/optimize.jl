
"""
    optimize(
        starting_population::AbstractArray,
        objective::Function,
        ga::GeneticAlgorithm;
        iterations::Real = 100, 
        time_limit::Real = NaN, 
        obj_bound::Real = NaN,
        trace_optimization::Bool = false,
        rng::AbstractRNG = default_rng()
    )

Executes optimization process.
Population is initialized and build. 
Then the optimization is executed using the provided fitness function.

- `starting_point`: Initial candidate.
- `objective`: Fitness function to evaluate population. 
- `ga`: GeneticAlgorithm
- `iterations`: Maximum number of iterations. Termination condition.
- `time_limit`: Time limit in seconds. Termination condition.
- `obj_bound` : Lower bound to objective value. Termination condition.
- `rng`: Instance of a random number generator to produce reproducible results.

Returns final population's fittest populant.
"""
function optimize(
    starting_population::AbstractArray,
    objective::Function,
    ga::GeneticAlgorithm;
    iterations::Real = 100, 
    time_limit::Real = NaN, 
    obj_bound::Real = NaN,
    trace_optimization::Bool = false,
    rng::AbstractRNG = default_rng()
)
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
