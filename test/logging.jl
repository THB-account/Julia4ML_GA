using Julia4ML_GA
using Random:default_rng

@testset "logging" begin
    """
    1. check for errors when creating
    """
    rbf = x -> (1-x[1])^2 +100*(x[2]-x[1]^2)^2
    trace = Julia4ML_GA.OptimizationTrace()
    res = Julia4ML_GA.OptimizationResult([1.,1.],rbf([1.,1.]),trace)
    @testset "result object" begin
        @test Julia4ML_GA.argmin(res)==[1.,1.]
        @test Julia4ML_GA.min(res)==rbf([1.,1.])
        @test Julia4ML_GA.trace(res) === trace
    end

    @testset "trace creation" begin
        @test Julia4ML_GA.trace(res).populations == []
        @test Julia4ML_GA.trace(res).fitnessValues == []
        @test Julia4ML_GA.trace(res).fittestPopulants == []
    end

    populationSize = 50
    state = Julia4ML_GA.GeneticAlgorithmState(init_gaussian([0.,0.],populationSize,default_rng()),rbf)
    Julia4ML_GA.append!(trace,state)
    Julia4ML_GA.append!(trace,state)

    @testset "trace appending" begin
        @test length(Julia4ML_GA.trace(res).populations[1]) == populationSize
        @test length(Julia4ML_GA.trace(res).fitnessValues[1]) == 50
        @test Julia4ML_GA.trace(res).populations[1] == state.population
        @test Julia4ML_GA.trace(res).fitnessValues[1] == state.populationFitness
        @test Julia4ML_GA.trace(res).fittestPopulants[1] == state.fittest
        # no passing an object that can be accessed from the outside
        @test Julia4ML_GA.trace(res).populations[1] !== state.population
        @test Julia4ML_GA.trace(res).fitnessValues[1] !== state.populationFitness
        @test Julia4ML_GA.trace(res).fittestPopulants[1] !== state.fittest
    end

    
end