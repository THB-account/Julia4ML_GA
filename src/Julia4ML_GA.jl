module Julia4ML_GA
using Random:default_rng

using Random: MersenneTwister, default_rng
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



export roulette_wheel, displacement, single_point


include("mutation.jl")
include("selection.jl")
include("crossover.jl")

end
