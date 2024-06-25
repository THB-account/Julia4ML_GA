import Random
import Julia4ML_GA

@testset "Other" begin
    @testset "Get Sub vector" begin
        @testset "Get Sub vector: test error" begin
            t_vec_size = 5
            t_vec = [i for i in 1:t_vec_size]
            error_thrown = false
            try
                r = Julia4ML_GA.get_sub_vector(t_vec, 5, 4)
            catch
                error_thrown = true
            end
            @test error_thrown
            error_thrown = false
            try
                r = Julia4ML_GA.get_sub_vector(t_vec, 2, 1)
            catch
                error_thrown = true
            end
            @test error_thrown
        end

        @testset "Get Sub vector: test length" begin
            result_set = Set()
            t_vec_size = 5
            t_vec = [i for i in 1:t_vec_size]
            for i in 1:t_vec_size
                for j in 2:t_vec_size+1
                    r = Julia4ML_GA.get_sub_vector(t_vec, i, j, true)
                    # println("s: ", i, ", e: ", j, ", r:", r)
                    if length(r) != 0
                        @test !(r in result_set)
                        push!(result_set, r)
                    end
                    if i == j
                        @test length(r) == 0
                    elseif i < j
                        @test length(r) == j - i
                    else
                        @test length(r) == (length(t_vec) - i) + (j)
                    end
                end
            end
        end
	end
end