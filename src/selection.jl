function roulette_wheel_inv(fitness::Vector{<:Real}, selection_number::Int, rng)
    roulette_wheel(1.0 ./ fitness, selection_number, rng)
end

"""
    roulette_wheel(fitness, selection_number, rng)

Implements a simple roulette_wheel. If the sum over positive fitness scores is larger than the sum 
over negative scores, higher fitness scores are more likely to be selected, otherwise negative values are more
likely to be selected. Should only be used if either all fitness values are negative or all fitness values are 
positive

- `fitness`: (Vector{<:Real}) Vector of fitness values. The higher the absolute fitness, 
  the more likely the corresponding chromosome is selected.
- `selection_number`: (Integer) Indicates how many indices are returned.
- `rng`: Instance of a random number generator to produce reproducible results.

Returns indices of selected populants.
"""
function roulette_wheel(fitness::Vector{<:Real}, selection_number::Int, rng)
    abs_fitness = abs.(fitness)
    probabilities = abs_fitness ./ sum(abs_fitness)
    cumulative_probabilities = cumsum(probabilities)
    cumulative_probabilities[end] = 1
    
    selected_indices = Vector{Int}(undef, selection_number)
    
    for i in 1:selection_number
        r = rand(rng)
        selected_index = findfirst(cumulative_probabilities .>= r)
        selected_indices[i] = selected_index
    end
    
    return selected_indices
end

"""
    tournament_selection(fitness, selection_number, tournament_size, rng)

Implements a simple tournament selection. Selects `selection_number` candidates. Each candidate is selected by taking 
the fittest of `tournament_size` randomly chosen candidates. 

- `fitness`: (Vector{<:Real}) Vector of fitness values.
"""
function tournament_selection(fitness::Vector{<:Real}, selection_number::Int, tournament_size::Int, rng)
    # TODO: complete and fix
    population_size = length(fitness)
    selected_indices = Vector{Int}(undef, selection_number)
    total_fitness_sign = fitness |> sum |> sign
    modified_fitness = fitness / total_fitness_sign
    
    for i in 1:selection_number
        tournament_indices = rand(rng, 1:population_size, tournament_size)
        
        best_index = tournament_indices[1]
        for j in 2:tournament_size
            if modified_fitness[tournament_indices[j]] < modified_fitness[best_index]
                best_index = tournament_indices[j]
            end
        end
        
        selected_indices[i] = best_index
    end

    return selected_indices
end

"""
    rank_selection(fitness, selection_number, rng)

Implements rank selection based on roulette_wheel. Can deal with mixed positive and negative values.
Selects based on order of fitness values. The amount of the difference between the fitness values is not taken into account.


- `fitness`: (Vector{<:Real}) Vector of fitness values. The lower the fitness, 
  the more likely the corresponding chromosome is selected.
- `selection_number`: (Integer) Indicates how many indices are returned.
- `rng`: Instance of a random number generator to produce reproducible results.

Returns indices of selected populants.
"""
function rank_selection(fitness::Vector{<:Real}, selection_number::Int, rng, f = x -> x)
    selected_ranks = roulette_wheel(f.(collect(1:length(fitness))), selection_number, rng)
    fitness_with_indices = collect(zip(collect(1:length(fitness)),fitness))
    sorted_fitness = sort(fitness_with_indices, by=x->x[2], rev=true) # lowest fitness is selected with highest probability
    selected_indices = first.(sorted_fitness)[selected_ranks]
    return selected_indices
end