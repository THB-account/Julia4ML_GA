function error_per_sudoku_line(line::Vector{Int8})
    counter = ones(Int8, length(line)) .* -1
    for el in line
        counter[el] += 1
    end
    for (index, el) in enumerate(counter)
        counter[index] = max(0, counter[index])
    end
    return sum(counter)
end

function error_per_sudoku(sudoku::Matrix{Int8})
    errors = 0
    for index in 1:size(sudoku)[1]
        row = sudoku[index, :]
        col = sudoku[:, index]
        errors += error_per_sudoku_line(row)
        #println(row)
        #println(errors)
        errors += error_per_sudoku_line(col)
        #println(col)
        #println(errors)
    end
    square_size = Int(sqrt(size(sudoku)[1]))
    for y in 1:square_size
        for x in 1:square_size
            sq = sudoku[1+((y-1)*square_size):((y)*square_size), 1+((x-1)*square_size):((x)*square_size)]
            errors += error_per_sudoku_line(vcat(sq...))
            #display(sq)
            #println(errors)
        end
    end
    return errors
end

function get_empty_indices_of_sudoku(sudoku::Matrix{Int8})
    indices_list = Vector{Tuple{Int, Int}}(undef, 0)
    sudoku_size = size(sudoku)[1]
    for y in 1:sudoku_size
        for x in 1:sudoku_size
            if sudoku[y, x] == 0
                push!(indices_list, (y, x))
            end
        end
    end
    return indices_list
end

function populant_to_sudoku(sudoku::Matrix{Int8}, empty_indices::Vector{Tuple{Int, Int}}, array::Vector{Int8})
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
        population[i] = shuffle(rng, missing_numbers)
    end

    return population
end

function solve_sudoku(sudoku::Matrix{<:Integer};
    iterations=100,
    populationSize=50,
    eliteSize=5,
    crossoverRate=0.4,
    mutationRate=0.4,
    selection=rank_selection, 
    mutation=displacement, 
    crossover=k_point,
    rng=default_rng())

    sudoku = Int8.(sudoku)

    initpop = init_sudoku_population(populationSize, sudoku, rng)

    empty_indices = get_empty_indices_of_sudoku(sudoku)
    fitnessFun = x -> error_per_sudoku(populant_to_sudoku(sudoku, empty_indices, x))

    result = Julia4ML_GA.optimize(
        initpop,
        x -> fitnessFun(x),
        Julia4ML_GA.GeneticAlgorithm(
            populationSize=populationSize,
            selection=selection,
            mutation=mutation,
            crossover=crossover,
            eliteSize=eliteSize,
            crossoverRate=crossoverRate,
            mutationRate=mutationRate
        );
        iterations=iterations,
        rng=rng
    )

    best_solution = populant_to_sudoku(sudoku, empty_indices, Julia4ML_GA.argmin(result)[1])
    return best_solution, error_per_sudoku(best_solution)
end