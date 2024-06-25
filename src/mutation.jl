"""
    displacement(gene, rng)

Implements the displacement method.
- `gene`: ::Vector{<:Real} containing all genes of a chromosome.
- `rng`: Instance of a random number generator to produce reproducible results.

Returns resulting gene.

The genes are displaced inside itself.
The returned element has the same values as before, but with scrambled genes.

!!! Only applicable for combinatorial problems (knapsack) !!!
"""
function displacement(gene::Vector{<:Real}, rng)

    r_start = rand(rng, 1:length(gene)) # random index where subsequence starts
    r_end = rand(rng, 2:length(gene)+1) # random index where subsequence ends

    random_subsequence = get_sub_vector(gene, r_start, r_end, true)
    rest = []

    # println("s ",random_subsequence)

    if r_end >= r_start
        rest = vcat(get_sub_vector(gene, 1, r_start), get_sub_vector(gene, r_end, length(gene)+1))
    else
        rest = get_sub_vector(gene, r_end, r_start)
    end
    
    # println("r ", rest)

    r_insertion = rand(rng, 1:length(rest)+1) # random insertion place of subsequence (including before and behind)

    # println(r_start, " ", r_end, " ", r_insertion)
    rest_2 = get_sub_vector(rest, r_insertion, length(rest)+1)
    rest_1 = get_sub_vector(rest, 1, r_insertion)
    return vcat(rest_1, vcat(random_subsequence, rest_2))
end

"""
    gaussian_displacement(gene, rng)

Adds gaussian noise to the gene with ``\\mathcal{N}(0,1)``.
- `rng`: Instance of a random number generator to produce reproducible results.
- `gene`: (Vector{Float64}) Vector containing all genes of a chromosome.

Returns resulting gene.

!!! Only applicable for numerical problems (rosenbrock) !!!
"""
function gaussian_displacement(gene::Vector{<:Real}, rng)
    return gene + randn(rng,size(gene)...)
end

"""
    univariate_displacement(gene, rng)

Adds univeriate noise to the gene with ``\\mathcal{U}(-1,1)``.
- `rng`: Instance of a random number generator to produce reproducible results.
- `gene`: (Vector{Float64}) Vector containing all genes of a chromosome.

Returns resulting gene.

!!! Only applicable for numerical problems (rosenbrock) !!!
"""
function univariate_displacement(gene::Vector{<:Real}, rng)
    return gene + (rand(rng,size(gene)...) .* 2 .- 1)
end

"""
    bit_inversion(gene, rng)

Inverses each bit with probability 1/length(gene).
- `rng`: Instance of a random number generator to produce reproducible results.
- `gene`: (Vector{Bool}) Vector containing all genes of a chromosome.

Returns resulting gene.

!!! Only applicable for problems with true/false genes (knapsack) !!!
"""
function bit_inversion(gene::Vector{Bool}, rng)
    p = 1/length(gene)
    for (index, element) in enumerate(gene)
        if rand(rng) <= p
            gene[index] = !gene[index]
        end
    end
    return gene
end