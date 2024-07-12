
"""
Contains information and functions to execute an optimization process for a genetic algorithm.

- `populationSize::Integer`: Number of populants to be maintained.
- `eliteSize::Integer`: Number of populants selected as elite.
- `mutationRate::Real`: Probability of mutation.
- `crossoverRate::Real`: Probability of crossover for two populants.
- `selection::S`: Function to select populants for next iteration.
- `mutation::M`: Mutation function.
- `crossover::C`: Crossover function.

Constructor:

    GeneticAlgorithm(;
        populationSize::Integer=50,
        eliteSize::Integer=5,
        crossoverRate::Real=0.5,
        mutationRate::Real=0.5,
        selection::S=roulette_wheel,
        mutation::M=displacement,
        crossover::C=k_point
    )
"""
struct GeneticAlgorithm{S, M, C} <: AbstractOptimizer
    populationSize::Integer
    eliteSize::Integer
    mutationRate::Real
    crossoverRate::Real
    selection::S
    mutation::M
    crossover::C
    # TODO add methods here
    GeneticAlgorithm(;
        populationSize::Integer=50,
        eliteSize::Integer=5,
        crossoverRate::Real=0.5,
        mutationRate::Real=0.5,
        selection::S=roulette_wheel,
        mutation::M=displacement,
        crossover::C=k_point
    ) where {S, M, C} = 
    new{S, M, C}(
        populationSize,
        eliteSize,
        crossoverRate,
        mutationRate,
        selection,
        mutation,
        crossover
    )
end

"""
State of a genetic algorithm.

- `population::A`: Current population. Vector conatining elements of same type as starting point for optimization process.
- `populationFitness::Vector{<:Real}`: Fitness function by which the population's fitness is to be evaluated.
- `fittest::T`: Individual with best fitness value.

Constructor:

    GeneticAlgorithmState{T, A}(
        population::A, 
        objective::F
    ) where {T, A<:AbstractArray, F<:Function}
"""
mutable struct GeneticAlgorithmState{T, A<:AbstractArray} <: AbstractState
    population::A
    populationFitness::Vector{<:Real}
    fittest::T

    function GeneticAlgorithmState{T, A}(
        population::A, 
        objective::F
    ) where {T, A<:AbstractArray, F<:Function}
        fitness = objective.(population)
        _, fittest_idx = findmin(fitness)
        new{T, A}(population, fitness, population[fittest_idx])
    end

    function GeneticAlgorithmState(population::A, objective::F) where {A<:AbstractArray, F<:Function}
        T = eltype(population)  
        GeneticAlgorithmState{T, A}(population, objective)
    end
end

"""
    update_state!(ga::GeneticAlgorithm, state::GeneticAlgorithmState, objective::Function, rng::AbstractRNG)

Updates GeneticAlgorithmState according to provided GeneticAlgorithm instance.
Selection, crossover, mutation and evaluation is executed.
Equivalent to one iteration of the optimizatrion process.

- `ga`: GeneticAlgorithm instance to work on.
- `state`: GeneticAlgorithmState to proceed from.
- `objective`: Fitness function to be used.
- `rng`: Instance of a random number generator to produce reproducible results.
"""
function update_state!(ga::GeneticAlgorithm, state::GeneticAlgorithmState, objective::Function, rng::AbstractRNG)
    # initialisation won't be handled here
    populationSize = ga.populationSize
    eliteSize = ga.eliteSize
    parents = state.population
    new_gen = similar(parents)
    nonEliteSize = populationSize - ga.eliteSize
    selected_individuals = ga.selection(state.populationFitness, nonEliteSize, rng)

    # fill with crossover children
    crossover!(parents,new_gen,selected_individuals,ga,rng)

    # fill with elite children
    idxs = sortperm(state.populationFitness)
    
    for i in 1:eliteSize
        new_gen[nonEliteSize+i] = copy(parents[idxs[i]])
    end

    mutation!(new_gen,ga,rng)

    _, fitidx = findmin(state.populationFitness)
    # update state
    state.population .= new_gen
    state.populationFitness .= evaluation!(state,objective)
    state.fittest = state.population[fitidx]
end

"""
    evaluation!(state::GeneticAlgorithmState, objective::Function)

Control function for fitness evaluation.

- `state`:  GeneticAlgorithmState instance to proceed from.
- `objective`: Fitness function by which the population is evaluated.
"""
function evaluation!(state::GeneticAlgorithmState, objective::Function)
    state.populationFitness .= objective.(state.population)
end

"""
    crossover!(parents::A, children::A, selected_individuals::Vector{Int}, ga::GeneticAlgorithm, rng::AbstractRNG) where {A<:AbstractArray}

Control function for crossover.

- `parents`: (Sub-)Population to be used to create offspring.
- `children` Object to hold the newly created offspring.
- `selected_individuals`:  The for crossover selected populant's indices.
- `ga`: GeneticAlgorithm instance the population is part of.
- `rng`:  Instance of a random number generator to produce reproducible results.
"""
function crossover!(
    parents::A, 
    children::A, 
    selected_individuals::Vector{Int}, 
    ga::GeneticAlgorithm, 
    rng::AbstractRNG
) where {A<:AbstractArray}
    N = length(selected_individuals)
    for i in 1:2:length(selected_individuals)
        parent1, parent2 = i!=N ? (i,i+1) : (i,i-1)
        selected_idx1 = selected_individuals[parent1]
        selected_idx2 = selected_individuals[parent2]
        parent1, parent2 = parents[selected_idx1],parents[selected_idx2]

        if rand(rng) < ga.crossoverRate
            children[i],children[i+1] = ga.crossover(parent1,parent2,rng)
        else
            children[i],children[i+1] = parent1,parent2
        end
    end
end

"""
    mutation!(population::AbstractArray, ga::GeneticAlgorithm, rng::AbstractRNG)

control function for mutation.

- `population`: (Sub-)Population to be mutated.
- `ga`: GeneticAlgorithm instance the population is part of.
- `rng`: Instance of a random number generator to produce reproducible results.
"""
function mutation!(population::AbstractArray, ga::GeneticAlgorithm, rng::AbstractRNG)
    for i in eachindex(population)
        if rand(rng) < ga.mutationRate
            population[i] = ga.mutation(population[i],rng)
        end
    end
end