using Julia

Julia4ML_GA.optimize(Float64[0.,0.],x->(1-x[1])^2 +100*(x[2]-x[1]^2)^2,Julia4ML_GA.GeneticAlgorithm();iterations=100)