
function test_displacement()
    rng = MersenneTwister();
    genes1 = [i for i in 1:5]
    return displacement(genes1,rng)
end

"""
    displacement(rng, gene)

Implements the single point crossover method.
`rng` is an instance of a random number generator to produce reproducible results.
`gene` and `result` are Vectors which store all genes of a chromosome.
The genes are displaced inside itself.
The returned element has the same values as before, but with scrambled genes.
"""
function displacement(gene,rng)
    # println(gene)
    random_subsequence_index = rand(rng, 1:length(gene)) # random index where subsequence starts
    random_subsequence_length = rand(rng, 0:length(gene)-random_subsequence_index+1) # random length of subsequence
    random_insertion = rand(rng, 0:length(gene)-random_subsequence_length) # random insertion place of subsequence (including before and behind)
    # println(random_subsequence_index, " ", random_subsequence_length, " ", random_insertion)
    if random_subsequence_length == 0
        return gene[begin:end]
    end
    random_subsequence = gene[random_subsequence_index:random_subsequence_index+random_subsequence_length-1]
    println(random_subsequence)
    rest = vcat(gene[begin:random_subsequence_index-1], gene[random_subsequence_index+random_subsequence_length:end])
    # println(rest)
    if random_insertion == 0
        return vcat(random_subsequence, rest)
    end
    result = vcat(vcat(rest[begin:random_insertion], random_subsequence), rest[random_insertion+1:end])
    return result
end

export displacement
export test_displacement