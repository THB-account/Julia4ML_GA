"""
    init_gaussian(population_size::Integer, genome_length::Integer, rng::AbstractRNG)

Initializes a start population with populants which have their genome distributed around `starting_point`.

- `starting_point`: The genome of each populant equals this point + gaussian noise.
- `population_size`: Number of populants.

Returns population
"""
function init_gaussian(starting_point::AbstractVector, population_size::Integer, rng::AbstractRNG)
    population = Vector{Vector{eltype(starting_point)}}(undef, population_size)
    d=length(starting_point)
    for i in 1:population_size
        population[i] = rand(rng,d) .+ starting_point #Vector{eltype(starting_point)}
    end

    return population
end


"""
    init_uniform_binary_population(population_size::Integer, genome_length::Integer, rng::AbstractRNG)

Initializes a start population with populants which have only Bool genes.

- `population_size`: Number of populants.
- `genome_length`: Number of genes of a single populant.

Returns population
"""
function init_uniform_binary_population(population_size::Integer, genome_length::Integer, rng::AbstractRNG)
    population = Vector{Vector{Bool}}(undef, population_size)

    for i in 1:population_size
        population[i] = [rand(rng) > 0.5 for _ in 1:genome_length]
    end

    return population
end
