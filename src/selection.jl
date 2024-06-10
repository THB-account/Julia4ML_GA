function test_roulette_wheel()
    fit = [rand(Float64) for i in 1:5]
    rng = MersenneTwister(1234);
    return roulette_wheel(fit, 10,rng)
end

"""
    roulette_wheel(fitness, selection_number,rng)

Implements a simple roulette_wheel.

- `fitness`: (Vector{Float64}) Vector of fitness values. The higher, the more likely the corresponding chromosome is selected.
- `selection_number`: (Integer) Indicates how many indices are returned.
- `rng`: Instance of a random number generator to produce reproducible results.

Returns indices of selected populants.
"""
function roulette_wheel(fitness, selection_number, rng)
    total_fitness = 0
    fitness_border = similar(fitness)
    for (index, value) in enumerate(fitness)
        total_fitness += value
        fitness_border[index] = total_fitness
    end

    result = zeros(Integer, selection_number)
    for i in 1:selection_number
        random_number = rand(rng, Float64) * total_fitness

        for (index, value) in enumerate(fitness_border)
            if random_number < value
                result[i] = index
                break
            end
        end
    end

    return result
end