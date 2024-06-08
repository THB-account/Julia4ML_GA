

#function single_point_crossover(p1::ContinuousPopulant,p2::ContinuousPopulant)
#    i = rand(1:length(p1.genes))
#    return ContinuousPopulant(vcat(p1.genes[begin:i],p2.genes[i:end])),ContinuousPopulant(vcat(p2.genes[begin:i],p1.genes[i:end]))
#end

function test_single_point()
    rng = MersenneTwister(1234);
    genes1 = [1 for i in 1:4]
    genes2 = [0 for i in 1:4]
    return single_point(genes1, genes2,rng)[1]
end

"""
    single_point(rng, genes1, genes2)

Implements the single point crossover method.
`rng` is an instance of a random number generator to produce reproducible results.
`genes1`, `genes2`, `child1` and `child2` are Vectors which store all genes of a chromosome.
`genes1` and `genes2` are used to create `child1` and `child2`, which are returned.
`child1` is a copy of `genes1` up to randomly generated crossover point. 
After that it is a copy of `genes2`. The same for `child2` in reverse.
"""
function single_point(genes1, genes2, rng)
    # println(genes1, genes2)
    crossover_point = rand(rng, 1:length(genes1)) # it is possible to swap 0 up to (including) all-1 genes
    # println(crossover_point)
    child1 = similar(genes1)
    child2 = similar(genes2)
    for i in 1:crossover_point
        child1[i] = genes1[i]
        child2[i] = genes2[i]
    end   
    for i in crossover_point:length(genes1)
        child1[i] = genes2[i]
        child2[i] = genes1[i]
    end
    return child1, child2

end
