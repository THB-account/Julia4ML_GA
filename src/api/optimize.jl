

function optimize(starting_point,objective,ga::GeneticAlgorithm;iterations=100,rng=default_rng)
    """
        1. initialize population
            1.1 build population
            1.2 initialize population
        2. evaluate population on objective and set state
        3. start optimization loop
    """
    Random.seed!(1234)
    # TODO needs to be changed to OS time
    rng = MersenneTwister(1234)
    state = initialise_genetic_state(starting_point,objective,ga,rng)


    for i in 1:iterations
        update_state!(parents, ga, state, objective, rng)
    end

    _,idx_fittest = findmax(state.populationFitness,dims=1)
    return state.population[idx_fittest] 
end