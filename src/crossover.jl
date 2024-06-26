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
function k_point(genes1::Vector{<:Real}, genes2::Vector{<:Real}, rng::R, k::Int = 2) where {R<:AbstractRNG}
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

function get_uncopied_gene(d::Dict, gene::Real)
    if !(gene in keys(d))
        return gene
    end
    return get_uncopied_gene(d, d[gene])
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
    child1 = similar(genes1)
    child2 = similar(genes2)

    r_start = rand(rng, 1:length(genes1)) # random index where subsequence starts
    r_end = rand(rng, 2:length(genes1)+1) # random index where subsequence ends

    if r_start == r_end
        return genes1, genes2
    end

    random_subsequence_genes1 = get_sub_vector(genes1, r_start, r_end, true)
    random_subsequence_genes2 = get_sub_vector(genes2, r_start, r_end, true)

    #println(genes1, genes2)
    if r_start < r_end
        child1[r_start:r_end-1] = random_subsequence_genes2
        child2[r_start:r_end-1] = random_subsequence_genes1
    else
        child1[r_start:length(genes1)] = get_sub_vector(random_subsequence_genes2, 1, length(genes1)-r_start+2)
        child1[1:r_end-1] = get_sub_vector(random_subsequence_genes2, length(genes1)-r_start+2, length(genes1)-r_start+1 + r_end)

        child2[r_start:length(genes1)] = get_sub_vector(random_subsequence_genes1, 1, length(genes1)-r_start+2)
        child2[1:r_end-1] = get_sub_vector(random_subsequence_genes1, length(genes1)-r_start+2, length(genes1)-r_start+1 + r_end)
    end


    #println(child1, child2)

    indices = []
    if r_end >= r_start
        if r_start > 1
            indices = collect(1:r_start-1)
        end
        if r_end <= length(genes1)
            Base.append!(indices, collect(r_end:length(genes1)))
        end
    else
        indices = collect(r_end:r_start-1)
    end

    d_child2 = Dict(zip(random_subsequence_genes1, random_subsequence_genes2))
    d_child1 = Dict(zip(random_subsequence_genes2, random_subsequence_genes1))
    #println(d_child1)
    for i in indices
        uncopied_gene = get_uncopied_gene(d_child2, genes2[i])
        #println("i: ", i, ", ug: ", uncopied_gene)
        child2[i] = uncopied_gene
        child1[i] = get_uncopied_gene(d_child1, genes1[i])
    end
    #println(child1, child2)
    return child1, child2
end
