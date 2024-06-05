struct GeneticAlgorithm <: AbstractOptimizer
    populationSize
    eliteSize
    crossoverRate
    mutationRate
    selection
    mutation
    crossover
    # TODO add methods here
    GeneticAlgorithm(;
        populationSize=50,
        eliteSize=5,
        crossoverRate=0.8,
        mutationRate=0.1,
        selection=,
        mutation=,
        crossover=
    ) = new(populationSize,
    eliteSize,
    crossoverRate,
    mutationRate,
    selection,
    mutation,
    crossover)
end

mutable struct GeneticAlgorithmState <: AbstractState
    population
    populationFitness

    function GeneticAlgorithmState(population,objective)
        new(population, objective.(population))        
    end
end

function initialise_genetic_state(starting_point,objective,ga,rng)
    return GeneticAlgorithmState(init_gaussian(starting_point,ga.populationSize,rng),objective)
end


"""

"""
function update_state!(ga, state, objective, rng)
    # initialisation won't be handled here
    populationSize = ga.populationSize
    eliteSize = ga.eliteSize
    parents = ga.population
    new_gen = similar(parents)
    selected_individuals = selection(parents,state.populationFitness,rng)

    # fill with crossover children
    crossover!(parents,new_gen,selected_individuals,ga.crossover,rng)

    # fill with elite children
    idxs = sortperm(state.fitness)
    eliteidx = populationSize - ga.eliteSize
    for i in 1:eliteSize
        new_gen[eliteidx+i] = copy(parents[idxs[i]])
    end

    mutation!(new_gen,ga,rng)

    state.population .= new_gen
    state.populationFitness .= evaluation!(ga,state,obective)
end

"""
control function for evaluation
"""
function evaluation!(ga,state,objective)
    state.populationFitness = objective.(individuals)
end

"""
control function for crossover
"""
function crossover!(parents,children,selected_individuals,ga,rng)
    s = selected_individuals
    for i in 1:2:length(selected_individuals)
        parent1, parent2 = i==length(selected_individuals) ? (i,i+1) : (i,i-1)

        if rand(rng)<ga.crossoverRate
            children[i],children[i+1] = ga.mutate(parent1,parent2,rng)
        else
            children[i],children[i+1] = parent1,parent2
        end
    end
end
"""
control function for mutation
"""
function mutation!(offspring,ga,rng)
    for i in 1:eachindex(offspring)
        if rand(rng)<ga.mutationRate
            offspring[i] = ga.mutation(offspring[i],rng)
        end
    end
end