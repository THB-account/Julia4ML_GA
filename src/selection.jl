function test_roulette_wheel()
    fit = [rand(Float64) for i in 1:5]
    rng = MersenneTwister(1234);
    return roulette_wheel(fit, 10,rng)
end

"""
    roulette_wheel(fitness, selection_number,rng)

Implements a simple roulette_wheel.

- `fitness`: (Vector{Float64}) Vector of fitness values. The higher, the more likely the corresponding chromosome is selected.
- `selection_number`: (Integer) Indicates how many indices are returned.
- `rng`: Instance of a random number generator to produce reproducible results.

Returns indices of selected populants.
"""

function roulette_wheel(fitness::AbstractArray, num_to_select::Int, rng)
    total_fitness = sum(fitness)
    probabilities = fitness / total_fitness
    cumulative_probabilities = cumsum(probabilities)
    
    selected_indices = Vector{Int}(undef, num_to_select)
    
    for i in 1:num_to_select
        r = rand(rng)
        selected_index = findfirst(cumulative_probabilities .>= r)
        selected_indices[i] = selected_index
    end
    
    return selected_indices
end

# TODO: there might be a better way of handling this
function tournament_selection(fitness::AbstractArray, num_to_select::Int, tournament_size::Int, rng)
    population_size = length(fitness)
    selected_indices = Vector{Int}(undef, num_to_select)
    
    for i in 1:num_to_select
        tournament_indices = rand(rng, 1:population_size, tournament_size)
        
        best_index = tournament_indices[1]
        for j in 2:tournament_size
            if fitness[tournament_indices[j]] < fitness[best_index]
                best_index = tournament_indices[j]
            end
        end
        
        selected_indices[i] = best_index
    end

    return selected_indices
end