import Random
import Julia4ML_GA


@testset "Sudoku" begin
    @testset "Error per line" begin
        array = Int8.([i for i in 1:5])
        @test Julia4ML_GA.error_per_sudoku_line(array) == 0
        array[1] = 2
        @test Julia4ML_GA.error_per_sudoku_line(array) == 1
        array[4] = 2
        @test Julia4ML_GA.error_per_sudoku_line(array) == 2
    end

    @testset "Error per Sudoku" begin
        sudoku = Int8.([
            3 1 2 4;
            4 2 3 1;
            2 4 1 3;
            1 3 4 2
        ])
        @test Julia4ML_GA.error_per_sudoku(sudoku) == 0
        sudoku[1, 1] = 4
        @test Julia4ML_GA.error_per_sudoku(sudoku) == 3
    end

    @testset "Empty indices" begin
        array = zeros(Int8, 4, 4)
        array[1, 2] = 1
        array[2, 4] = 2
        array[3, 1] = 3
        array[4, 1] = 4
        empty_indices = Julia4ML_GA.get_empty_indices_of_sudoku(array)
        @test empty_indices == [(1, 1), (1, 3), (1, 4), (2, 1), (2, 2), (2, 3), (3, 2), (3, 3), (3, 4), (4, 2), (4, 3), (4, 4)]
    end

    @testset "Initialize" begin
        sudoku = Int8.([
            0 1 0 4;
            4 2 3 1;
            0 0 0 0;
            1 0 0 0
            ])
        rng = Random.default_rng()

        p_size = 10
        p = Julia4ML_GA.init_sudoku_population(p_size, sudoku, rng)
        @test length(p) == p_size
    end

    @testset "Sudoku 4 x 4" begin
        rng = Random.default_rng()

        sudoku = [
            0 1 0 4;
            4 2 3 1;
            0 0 0 0;
            1 0 0 0
            ]

        best_solution, errors = Julia4ML_GA.solve_sudoku(sudoku)
        @test errors < 5
        # display(solution)
        # println("Errors: ", error_per_sudoku(solution))
    end

    @testset "Sudoku 9 x 9" begin
        rng = Random.default_rng()

        #sudoku = Int8.([
        #    0 3 0 0 0 0 0 0 0;
        #    0 0 0 1 9 5 0 0 0;
        #    0 0 8 0 0 0 0 6 0;
        #    8 0 0 0 6 0 0 0 0;
        #    4 0 0 8 0 0 0 0 1;
        #    0 0 0 0 2 0 0 0 0;
        #    0 6 0 0 0 0 2 8 0;
        #    0 0 0 4 1 9 0 0 5;
        #    0 0 0 0 0 0 0 7 0
        #    ])
        sudoku = [
            0 1 0 0 7 5 9 4 0;
            4 0 2 0 0 6 0 0 7;
            0 3 0 9 0 1 0 0 8;
            6 0 0 5 2 0 4 9 0;
            0 5 8 0 0 3 0 2 6;
            1 0 4 0 0 7 0 3 0;
            0 0 9 8 0 0 0 0 2;
            7 0 0 1 6 0 3 0 0;
            2 0 0 0 3 0 6 5 4
            ]

        best_solution, errors = Julia4ML_GA.solve_sudoku(sudoku, iterations=10000)
        
        @test errors < 25
        # display(solution)
    end
end
