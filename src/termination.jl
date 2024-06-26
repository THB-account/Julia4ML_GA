"""
    Holds information about termination criteria. Starts timer upon creation, if a timelimit is provided.

- 'max_iterations': (Integer/NaN) Maximum number of iterations in optimisation process. Default is NaN.
- 'time_limit': (Float/NaN) Time after which the optimization should be terminated. Default is NaN.
- 'obj_bound': (Float/NaN) Threshold after which the optimization should be terminated. Default is NaN.

Throws 
    - 'ArgumentError' if no termination condition is set.
    - Warning if no time or iteration limit is provided.

Constructor:

    Terminator(;max_iter=NaN, time_limit=NaN, obj_bound=NaN)
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

    function Terminator(
        ;max_iter::Union{Float64, Int} = NaN, 
        time_limit::Float64 = NaN, 
        obj_bound::Float64 = NaN
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
- 't': (Terminator) contains termination criteria
- 'state': (GeneticAlgorithmState)

Returns false if algorithm should terminate.
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
    if !isnan(t.max_iterations)
        curr = now()
        if (curr - t.starting_time)/ Millisecond(1000) >= t.time_limit
            again = false
        end
    end
    
    #check objective value
    if !isnan(t.obj_bound)
        val, __ = findmin(state.populationFitness,dims=1)
        if val[1] < t.obj_bound
            again = false
        end
    end
    
    return again
end