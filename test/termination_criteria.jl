using Random
using Julia4ML_GA
using Test
using Dates

@testset "time_limit" begin
    Random.seed!(1234)
    rng = Random.default_rng()
    obj = x->(1-x[1])^2 +100*(x[2]-x[1]^2)^2
    ga = Julia4ML_GA.GeneticAlgorithm(populationSize=100)
    pop = Julia4ML_GA.initialise_genetic_state(Float64[0.,0.],obj,ga,rng).population
    
    
    time_limit=10 # to be tested here
    bound = 0.00000005
    max_iter = 20000000

    start = now()

    res = Julia4ML_GA.optimize(pop,
        obj, 
        ga ;
        iterations=max_iter, 
        rng=rng,
        time_limit=time_limit, 
        obj_bound = bound 
    )

    fin = now()

    @test isapprox(time_limit, (fin - start)/ Millisecond(1000), atol=0.5)
end

@testset "max_iterations" begin
    #The following example runs for 3 iterations with outcomes:
    #    # fittness fittest, id fittest
    #    ([0.03259902851092163], [80]) 
    #    ([0.03259902851092163], [96])
    #    ([0.007679540200270641], [62])
    
    Random.seed!(1)
    rng = Random.default_rng()
    obj = x->(1-x[1])^2 +100*(x[2]-x[1]^2)^2
    ga = Julia4ML_GA.GeneticAlgorithm(populationSize=100)
    pop = Julia4ML_GA.initialise_genetic_state(Float64[0.,0.],obj,ga,rng).population
    
    time_limit=10
    bound = 0.00000005
    max_iter = 2 # to be tested here

    res = Julia4ML_GA.optimize(pop,
        obj, 
        ga ;
        iterations=max_iter, 
        rng=rng,
        time_limit=time_limit, 
        obj_bound = bound 
    )

    @test isapprox(obj(res[1]), 0.0325990, atol=0.00001)
end

@testset "objective_lower_bound" begin
    #The following example runs for 3 iterations with outcomes:
    #    # fittness fittest, id fittest
    #    ([0.03259902851092163], [80]) 
    #    ([0.03259902851092163], [96])
    #    ([0.007679540200270641], [62])
    

    Random.seed!(1)
    rng = Random.default_rng()
    obj = x->(1-x[1])^2 +100*(x[2]-x[1]^2)^2
    ga = Julia4ML_GA.GeneticAlgorithm(populationSize=100)
    pop = Julia4ML_GA.initialise_genetic_state(Float64[0.,0.],obj,ga,rng).population
    
    time_limit=10
    bound = 0.008 # to be tested here
    max_iter = 20

    res = Julia4ML_GA.optimize(pop,
        obj, 
        ga ;
        iterations=max_iter, 
        rng=rng,
        time_limit=time_limit, 
        obj_bound = bound 
    )

    @test isapprox(obj(res[1]), bound, atol=0.001)
end

