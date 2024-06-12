
"""
Contains information and functions to execute an optimization process for a genetic algorithm.

- `population_size`: (Integer) Number of populants to be maintained.
- `eliteSize`: (Integer) Number of populants selected as elite.
- `crossoverRate`: (Float) Probability of crossover for two populants.
- `mutationRate`: (Float) Probability of mutation.
- `selection`: (Function) Function to select populants for next iteration.
- `muation`: (Function) Mutation function.
- `crossover`: (Function) Crossover function.

Constructor:

    GeneticAlgorithm(;
        populationSize=50,
        eliteSize=5,
        crossoverRate=0.8,
        mutationRate=0.1,
        selection=roulette_wheel,
        mutation=displacement,
        crossover=single_point
    ) 
"""
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
        selection=roulette_wheel,
        mutation=displacement,
        crossover=single_point
    ) = new(populationSize,
    eliteSize,
    crossoverRate,
    mutationRate,
    selection,
    mutation,
    crossover)
end

"""
State of a genetic algorithm.

- `population`: (Vector) Current population. Vector conatining elements of same type as starting point for optimization process.
- `populationFitness`: (Function) Fitness function by which the population's fitness is to be evaluated.

Constructor:

    GeneticAlgorithmState(population,objective)
"""
mutable struct GeneticAlgorithmState <: AbstractState
    population
    populationFitness

    function GeneticAlgorithmState(population,objective)
        new(population, objective.(population))        
    end
end

"""
    initialise_genetic_state(starting_point,objective,ga,rng)

Initialises populant's genes.

- `starting_point`: (Vector{Float64})
- `objective`: (Function) Fitness function to be used.
- `ga`: (GeneticAlgorithm) GeneticAlgorithm instance to work on.
- `rng`: Instance of a random number generator to produce reproducible results.

Returns GeneticAlgorithmState.
"""
function initialise_genetic_state(starting_point,objective,ga,rng)
    return GeneticAlgorithmState(init_gaussian(starting_point,ga.populationSize,rng),objective)
end

"""
    update_state!(ga, state, objective, rng)

Updates GeneticAlgorithmState according to provided GeneticAlgorithm instance.
Selection, crossover, mutation and evaluation is executed.
Equivalent to one iteration of the optimizatrion process.

- `ga`: (GeneticAlgorithm) GeneticAlgorithm instance to work on.
- `state`: (GeneticAlgorithmState) GeneticAlgorithmState to proceed from.
- `objective`: (Function) Fitness function to be used.
- `rng`: Instance of a random number generator to produce reproducible results.
"""
function update_state!(ga, state, objective, rng)
    # initialisation won't be handled here
    populationSize = ga.populationSize
    eliteSize = ga.eliteSize
    parents = state.population
    new_gen = similar(parents)
    nonEliteSize = populationSize - ga.eliteSize
    selected_individuals = ga.selection(state.populationFitness,nonEliteSize, rng)

    # fill with crossover children
    crossover!(parents,new_gen,selected_individuals,ga,rng)

    # fill with elite children
    idxs = sortperm(state.populationFitness)
    
    for i in 1:eliteSize
        new_gen[nonEliteSize+i] = copy(parents[idxs[i]])
    end

    mutation!(new_gen,ga,rng)

    state.population .= new_gen
    state.populationFitness .= evaluation!(ga,state,objective)
end

"""
    evaluation!(ga,state,objective)

Control function for fitness evaluation.
- `ga`: (GeneticAlgorithm) GeneticAlgorithm instance to work on.
- `state`:  (GeneticAlgorithmState) GeneticAlgorithmState instance to proceed from.
- `objective`: (Function) Fitness function by which the population is evaluated.
"""
function evaluation!(ga,state,objective)
    state.populationFitness .= objective.(state.population)
end

"""
    crossover!(parents,children,selected_individuals,ga,rng)

Control function for crossover.

- `parents`: (Vector) (Sub-)Population to be used to create offspring.
- `children` (Vector) Object to hold the newly created offspring.
- `selected_individuals`: (Vector{Integer}) The for crossover selected populant's indices.
- `ga`: (GeneticAlgorithm) GeneticAlgorithm instance the population is part of.
- `rng`:  Instance of a random number generator to produce reproducible results.
"""
function crossover!(parents,children,selected_individuals,ga,rng)
    s = selected_individuals
    N = length(selected_individuals)
    for i in 1:2:length(selected_individuals)
        parent1, parent2 = i!=N ? (i,i+1) : (i,i-1)
        selected_idx1 = selected_individuals[parent1]
        selected_idx2 = selected_individuals[parent2]
        parent1, parent2 = parents[selected_idx1],parents[selected_idx2]
        # TODO (Fix): selected_individuals[parent1] and selected_individuals[parent2] can be 0 

        if rand(rng) < ga.crossoverRate
            children[i],children[i+1] = ga.crossover(parent1,parent2,rng)
        else
            children[i],children[i+1] = parent1,parent2
        end
    end
end

"""
    mutation!(offspring,ga,rng)

control function for mutation.

- `population`: (Vector) (Sub-)Population to be mutated.
- `ga`: (GeneticAlgorithm) GeneticAlgorithm instance the population is part of.
- `rng`: Instance of a random number generator to produce reproducible results.
"""
function mutation!(population,ga,rng)
    for i in eachindex(population)
        if rand(rng)<ga.mutationRate
            population[i] = ga.mutation(population[i],rng)
        end
    end
end