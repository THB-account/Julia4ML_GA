"""
    displacement(genes, rng)

Implements the displacement method. The genes are displaced inside itself. 
The returned element has the same values as before, but with scrambled genes.
Should only be used if the sequence of the genes solve the problem (tsp).
Should not be used for numerical problem.

- `genes`: ::Vector{<:Real} containing all genes.
- `rng`: Instance of a random number generator to produce reproducible results.

Returns resulting genes.
"""
function displacement(genes::Vector{<:Real}, rng::R) where {R<:AbstractRNG}

    r_start = rand(rng, 1:length(genes)) # random index where subsequence starts
    r_end = rand(rng, 2:length(genes)+1) # random index where subsequence ends

    random_subsequence = get_sub_vector(genes, r_start, r_end, true)
    rest = []

    # println("s ",random_subsequence)

    if r_end >= r_start
        rest = vcat(get_sub_vector(genes, 1, r_start), get_sub_vector(genes, r_end, length(genes)+1))
    else
        rest = get_sub_vector(genes, r_end, r_start)
    end
    
    # println("r ", rest)

    r_insertion = rand(rng, 1:length(rest)+1) # random insertion place of subsequence (including before and behind)

    # println(r_start, " ", r_end, " ", r_insertion)
    rest_2 = get_sub_vector(rest, r_insertion, length(rest)+1)
    rest_1 = get_sub_vector(rest, 1, r_insertion)
    return vcat(rest_1, vcat(random_subsequence, rest_2))
end

"""
    gaussian_displacement(genes, rng)

Adds gaussian noise to the genes with ``\\mathcal{N}(0,1)``. 
Should be used for numerical problems (rosenbrock).
Should not be used for integer value problems (tsp).

- `rng`: Instance of a random number generator to produce reproducible results.
- `genes`: (Vector{Float64}) Vector containing all genes.

Returns resulting gene.
"""
function gaussian_displacement(genes::Vector{<:Real}, rng::R) where {R<:AbstractRNG}
    return genes + randn(rng,size(genes)...)
end

"""
    univariate_displacement(gene, rng)

Adds univeriate noise to the gene with ``\\mathcal{U}(-1,1)``.
Should be used for numerical problems (rosenbrock).
Should not be used for integer value problems (tsp).

- `rng`: Instance of a random number generator to produce reproducible results.
- `gene`: (Vector{Float64}) Vector containing all genes.

Returns resulting gene.
"""
function univariate_displacement(gene::Vector{<:Real}, rng::R) where {R<:AbstractRNG}
    return gene + (rand(rng,size(gene)...) .* 2 .- 1)
end

"""
    bit_inversion(genes, rng)

Inverses each bit with probability 1/length(genes).
Should only be used if genes is a Bool Vector.

- `rng`: Instance of a random number generator to produce reproducible results.
- `genes`: (Vector{Bool}) Vector containing all genes.

Returns resulting genes.
"""
function bit_inversion(genes::Vector{Bool}, rng::R) where {R<:AbstractRNG}
    p = 1/length(genes)
    for (index, element) in enumerate(genes)
        if rand(rng) <= p
            genes[index] = !genes[index]
        end
    end
    return genes
end