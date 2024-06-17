using Dates
"""
    Holds information about termination criteria
"""
mutable struct Terminator
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
function terminate!(t::Terminator, ga::GeneticAlgorithm, state::GeneticAlgorithmState, objective)
    t.iterations += 1
    #println(t.iterations)
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
        val, min = findmin(state.populationFitness,dims=1)
        #print(min, " ", typeof(val))
        #v = objective(state.population[min])
        #println("obj_val: ", val[1])
        if val[1] < t.obj_bound
            again = false
        end
    end
    
    return again
end