"""
    k_point(genes1, genes2,rng)

Implements the k point crossover method.
- `genes1`, `genes2`: Vector{<:Real} containing all genes of a chromosome.
- `rng`: An instance of a random number generator to produce reproducible results.
- `k`: Number of cross over points

Returns `child1` and `child2`

`genes1` and `genes2` are used to create `child1` and `child2`, which are returned. 
`child1` is a copy of `genes1` up to randomly generated crossover point. 
After that it is a copy of `genes2`. The same for `child2` respectively with parent roles swapped.
If more than one crossover point exist this procedure is repeated.
If k == 1, this is single point crossover
"""
function k_point(genes1::Vector{<:Real}, genes2::Vector{<:Real}, rng, k::Int = 2)
    crossover_points = sort([rand(rng, 1:length(genes1)+1) for i in 1:k]) # it is possible to swap 0 up to (including) all genes
    push!(crossover_points, length(genes1)+1)
    child1 = Vector{eltype(genes1)}(undef, 0)
    child2 = Vector{eltype(genes2)}(undef, 0)
    last_el = 1
    for (index, el) in enumerate(crossover_points)
        if index % 2 == 0
            child1 = vcat(child1, get_sub_vector(genes2, last_el, el))
            child2 = vcat(child2, get_sub_vector(genes1, last_el, el))
        else
            child1 = vcat(child1, get_sub_vector(genes1, last_el, el))
            child2 = vcat(child2, get_sub_vector(genes2, last_el, el))
        end
        last_el = el
    end
    return child1, child2
end

"""
    partially_mapped(genes1, genes2,rng)

Implements the partially mapped crossover (PMX) method.
- `genes1`, `genes2`: Vector{<:Real} containing all genes of a chromosome.
- `rng`: An instance of a random number generator to produce reproducible results.

Returns `child1` and `child2`

`genes1` and `genes2` are used to create `child1` and `child2`, which are returned. 
"""
function partially_mapped(genes1::Vector{<:Real}, genes2::Vector{<:Real}, rng)
    child1 = copy(genes1)
    child2 = copy(genes2)
    return child1, child2
end
