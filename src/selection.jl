using Random



function test_roulette_wheel()
    fit = [rand(Float64) for i in 1:5]
    rng = MersenneTwister(1234);
    return roulette_wheel(rng, fit, 10)
end

"""
    roulette_wheel(rng, fitness, selection_number)

Implements a simple roulette_wheel.
`rng` is an instance of a random number generator to produce reproducible results.
`fitness` is a vector pf fitness values. 
The higher, the more likely the corresponding chromosome is selected.
`selection_number` indicates how many indices are returned.
`result` stores the indices of the chromosomes.
"""
function roulette_wheel(rng, fitness, selection_number)
    total_fitness = 0
    fitness_border = similar(fitness)
    for (index, value) in enumerate(fitness)
        total_fitness += value
        fitness_border[index] = total_fitness
    end
    # print(fitness_border)
    result = zeros(Integer, selection_number)
    for i in 1:selection_number
        random_number = rand(rng, Float64) * total_fitness
        # print(random_number)
        for (index, value) in enumerate(fitness_border)
            if random_number < value
                result[i] = index
                break
            end
        end
    end
    # print(result)
    return result
end

export roulette_wheel
export test_roulette_wheel