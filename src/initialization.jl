function init_gaussian(starting_point::AbstractVector, population_size::Integer, rng::R) where {R<:AbstractRNG}
    population = Vector{Vector{eltype(starting_point)}}(undef, population_size)
    d=length(starting_point)
    for i in 1:population_size
        population[i] = rand(rng,d) .+ starting_point #Vector{eltype(starting_point)}
    end

    return population
end

function init_uniform_binary_population(
    population_size::Integer, 
    genome_length::Integer, 
    rng::R
) where {R<:AbstractRNG}
    population = Vector{Vector{Bool}}(undef, population_size)

    for i in 1:population_size
        population[i] = [rand(rng) > 0.5 for _ in 1:genome_length]
    end

    population
end
