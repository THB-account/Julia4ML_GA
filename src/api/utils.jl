"""
Contains the results of a evolutionary optimization process

- `minimalPopulant`: (Vector{Vector{Real}}) Populant that minimizes the objective.
- `minimalFitness`: (Vector{Real}) Value of the objective for the minimal populant.
- `trace`: (OptimizationTrace) Trace object containing individual values of generations.

Constructor:

    OptimizationResult(minimalPopulant,minmalFitness,trace) 
"""
struct OptimizationResult <: AbstractOptimizationResult
    minimalPopulant
    minmalFitness
    trace

    function OptimizationResult(minimalPopulant, minimalFitness,trace)
        new(minimalPopulant,minimalFitness,trace)
    end
end

"""
Contains information and functions to execute an optimization process for a genetic algorithm.

- `populations`: (Vector{Vector{Vector{Real}}}) Population of each iteration.
- `fitnessValues`: (Vector{Vector{Real}}) Fitness values of each generation.
- `fittestPopulants`: (Vector{Vector{Real}}) Fittest Individual of each population.

Constructor:

    OptimizationTrace() 
"""
mutable struct OptimizationTrace <: AbstractTrace
    populations :: Vector{Vector{Vector{Real}}}
    fitnessValues :: Vector{Vector{Real}}
    fittestPopulants :: Vector{Vector{Real}}
    function OptimizationTrace()
        new(
        Vector{Vector{Vector{Real}}}[],
        Vector{Vector{Real}}[],
        Vector{Vector{Real}}[]
        )
    end
end

"""
    append!(trace,state)

Initialises populant's genes.

- `trace`: (AbstractTrace) Trace struct containing values
- `state`: (AsbtractState) A state of a genetic algorithm.
"""
function append!(trace::AbstractTrace,state::AbstractState)  
    push!(trace.populations,state.population)
    push!(trace.fitnessValues,state.populationFitness)
    push!(trace.fittestPopulants,state.fittest)
end

"""
    argmin(res)

- `res`: (OptimizationResult)

Returns minimizing gene
"""
function argmin(res::OptimizationResult)
    return res.minimalPopulant
end

"""
    min(res)

- `res`: (OptimizationResult)

Returns minimal fitness value
"""
function min(res::OptimizationResult)
    return res.minmalFitness
end

"""
    trace(res)

- `res`: (OptimizationResult)

Returns trace of evolutionary algorithm
"""
function trace(res::OptimizationResult)
    return res.trace
end