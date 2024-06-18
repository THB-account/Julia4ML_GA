import Random
import Julia4ML_GA

@testset "crossover" begin
    @testset "Single Point" begin
        rng = Random.Xoshiro()
		Random.seed!(rng, 3)
        child1, child2 = Julia4ML_GA.single_point([-24, -2, -6, -3, -5], [4, 2, 1, 3, 5], rng)
		@test child1 == [-24, -2, 1, 3, 5]
        @test child2 == [4, 2, -6, -3, -5]
	end	

    @testset "Single Point: Test length" begin
        rng = Random.default_rng()
        number_of_runs = 10
        all_crossover_points = zeros(number_of_runs)
        for i in 1:number_of_runs
            length_genes = i
            genes1 = zeros(length_genes)
            genes2 = ones(length_genes)

            child1, child2 = Julia4ML_GA.single_point(genes1, genes2, rng)
            
            # Test length
            @test length(child1) == length_genes
            @test length(child2) == length_genes

            # Test value
            @test sum(child1) + sum(child2) == sum(genes1) + sum(genes2)

            #println(child1)
            #println(child2)

            # Test if genes of children are changed after single point
            crossover_point = false
            for (index, element) in enumerate(child1)
                if !crossover_point && child1[index] != genes1[index]
                    crossover_point = true
                    all_crossover_points[i] = index
                end
                if crossover_point
                    @test child1[index] == genes2[index]
                    @test child2[index] == genes1[index]
                else
                    @test child1[index] == genes1[index]
                    @test child2[index] == genes2[index]
                end
            end
        end
        # all_crossover_points should contain values from 0 (no change) up to length of genes
        # println(all_crossover_points) 
    end
end