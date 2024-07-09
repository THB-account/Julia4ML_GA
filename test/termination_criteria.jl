import Dates

@testset "terminate_time_limit" begin
    rng = Random.default_rng()
    obj = x->(1-x[1])^2 +100*(x[2]-x[1]^2)^2
    populationSize = 100
    ga = Julia4ML_GA.GeneticAlgorithm(populationSize=populationSize, selection=Julia4ML_GA.roulette_wheel_inv, mutation=Julia4ML_GA.gaussian_displacement)
    pop = Julia4ML_GA.init_gaussian(populationSize, Float64[0.,0.], rng)
    
    
    time_limit=10.0 # to be tested here
    bound = NaN
    max_iter = NaN

    start = Dates.now()

    res = Julia4ML_GA.optimize(pop,
        obj, 
        ga ;
        iterations=max_iter, 
        time_limit=time_limit, 
        obj_bound = bound 
    )

    fin = Dates.now()

    @test isapprox(time_limit, (fin - start)/ Dates.Millisecond(1000), atol=0.5)
end

@testset "terminate_max_iterations" begin
    rng = Random.default_rng()
    obj = x->(1-x[1])^2 +100*(x[2]-x[1]^2)^2
    populationSize = 100
    ga = Julia4ML_GA.GeneticAlgorithm(populationSize=populationSize, selection=Julia4ML_GA.roulette_wheel_inv, mutation=Julia4ML_GA.gaussian_displacement)
    pop = Julia4ML_GA.init_gaussian(populationSize, Float64[0.,0.], rng)
    
    time_limit=NaN
    bound = NaN
    max_iter = 2 # to be tested here

    res = Julia4ML_GA.optimize(pop,
        obj, 
        ga ;
        iterations=max_iter,
        time_limit=time_limit, 
        obj_bound = bound,
        trace_optimization=true
    )

    @test isequal(length(Julia4ML_GA.trace(res).populations), max_iter)
end

@testset "terminate_objective_lower_bound" begin
    rng = Random.default_rng()
    obj = x->(3-x[1])^2 +100*(x[2]-x[1]^2)^2
    populationSize = 100
    ga = Julia4ML_GA.GeneticAlgorithm(populationSize=populationSize, selection=Julia4ML_GA.roulette_wheel_inv, mutation=Julia4ML_GA.gaussian_displacement)
    pop = Julia4ML_GA.init_gaussian(populationSize, Float64[0.,0.], rng)
    
    time_limit=100.0
    bound = 0.1 # to be tested here
    max_iter = NaN

    res = Julia4ML_GA.optimize(pop,
        obj, 
        ga ;
        iterations=max_iter, 
        rng=rng,
        time_limit=time_limit, 
        obj_bound = bound 
    )

    @test res.minmalFitness[1] <= bound
        
end

@testset "termination_warnings" begin
    rng = Random.default_rng()
    obj = x->(1-x[1])^2 +100*(x[2]-x[1]^2)^2
    populationSize = 100
    ga = Julia4ML_GA.GeneticAlgorithm(populationSize=populationSize, selection=Julia4ML_GA.roulette_wheel_inv, mutation=Julia4ML_GA.gaussian_displacement)
    pop = Julia4ML_GA.init_gaussian(populationSize, Float64[0.,0.], rng)
    
    time_limit = NaN 
    bound = 0.008 # to be tested here
    max_iter = NaN

    msg = "No hard termination criterion set (time_limit or iterations). May run indefinetly"

    @test_warn msg res = Julia4ML_GA.optimize(pop,obj,ga;iterations=max_iter,rng=rng,time_limit=time_limit,obj_bound = bound)

    time_limit = NaN
    bound = NaN
    max_iter = NaN

    msg = "No termination criteria set. Created Infinite Loop :)"

    #try
    @test_throws ArgumentError begin
        res = Julia4ML_GA.optimize(pop,
        obj, 
        ga ;
        iterations=max_iter, 
        rng=rng,
        time_limit=time_limit, 
        obj_bound = bound 
    )
    end
        
end