using Dates
"""
    Holds information about termination criteria
"""
struct Terminator
    # terminate by iterations
    max_iterations
    iterations

    # terminate by time limit
    time_limit # in seconds
    starting_time

    # terminate by bound of objective value
    obj_bound

    function Terminator(;max_iter=1000, time_limit=600, obj_bound=NaN)
        new(max_iter, 0, time_limit, now(), obj_bound)
    end
end


"""
    terminate(ga::GeneticAlgorithm, state::GeneticAlgorithmState)

Evaluates configured termination criteria.
- 'ga': (GeneticAlgorithm) contains termination criteria
- 'state': (GeneticAlgorithmState)

Returns false if algorithm should terminate.
"""
function terminate!(t::Terminator, ga::GeneticAlgorithm, state::GeneticAlgorithmState, iterations)
    t.iterations += 1
    again = true  
    
    # check iterations
    if t.iterations >= t.max_iterations
        again = false
    end

    # check time
    curr = now()
    if (curr - t.starting_time)/ Millisecond(1000) >= t.time_limit
        again = false
    end
    
    #check objective value
    if !isnan(t.obj_bound)
        min = findmin(state.populationFitness,dims=1)
        v = ga.objective(state.population[min])
        if v < t.obj_bound
            again = false
        end
    end
    println("objective not yet reached:", again)
    return again
end