struct OptimizationResult <: AbstractOptimizationResult
    minimalPopulant
    minmalFitness
    trace

    function OptimizationResult(minimalPopulant, minimalFitness,trace)
        new(minimalPopulant,minimalFitness,trace)
    end
end


mutable struct OptimizationTrace <:AbstractTrace
    populations :: Vector{Vector{Vector{<:Real}}}
    fitnessValues :: Vector{Vector{Vector{<:Real}}}
    fittestPopulants :: Vector{Vector{Vector{<:Real}}}
    function OptimizationTrace()
        new(Vector{Vector{Vector{<:Real}}}[],
        Vector{Vector{Vector{<:Real}}}[],
        Vector{Vector{Vector{<:Real}}}[])
    end
end

function append!(trace::OptimizationTrace,state::AbstractState)
    push!(trace.populations,[state.population])
    push!(trace.fitnessValues,[state.populationFitness])
    push!(trace.fittestPopulants,[state.fittest])
end

function argmin(res::OptimizationResult)
    return res.minimalPopulant
end

function min(res::OptimizationResult)
    return res.minmalFitness
end

function trace(res::OptimizationResult)
    return res.trace
end