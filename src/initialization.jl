"""
    init_gaussian(population_size::Integer, starting_point::AbstractVector, rng::AbstractRNG)

Initializes a start population with populants which have their genome distributed around `starting_point`.

- `population_size`: Number of populants.
- `starting_point`: The genome of each populant equals this point + gaussian noise.
- `rng`: Instance of a random number generator to produce reproducible results.

Returns population.
"""
function init_gaussian(population_size::Integer, starting_point::AbstractVector, rng::AbstractRNG)
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
- `rng`: Instance of a random number generator to produce reproducible results.

Returns population.
"""
function init_uniform_binary_population(population_size::Integer, genome_length::Integer, rng::AbstractRNG)
    population = Vector{Vector{Bool}}(undef, population_size)

    for i in 1:population_size
        population[i] = [rand(rng) > 0.5 for _ in 1:genome_length]
    end

    return population
end
