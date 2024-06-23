import Random
import Julia4ML_GA

function error_per_line(array)
    counter = ones(Int8, length(array)) .* -1
    for el in array
        counter[el] += 1
    end
    for (index, el) in enumerate(counter)
        counter[index] = max(0, counter[index])
    end
    return sum(counter)
end

function error_per_sudoku(array)
    errors = 0
    for index in 1:size(array)[1]
        row = array[index, :]
        col = array[:, index]
        errors += error_per_line(row)
        #println(row)
        #println(errors)
        errors += error_per_line(col)
        #println(col)
        #println(errors)
    end
    square_size = Int(sqrt(size(array)[1]))
    for y in 1:square_size
        for x in 1:square_size
            sq = array[1+((y-1)*square_size):((y)*square_size), 1+((x-1)*square_size):((x)*square_size)]
            errors += error_per_line(vcat(sq...))
            #display(sq)
            #println(errors)
        end
    end
    return errors
end

function get_empty_indices(array)
    indices_list = Vector{Tuple{Int, Int}}(undef, 0)
    sudoku_size = size(array)[1]
    for y in 1:sudoku_size
        for x in 1:sudoku_size
            if array[y, x] == 0
                push!(indices_list, (y, x))
            end
        end
    end
    return indices_list
end

function array_to_sudoku(sudoku, empty_indices, array)
    for (index, el) in enumerate(empty_indices)
        sudoku[el...] = array[index] # same as [1], el[2]
    end
    return sudoku
end

function init_sudoku_population(population_size::Integer, sudoku::Matrix{Int8}, rng)
    population = Vector{Vector{Int8}}(undef, population_size)

    sudoku_size = size(sudoku)[1]

    counter = zeros(Int8, sudoku_size)
    for el in sudoku
        if el != 0
            counter[el] += 1
        end
    end

    missing_numbers = []
    for (index, element) in enumerate(counter)
        missing_numbers_element = sudoku_size - element
        if missing_numbers_element < 0
            error("Sudoku can not be solved. Abort Initialize.")
        end
        while missing_numbers_element > 0
            push!(missing_numbers, index)
            missing_numbers_element -= 1
        end
    end

    for i in 1:population_size
        population[i] = Random.shuffle(rng, missing_numbers)
    end

    return population
end


@testset "Sudoku" begin
    @testset "Error per line" begin
        array = [i for i in 1:5]
        @test error_per_line(array) == 0
        array[1] = 2
        @test error_per_line(array) == 1
        array[4] = 2
        @test error_per_line(array) == 2
    end

    @testset "Error per Sudoku" begin
        sudoku = Int8.([
            3 1 2 4;
            4 2 3 1;
            2 4 1 3;
            1 3 4 2
        ])
        @test error_per_sudoku(sudoku) == 0
        sudoku[1, 1] = 4
        @test error_per_sudoku(sudoku) == 3
    end

    @testset "Empty indices" begin
        array = zeros(Int8, 4, 4)
        array[1, 2] = 1
        array[2, 4] = 2
        array[3, 1] = 3
        array[4, 1] = 4
        empty_indices = get_empty_indices(array)
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
        p = init_sudoku_population(p_size, sudoku, rng)
        @test length(p) == p_size
    end

    @testset "Sudoku 4 x 4" begin
        rng = Random.default_rng()

        sudoku = Int8.([
            0 1 0 4;
            4 2 3 1;
            0 0 0 0;
            1 0 0 0
            ])

        # display(sudoku)
        pop_size = 100
        initpop = init_sudoku_population(pop_size, sudoku, rng)

        empty_indices = get_empty_indices(sudoku)
        fitnessFun = x -> error_per_sudoku(array_to_sudoku(sudoku, empty_indices, x))

        for el in initpop
            init_sol = array_to_sudoku(sudoku, empty_indices, el)
            # println("Errors (initial populant): ", error_per_sudoku(init_sol))
        end

        

        result = Julia4ML_GA.optimize(
            initpop,
            x -> fitnessFun(x),
            Julia4ML_GA.GeneticAlgorithm(
                populationSize=pop_size,
                selection=rank_selection,
                mutation=displacement
            );
            iterations=1000,
            rng=rng
        );
        
        solution = array_to_sudoku(sudoku, empty_indices, Julia4ML_GA.argmin(result)[1])
        @test error_per_sudoku(solution) < 5
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
        sudoku = Int8.([
            0 1 0 0 7 5 9 4 0;
            4 0 2 0 0 6 0 0 7;
            0 3 0 9 0 1 0 0 8;
            6 0 0 5 2 0 4 9 0;
            0 5 8 0 0 3 0 2 6;
            1 0 4 0 0 7 0 3 0;
            0 0 9 8 0 0 0 0 2;
            7 0 0 1 6 0 3 0 0;
            2 0 0 0 3 0 6 5 4
            ])

        # display(sudoku)
        pop_size = 100
        initpop = init_sudoku_population(pop_size, sudoku, rng)

        empty_indices = get_empty_indices(sudoku)
        fitnessFun = x -> error_per_sudoku(array_to_sudoku(sudoku, empty_indices, x))

        for el in initpop
            init_sol = array_to_sudoku(sudoku, empty_indices, el)
            # println("Errors (initial populant): ", error_per_sudoku(init_sol))
        end

        function rank_squared_selection(fitness::Vector{<:Real}, selection_number::Int, rng)
            return Julia4ML_GA.rank_selection(fitness, selection_number, rng, x -> x*x)
        end

        result = Julia4ML_GA.optimize(
            initpop,
            x -> fitnessFun(x),
            Julia4ML_GA.GeneticAlgorithm(
                populationSize=pop_size,
                selection=rank_squared_selection,
                mutation=displacement,
                crossoverRate=0.3,
                mutationRate=0.3
            );
            iterations=10000,
            rng=rng
        );
        
        solution = array_to_sudoku(sudoku, empty_indices, Julia4ML_GA.argmin(result)[1])
        @test error_per_sudoku(solution) < 25
        # display(solution)
    end
end
