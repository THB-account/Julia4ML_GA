struct GeneticAlgorithm <: AbstractOptimizer
    populationSize
    eliteSize
    crossOverRate
    mutationRate
    selection
    mutation
    crossover


end

struct GeneticAlgorithmState <: AbstractState
    population
    populationFitness
end



"""

"""
function update_state!(parents, ga, state, ojbFunction, rng)
    # initialisation won't be handled here
    fitness = ga.populationSize
    # evaluate parents
    """
    pa
    """
    
    # perhaps do normalisation here
    selected_individuals = selection(parents,fitness,ga.selection,rng)



end

"""
control function for evaluation
"""
function evaluation!(parents,eval_f)
    map(eval_f,parents)
end

"""
control function for crossover
"""
function crossover!(parents,crossover_f,rng)

end
"""
control function for mutation
"""
function mutation!(offspring,mutation_f,rng)

end