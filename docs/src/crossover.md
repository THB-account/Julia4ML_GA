# Crossover

In the crossover step the previous selected individuals perform crossover.
This should exploit the best of each parent and increase the fitness of children.
Each crossover function looks like the following template function. 
This template can also be used to create new functions and replace the default crossover functions.

```julia
"""
    crossover_function(genes1, genes2, rng)

Implements a crossover function.

- `genes1`, `genes2`: Vector{<:Real} containing all genes of each parent.
- `rng`: An instance of a random number generator to produce reproducible results.

Returns `child1` and `child2`
"""
function crossover_function(genes1::Vector{<:Real}, genes2::Vector{<:Real}, rng)
end
```

```@docs
k_point
partially_mapped
```