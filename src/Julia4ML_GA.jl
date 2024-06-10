module Julia4ML_GA

using Random: MersenneTwister, default_rng,seed!
# Write your package code here.

include("api/types.jl")
include("api/objective.jl")

include("crossover.jl")
include("mutation.jl")
include("selection.jl")
include("initialization.jl")
include("ga.jl")
include("api/optimize.jl")
include("api/utils.jl")

include("mutation.jl")
include("selection.jl")
include("crossover.jl")

export roulette_wheel, 
displacement, 
single_point, gaussian_displacement, univariate_displacement, init_gaussian

end
