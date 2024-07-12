# Crossover

In the crossover step the previous selected individuals perform crossover.
This should exploit the best of each parent and increase the fitness of children.

## Template
Each crossover function looks like the following template function. 
This template can also be used to create new functions and replace the default crossover functions.

```julia
"""
    template_crossover_function(genes1::Vector{<:Real}, genes2::Vector{<:Real}, rng::AbstractRNG)

Implements a crossover function.

- `genes1`, `genes2`: Vector containing all genes of each parent.
- `rng`: An instance of a random number generator to produce reproducible results.

Returns `child1` and `child2`
"""
function template_crossover_function(genes1::Vector{<:Real}, genes2::Vector{<:Real}, rng::AbstractRNG)
end
```

## Crossover Functions

```@docs
k_point
partially_mapped
```