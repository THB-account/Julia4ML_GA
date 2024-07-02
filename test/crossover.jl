import Random
import Julia4ML_GA

@testset "crossover" begin
    @testset "Partially mapped" begin
        rng = Random.MersenneTwister()
		Random.seed!(rng, 3)
        child1, child2 = Julia4ML_GA.partially_mapped([1, 2, 3, 4, 5, 6, 7, 8], [3, 7, 5, 1, 6, 8, 2, 4], rng)
	end

    @testset "Partially mapped: test length" begin
        rng = Random.default_rng()
        number_of_runs = 10
        t_vec_size = 5
        t_vec = [i for i in 1:t_vec_size]
        t_vec_2 = Random.shuffle(t_vec)

        for i in 1:number_of_runs
            r1, r2 = Julia4ML_GA.partially_mapped(t_vec, t_vec_2, rng)
            @test length(t_vec) == length(Set(r1)) && length(t_vec) == length(Set(r2))
        end
    end

    @testset "Single Point" begin
        rng = Random.MersenneTwister()
		Random.seed!(rng, 3)
        child1, child2 = Julia4ML_GA.k_point([-24, -2, -6, -3, -5], [4, 2, 1, 3, 5], rng, 1)
		@test child1 == [-24, -2, -6, 3, 5]
        @test child2 == [4, 2, 1, -3, -5]
	end	

    @testset "Single Point: Test length" begin
        rng = Random.default_rng()
        number_of_runs = 10
        all_crossover_points = zeros(number_of_runs)
        for i in 1:number_of_runs
            length_genes = i
            genes1 = zeros(length_genes)
            genes2 = ones(length_genes)

            child1, child2 = Julia4ML_GA.k_point(genes1, genes2, rng, 1)
            
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