using Dates
using Logging
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

    function Terminator(;max_iter=NaN, time_limit=NaN, obj_bound=NaN)
        if isnan(max_iter) && isnan(time_limit)
        #    if isnan(obj_bound)
                #throw(ArgumentError("No termination criteria set. Created Infinite Loop :)"))
        #        pass
        #    else
            @warn "No hard termination criterion set (time_limit or iterations). May run indefinetly"
        #    end
        end
        new(max_iter, 0, time_limit, now(), obj_bound)
    end
end


"""
    terminate(t::Terminator, state::GeneticAlgorithmState)

Evaluates configured termination criteria.
- 't': (Terminator) contains termination criteria
- 'state': (GeneticAlgorithmState)

Returns false if algorithm should terminate.
"""
function terminate!(t::Terminator, state::GeneticAlgorithmState)
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
        val, min = findmin(state.populationFitness,dims=1)
        if val[1] < t.obj_bound
            again = false
        end
    end
    
    return again
end