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

"""
    init_sudoku_population(population_size::Integer, sudoku::Matrix{Int8}, rng::AbstractRNG)

Initializes a start population with populants which represent a possible solution to the `sudoku`.

- `population_size`: Number of populants.
- `sudoku`: Length of genes are calculated based on empty (0) places in `sudoku`.

Returns population
"""
function init_sudoku_population(population_size::Integer, sudoku::Matrix{Int8}, rng::AbstractRNG)
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

"""
    sudoku_mutation(genes::Vector{Int8}, rng::AbstractRNG, range::Integer = 9)

Adds noise to the genes.

- `genes`: Vector containing all genes. Each gene is a number on the sudoku which can be scrambled.
- `rng`: Instance of a random number generator to produce reproducible results.
- `range`: Indicates the biggest number to put in the sudoku (4 for 4x4 sudoku, 9 for 9x9 sudoku).

Returns resulting genes.
"""
function sudoku_mutation(genes::Vector{Int8}, rng::AbstractRNG, range::Integer = 9)
    p = 1/length(genes)
    for (index, element) in enumerate(genes)
        if rand(rng) <= p
            r_number = rand(rng, 1:range-1)
            if r_number == genes[index]
                r_number = range
            end
            genes[index] = r_number
        end
    end
    return genes
end

"""
    solve_sudoku(sudoku;
    iterations, 
    time_limit, 
    obj_bound,
    populationSize,
    eliteSize,
    crossoverRate,
    mutationRate,
    selection, 
    mutation, 
    crossover,
    rng)

Solves the sudoku.
More information: https://en.wikipedia.org/wiki/Sudoku

- `sudoku`: sudoku.
- `max_iterations`: Maximum number of iterations in optimisation process. Default is `NaN`.
- `time_limit`: Time in seconds after which the optimization should be terminated. Default is `NaN`.
- `obj_bound`: Threshold on (or after) which the optimization should be terminated. Default is `NaN`.
- `rng`: An instance of a random number generator to produce reproducible results.
- `population_size`: Number of populants to be maintained.
- `eliteSize`: Number of populants selected as elite.
- `crossoverRate`: Probability of crossover for two populants.
- `mutationRate`: Probability of mutation.
- `selection`: Function to select populants for next iteration.
- `muation`: Mutation function.
- `crossover`: Crossover function.
- `rng`: An instance of a random number generator to produce reproducible results.

Returns optimization result
"""
function solve_sudoku(sudoku::Matrix{<:Integer};
    iterations=10000, 
    time_limit=10, 
    obj_bound=0,
    populationSize=1000,
    eliteSize=5,
    crossoverRate=0.5,
    mutationRate=0.9,
    selection=rank_selection, 
    mutation=sudoku_mutation, 
    crossover=k_point,
    rng=default_rng())

    sudoku = Int8.(sudoku)

    if mutation == sudoku_mutation
        function sudoku_mutation_correct_range(genes::Vector{Int8}, rng)
            return sudoku_mutation(genes, rng, size(sudoku)[1])
        end
        mutation = sudoku_mutation_correct_range
    end

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
        time_limit=time_limit, 
        obj_bound=obj_bound,
        rng=rng
    )

    best_solution = populant_to_sudoku(sudoku, empty_indices, Julia4ML_GA.argmin(result)[1])
    return best_solution, error_per_sudoku(best_solution)
end