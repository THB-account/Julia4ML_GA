using Julia4ML_GA
using Random

rng = Random.default_rng()
starting_point = Float64[0.,0.]
obj = x->(1-x[1])^2 +100*(x[2]-x[1]^2)^2
ga = Julia4ML_GA.GeneticAlgorithm(populationSize=100)
iterations = 100

pop = Julia4ML_GA.initialise_genetic_state(starting_point,obj,ga,rng).population

println(Julia4ML_GA.optimize(pop,
    obj, 
    ga ;
    #iterations=3,
    rng=rng,
    time_limit=4
    ))
