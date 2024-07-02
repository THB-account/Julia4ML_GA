# Termination Criteria

For the package are three different criteria available: Number of iterations, time limit and a lower bound.
All three can be specified in the [optimize](@ref Julia4ML_GA.optimize) function via the keyword arguments `iterations`, `time_limit` and `obj_bound`.


They are optional and can be used in combination. Whichever of the three applies first will terminate the optimization loop and the results will be returned.
If none of the criteria is set the optimization process will not be started and and error will be thrown.
In case both `iterations` and `time_limit` are not set a warning is raised, that a lower bound may never be reached.

### Number of iterations

With this setting the optimization process will have at most `iterations` optimization steps. An integer number is expected.

### Time limit

The keyword argument `time_limit` expects a float as time in seconds.
With this setting execution time is checked after each optimization step. 

### Lower bound

With this argument the lower bound for the objective function value is set. 
If the fittest populant reaches an objective value lower or equal than the bound the algorithm finishes.
Note that only setting this criterium may result in infinite loops.
