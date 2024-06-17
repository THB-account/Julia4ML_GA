"""
    single_point(genes1, genes2,rng)

Implements the single point crossover method.
- `genes1`, `genes2`: Vector{<:Real} containing all genes of a chromosome.
- `rng`: An instance of a random number generator to produce reproducible results.

Returns `child1` and `child2`

`genes1` and `genes2` are used to create `child1` and `child2`, which are returned. 
`child1` is a copy of `genes1` up to randomly generated crossover point. 
After that it is a copy of `genes2`. The same for `child2` respectively with parent roles swapped.
"""
function single_point(genes1::Vector{<:Real}, genes2::Vector{<:Real}, rng)
    crossover_point = rand(rng, 0:length(genes1)) # it is possible to swap 0 up to (including) all genes

    child1 = copy(genes1)
    child2 = copy(genes2)
    for i in crossover_point+1:length(genes1)
        child1[i] = genes2[i]
        child2[i] = genes1[i]
    end
    return child1, child2
end
