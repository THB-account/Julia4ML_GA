function get_sub_array(arr::Vector{<:Real}, s, e, allow_wrap = false)
    if e <= 0 || s > length(arr) 
        if s-e != 1
            error("Wrong usage. Indexing not correct. Array: ", arr, ", s: ", s, ", e: ", e)
        end
        # This should only happen with s = 1, e = 0 and s = length+1, e = length
        return Vector{eltype(arr)}(undef, 0)
    end
    if s <= e
        return arr[s:e]
    end
    if s <= 0 || e > length(arr)
        error("Wrong usage. Indexing not correct. Array: ", arr, ", s: ", s, ", e: ", e)
    end
    if allow_wrap
        sub_arr_1 = get_sub_array(arr, s, length(arr))
        sub_arr_2 = get_sub_array(arr, 1, e)
        return vcat(sub_arr_1, sub_arr_2)
    else
        if s-e != 1
            error("Wrong usage. Indexing not correct. Array: ", arr, ", s: ", s, ", e: ", e)
        end
        # This should only happen with s = x, e = x - 1, allow_wrap = false
        return Vector{eltype(arr)}(undef, 0)
    end
end


"""
    displacement(gene,rng)

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
    r_end = rand(rng, 1:length(gene)) # random index where subsequence ends

    random_subsequence = get_sub_array(gene, r_start, r_end, true)
    rest = []

    # println("s ",random_subsequence)

    if r_end >= r_start
        rest = vcat(get_sub_array(gene, 1, r_start-1), get_sub_array(gene, r_end+1, length(gene)))
    else
        rest = get_sub_array(gene, r_end+1, r_start-1)
    end

    
    # println("r ", rest)

    r_insertion = rand(rng, 0:length(rest)) # random insertion place of subsequence (including before and behind)

    # println(r_start, " ", r_end, " ", r_insertion)
    rest_2 = get_sub_array(rest, r_insertion+1, length(rest))
    rest_1 = get_sub_array(rest, 1, r_insertion)
    return vcat(rest_1, vcat(random_subsequence, rest_2))
end

"""
    gaussian_displacement(gene,rng)

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
    univariate_displacement(gene,rng)

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
    univariate_displacement(gene,rng)

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