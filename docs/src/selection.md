# Selection

In the selection step a portion of the population is selected to perform crossover later.
This should select individuals which after crossover are better than before.
Each selection function looks like the following template function. 
This template can also be used to create new functions and replace the default selection functions.

```julia
"""
    selection_function(fitness, selection_number, rng)

Implements a selection function.

- `fitness`: (Vector{<:Real}) Vector of fitness values. The higher the absolute fitness, 
  the more likely the corresponding gene is selected.
- `selection_number`: (Integer) Indicates how many indices are returned.
- `rng`: Instance of a random number generator to produce reproducible results.

Returns indices of selected populants.
"""
function selection_function(fitness::Vector{<:Real}, selection_number::Int, rng::R) where {R<:AbstractRNG}
end
```

```@docs
roulette_wheel
tournament_selection
rank_selection
```