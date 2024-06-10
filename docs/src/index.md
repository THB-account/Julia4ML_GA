```@meta
CurrentModule = Julia4ML_GA
```

# Julia4ML_GA

[Julia4ML_GA](https://github.com/THB-account/Julia4ML_GA.jl) is a package for genetic algorithms.

## What is a genetic algorithm

[Genetic algorithms](https://en.wikipedia.org/wiki/Genetic_algorithm) solve optimization problems by
- creating a *population* of candidate solutions, each with their own *genomes*
- evaluating them with a *fitness function* and iteratively selecting only the best candidates
- maintaining the population size by creating new *populants* via *crossover* between successful populants
- *mutating* populants in random places of their genome

![Genetic Algorithm Loop](./Basic-Traditional-Genetic-Algorithm-Loop.png)

## Basic example


    using Julia4ML_GA

    # starting point initialized with zeros
    starting_point = Float64[0.,0.]

    # rosenbrock function as fitness function
    fitness_function = x->(1-x[1])^2 +100*(x[2]-x[1]^2)^2
    
    # setting populaition size manually (default is 50)
    ga_instance = Julia4ML_GA.GeneticAlgorithm(populationSize=100)

    # 100 iterations containing crossover, mutation, evaluation, selection to be performed
    iterations=100

    # Execute optimisation process
    fittest = Julia4ML_GA.optimize(starting_point,fitness_function,ga_instance;iterations)

    println(fittest)

    

