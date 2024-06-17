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
    
    time_limit=2
    start = now()

    res = Julia4ML_GA.optimize(pop,
        obj, 
        ga ;
        iterations=20000000, # -> rediculusly high
        rng=rng,
        time_limit=time_limit, # -> to use this as termination criterion
        obj_bound = 0.00000005 # -> rediculously low
    )

    fin = now()

    @test isapprox(time_limit, (fin - start)/ Millisecond(1000), atol=0.5)
end

@testset "max_iterations" begin
    Random.seed!(1234)
    rng = Random.default_rng()
    obj = x->(1-x[1])^2 +100*(x[2]-x[1]^2)^2
    ga = Julia4ML_GA.GeneticAlgorithm(populationSize=100)
    pop = Julia4ML_GA.initialise_genetic_state(Float64[0.,0.],obj,ga,rng).population
    
    time_limit=2
    start = now()

    res = Julia4ML_GA.optimize(pop,
        obj, 
        ga ;
        iterations=3, # -> this will be fast
        rng=rng,
        time_limit=time_limit, # -> low, but longer than 3 iterations
        obj_bound = 0.00000005 # -> rediculously low
    )

    fin = now()

    # running time should be almost zero, even on my sucky laptop
    @test isapprox(time_limit-(fin - start)/ Millisecond(1000), 2, atol=0.1)
end

@testset "objective_lower_bound" begin
    Random.seed!(1)
    rng = Random.default_rng()
    obj = x->(1-x[1])^2 +100*(x[2]-x[1]^2)^2
    ga = Julia4ML_GA.GeneticAlgorithm(populationSize=100)
    pop = Julia4ML_GA.initialise_genetic_state(Float64[0.,0.],obj,ga,rng).population
    
    time_limit=10
    bound = 0.008 
    start = now()

    # setup with which it ends after 4 iterations due to fixed randomness and bound
    res = Julia4ML_GA.optimize(pop,
        obj, 
        ga ;
        iterations=10, 
        rng=rng,
        time_limit=time_limit, 
        obj_bound = bound 
    )

    fin = now()

    # running time should be almost zero, even on my sucky laptop
    @test isapprox(obj(res[1]), bound, atol=0.001)
end

