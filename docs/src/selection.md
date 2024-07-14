# Selection

In the selection step a portion of the population is selected to perform crossover later.
This should select individuals which after crossover are better than before.

## Template

Each selection function looks like the following template function. 
This template can also be used to create new functions and replace the default selection functions.

```julia
"""
    template_selection_function(fitness::Vector{<:Real}, selection_number::Integer, rng::AbstractRNG)

Implements a selection function.

- `fitness`: Vector of fitness values. The higher the absolute fitness, 
  the more likely the corresponding gene is selected.
- `selection_number`: Indicates how many indices are returned.
- `rng`: Instance of a random number generator to produce reproducible results.

Returns indices of selected populants.
"""
function template_selection_function(fitness::Vector{<:Real}, selection_number::Integer, rng::AbstractRNG)
end
```

## Selection Functions

```@docs
roulette_wheel_inv
roulette_wheel
tournament_selection
rank_selection
```