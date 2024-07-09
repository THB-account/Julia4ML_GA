```@meta
CurrentModule = Julia4ML_GA
```
# Initialization

Before the optimization can begin the population has to be initialized.
The data type and length of the genome depends on the specific problem to be solved and the representation chosen.
During the optimization the size of the population and length of the genome of each individual stays the same.

## Template

```julia
"""
    function template_init_function(population_size::Integer, problem_specific_information::Any, rng::AbstractRNG)

Implements an initialization function.

- `population_size`: Number of populants.
- `problem_specific_information`: Some problem specific information to indicate what possible values each individual can have.
- `rng`: Instance of a random number generator to produce reproducible results.

Returns resulting population.
"""
function template_init_function(population_size::Integer, problem_specific_information::Any, rng::AbstractRNG)
end
```

## Initialization Functions

```@docs
init_gaussian
init_uniform_binary_population
init_sudoku_population
init_tsp_population
```