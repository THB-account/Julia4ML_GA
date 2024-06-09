function init_gaussian(starting_point::AbstractVector,population_size::Integer,rng)
    population = Vector{Vector{eltype(starting_point)}}(undef, population_size)
    d=length(starting_point)
    for i in 1:population_size
        population[i] = rand(rng,d) .+ starting_point #Vector{eltype(starting_point)}
    end

    return population
end