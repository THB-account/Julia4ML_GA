"""
Holds information about termination criteria. Starts timer upon creation, if a timelimit is provided.

- `max_iterations`: `Real` Maximum number of iterations in optimisation process.
- `time_limit`: `Real` Time in seconds after which the optimization should be terminated.
- `obj_bound`: `Real` Threshold on (or after) which the optimization should be terminated.

Throws 

- `ArgumentError` if no termination condition is set.
- Warning if no time or iteration limit is provided.

Constructor:

    function Terminator(;
        max_iter::Real=NaN, 
        time_limit::Real=NaN, 
        obj_bound::Real=NaN
    )
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

    function Terminator(;
        max_iter::Real=NaN, 
        time_limit::Real=NaN, 
        obj_bound::Real=NaN
    )
        if isnan(max_iter) && isnan(time_limit)
            if isnan(obj_bound)
                throw(ArgumentError("No termination criteria set. Created Infinite Loop :)"))
        #        pass
            else
                @warn "No hard termination criterion set (time_limit or iterations). May run indefinetly"
            end
        end
        new(max_iter, 0, time_limit, now(), obj_bound)
    end
end


"""
    terminate(t::Terminator, state::GeneticAlgorithmState)

Evaluates configured termination criteria.

- `t`: contains termination criteria
- `state`: GeneticAlgorithmState instance

Returns `false` if algorithm should terminate.
"""
function terminate!(t::Terminator, state::GeneticAlgorithmState)
    again = true  
    
    # check iterations
    if !isnan(t.max_iterations)
        if  (t.iterations >= t.max_iterations)
            again = false
        end
        t.iterations += 1
    end

    # check time
    if !isnan(t.time_limit)
        curr = now()
        if (curr - t.starting_time)/ Millisecond(1000) >= t.time_limit
            again = false
        end
    end
    
    # check objective value
    if !isnan(t.obj_bound)
        val, __ = findmin(state.populationFitness,dims=1)
        if val[1] <= t.obj_bound
            again = false
        end
    end
    
    return again
end