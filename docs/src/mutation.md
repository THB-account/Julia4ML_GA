```@meta
CurrentModule = Julia4ML_GA
```
# Mutation

In the mutation step the new population is mutated.
This should increase the exploration and make it possible to find better solutions.

## Template
Each mutation function looks like the following template function. 
This template can also be used to create new functions and replace the default mutation functions.

```julia
"""
    template_mutation_function(genes::Vector{<:Real}, rng::AbstractRNG)

Implements a mutation function.

- `genes`: ::Vector containing all genes.
- `rng`: Instance of a random number generator to produce reproducible results.

Returns resulting genes.
"""
function template_mutation_function(genes::Vector{<:Real}, rng::AbstractRNG)
end
```

## Mutation Functions

```@docs
displacement
gaussian_noise
uniform_noise
bit_inversion
sudoku_mutation
```