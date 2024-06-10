# Contents of test/runtests.jl
using Julia4ML_GA
using Test

@testset "Julia4ML_GA.jl" begin
    # Write your tests here.
    include("SystemTests.jl")


end