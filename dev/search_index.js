var documenterSearchIndex = {"docs":
[{"location":"reference/#Julia4ML_GA-API","page":"API Reference","title":"Julia4ML_GA API","text":"","category":"section"},{"location":"reference/","page":"API Reference","title":"API Reference","text":"","category":"page"},{"location":"reference/","page":"API Reference","title":"API Reference","text":"Modules = [Julia4ML_GA]","category":"page"},{"location":"reference/#Julia4ML_GA.GeneticAlgorithm","page":"API Reference","title":"Julia4ML_GA.GeneticAlgorithm","text":"Contains information and functions to execute an optimization process for a genetic algorithm.\n\npopulation_size: (Integer) Number of populants to be maintained.\neliteSize: (Integer) Number of populants selected as elite.\ncrossoverRate: (Float) Probability of crossover for two populants.\nmutationRate: (Float) Probability of mutation.\nselection: (Function) Function to select populants for next iteration.\nmuation: (Function) Mutation function.\ncrossover: (Function) Crossover function.\n\nConstructor:\n\nGeneticAlgorithm(;\n    populationSize=50,\n    eliteSize=5,\n    crossoverRate=0.8,\n    mutationRate=0.1,\n    selection=roulette_wheel,\n    mutation=displacement,\n    crossover=k_point\n)\n\n\n\n\n\n","category":"type"},{"location":"reference/#Julia4ML_GA.GeneticAlgorithmState","page":"API Reference","title":"Julia4ML_GA.GeneticAlgorithmState","text":"State of a genetic algorithm.\n\npopulation: (Vector) Current population. Vector conatining elements of same type as starting point for optimization process.\npopulationFitness: (Function) Fitness function by which the population's fitness is to be evaluated.\n\nConstructor:\n\nGeneticAlgorithmState(population,objective)\n\n\n\n\n\n","category":"type"},{"location":"reference/#Julia4ML_GA.OptimizationResult","page":"API Reference","title":"Julia4ML_GA.OptimizationResult","text":"Contains the results of a evolutionary optimization process\n\nminimalPopulant: (Vector{Vector{Real}}) Populant that minimizes the objective.\nminimalFitness: (Vector{Real}) Value of the objective for the minimal populant.\ntrace: (OptimizationTrace) Trace object containing individual values of generations.\n\nConstructor:\n\nOptimizationResult(minimalPopulant,minmalFitness,trace)\n\n\n\n\n\n","category":"type"},{"location":"reference/#Julia4ML_GA.OptimizationTrace","page":"API Reference","title":"Julia4ML_GA.OptimizationTrace","text":"Contains information and functions to execute an optimization process for a genetic algorithm.\n\npopulations: (Vector{Vector{Vector{Real}}}) Population of each iteration.\nfitnessValues: (Vector{Vector{Real}}) Fitness values of each generation.\nfittestPopulants: (Vector{Vector{Real}}) Fittest Individual of each population.\n\nConstructor:\n\nOptimizationTrace()\n\n\n\n\n\n","category":"type"},{"location":"reference/#Julia4ML_GA.append!-Tuple{Julia4ML_GA.AbstractTrace, Julia4ML_GA.AbstractState}","page":"API Reference","title":"Julia4ML_GA.append!","text":"append!(trace,state)\n\nInitialises populant's genes.\n\ntrace: (AbstractTrace) Trace struct containing values\nstate: (AsbtractState) A state of a genetic algorithm.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.argmin-Tuple{Julia4ML_GA.OptimizationResult}","page":"API Reference","title":"Julia4ML_GA.argmin","text":"argmin(res)\n\nres: (OptimizationResult)\n\nReturns minimizing gene\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.bit_inversion-Tuple{Vector{Bool}, Any}","page":"API Reference","title":"Julia4ML_GA.bit_inversion","text":"bit_inversion(gene, rng)\n\nInverses each bit with probability 1/length(gene).\n\nrng: Instance of a random number generator to produce reproducible results.\ngene: (Vector{Bool}) Vector containing all genes of a chromosome.\n\nReturns resulting gene.\n\n!!! Only applicable for problems with true/false genes (knapsack) !!!\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.crossover!-NTuple{5, Any}","page":"API Reference","title":"Julia4ML_GA.crossover!","text":"crossover!(parents,children,selected_individuals,ga,rng)\n\nControl function for crossover.\n\nparents: (Vector) (Sub-)Population to be used to create offspring.\nchildren (Vector) Object to hold the newly created offspring.\nselected_individuals: (Vector{Integer}) The for crossover selected populant's indices.\nga: (GeneticAlgorithm) GeneticAlgorithm instance the population is part of.\nrng:  Instance of a random number generator to produce reproducible results.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.displacement-Tuple{Vector{var\"#s17\"} where var\"#s17\"<:Real, Any}","page":"API Reference","title":"Julia4ML_GA.displacement","text":"displacement(gene, rng)\n\nImplements the displacement method.\n\ngene: ::Vector{<:Real} containing all genes of a chromosome.\nrng: Instance of a random number generator to produce reproducible results.\n\nReturns resulting gene.\n\nThe genes are displaced inside itself. The returned element has the same values as before, but with scrambled genes.\n\n!!! Only applicable for combinatorial problems (knapsack) !!!\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.evaluation!-Tuple{Any, Any, Any}","page":"API Reference","title":"Julia4ML_GA.evaluation!","text":"evaluation!(ga,state,objective)\n\nControl function for fitness evaluation.\n\nga: (GeneticAlgorithm) GeneticAlgorithm instance to work on.\nstate:  (GeneticAlgorithmState) GeneticAlgorithmState instance to proceed from.\nobjective: (Function) Fitness function by which the population is evaluated.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.gaussian_displacement-Tuple{Vector{var\"#s17\"} where var\"#s17\"<:Real, Any}","page":"API Reference","title":"Julia4ML_GA.gaussian_displacement","text":"gaussian_displacement(gene, rng)\n\nAdds gaussian noise to the gene with mathcalN(01).\n\nrng: Instance of a random number generator to produce reproducible results.\ngene: (Vector{Float64}) Vector containing all genes of a chromosome.\n\nReturns resulting gene.\n\n!!! Only applicable for numerical problems (rosenbrock) !!!\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.get_sub_vector","page":"API Reference","title":"Julia4ML_GA.get_sub_vector","text":"get_sub_vector(vec, s, e, allow_wrap)\n\nReturns a part of the vector. \n\nvec: Vector{<:Real}\ns: Start Index (including) [1, length]\ne: End index (not including) [2, length + 1]\nallow_wrap: If true, start can be behind end\n\n\n\n\n\n","category":"function"},{"location":"reference/#Julia4ML_GA.initialise_genetic_state-NTuple{4, Any}","page":"API Reference","title":"Julia4ML_GA.initialise_genetic_state","text":"initialise_genetic_state(starting_point,objective,ga,rng)\n\nInitialises populant's genes.\n\nstarting_point: (Vector{Float64})\nobjective: (Function) Fitness function to be used.\nga: (GeneticAlgorithm) GeneticAlgorithm instance to work on.\nrng: Instance of a random number generator to produce reproducible results.\n\nReturns GeneticAlgorithmState.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.k_point","page":"API Reference","title":"Julia4ML_GA.k_point","text":"k_point(genes1, genes2,rng)\n\nImplements the k point crossover method.\n\ngenes1, genes2: Vector{<:Real} containing all genes of a chromosome.\nrng: An instance of a random number generator to produce reproducible results.\nk: Number of cross over points\n\nReturns child1 and child2\n\ngenes1 and genes2 are used to create child1 and child2, which are returned.  child1 is a copy of genes1 up to randomly generated crossover point.  After that it is a copy of genes2. The same for child2 respectively with parent roles swapped. If more than one crossover point exist this procedure is repeated. If k == 1, this is single point crossover\n\n\n\n\n\n","category":"function"},{"location":"reference/#Julia4ML_GA.min-Tuple{Julia4ML_GA.OptimizationResult}","page":"API Reference","title":"Julia4ML_GA.min","text":"min(res)\n\nres: (OptimizationResult)\n\nReturns minimal fitness value\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.mutation!-Tuple{Any, Any, Any}","page":"API Reference","title":"Julia4ML_GA.mutation!","text":"mutation!(offspring,ga,rng)\n\ncontrol function for mutation.\n\npopulation: (Vector) (Sub-)Population to be mutated.\nga: (GeneticAlgorithm) GeneticAlgorithm instance the population is part of.\nrng: Instance of a random number generator to produce reproducible results.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.optimize-Tuple{Any, Any, Julia4ML_GA.GeneticAlgorithm}","page":"API Reference","title":"Julia4ML_GA.optimize","text":"optimize(starting_point,objective,ga::GeneticAlgorithm;iterations=100,rng=default_rng())\n\nExecutes optimization process\n\nstarting_point: (Vector) Initial candidate.\nobjective: (Function) Fitness function to evaluate population. \niterations: (Integer) Maximum number of iterations.\nrng: Instance of a random number generator to produce reproducible results. Default is Random.default_rng().\n\nReturns final population's fittest populant.\n\nPopulation is initialized and build.  Then the optimization is executed using the provided fitness function.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.partially_mapped-Tuple{Vector{var\"#s16\"} where var\"#s16\"<:Real, Vector{var\"#s15\"} where var\"#s15\"<:Real, Any}","page":"API Reference","title":"Julia4ML_GA.partially_mapped","text":"partially_mapped(genes1, genes2,rng)\n\nImplements the partially mapped crossover (PMX) method.\n\ngenes1, genes2: Vector{<:Real} containing all genes of a chromosome.\nrng: An instance of a random number generator to produce reproducible results.\n\nReturns child1 and child2\n\ngenes1 and genes2 are used to create child1 and child2, which are returned. \n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.rank_selection","page":"API Reference","title":"Julia4ML_GA.rank_selection","text":"rank_selection(fitness, selection_number, rng)\n\nImplements rank selection based on roulette_wheel. Can deal with mixed positive and negative values. Selects based on order of fitness values. The amount of the difference between the fitness values is not taken into account.\n\nfitness: (Vector{<:Real}) Vector of fitness values. The lower the fitness,  the more likely the corresponding chromosome is selected.\nselection_number: (Integer) Indicates how many indices are returned.\nrng: Instance of a random number generator to produce reproducible results.\n\nReturns indices of selected populants.\n\n\n\n\n\n","category":"function"},{"location":"reference/#Julia4ML_GA.roulette_wheel-Tuple{Vector{var\"#s16\"} where var\"#s16\"<:Real, Int64, Any}","page":"API Reference","title":"Julia4ML_GA.roulette_wheel","text":"roulette_wheel(fitness, selection_number, rng)\n\nImplements a simple roulette_wheel. If the sum over positive fitness scores is larger than the sum  over negative scores, higher fitness scores are more likely to be selected, otherwise negative values are more likely to be selected. Should only be used if either all fitness values are negative or all fitness values are  positive\n\nfitness: (Vector{<:Real}) Vector of fitness values. The higher the absolute fitness,  the more likely the corresponding chromosome is selected.\nselection_number: (Integer) Indicates how many indices are returned.\nrng: Instance of a random number generator to produce reproducible results.\n\nReturns indices of selected populants.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.trace-Tuple{Julia4ML_GA.OptimizationResult}","page":"API Reference","title":"Julia4ML_GA.trace","text":"trace(res)\n\nres: (OptimizationResult)\n\nReturns trace of evolutionary algorithm\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.univariate_displacement-Tuple{Vector{var\"#s17\"} where var\"#s17\"<:Real, Any}","page":"API Reference","title":"Julia4ML_GA.univariate_displacement","text":"univariate_displacement(gene, rng)\n\nAdds univeriate noise to the gene with mathcalU(-11).\n\nrng: Instance of a random number generator to produce reproducible results.\ngene: (Vector{Float64}) Vector containing all genes of a chromosome.\n\nReturns resulting gene.\n\n!!! Only applicable for numerical problems (rosenbrock) !!!\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.update_state!-NTuple{4, Any}","page":"API Reference","title":"Julia4ML_GA.update_state!","text":"update_state!(ga, state, objective, rng)\n\nUpdates GeneticAlgorithmState according to provided GeneticAlgorithm instance. Selection, crossover, mutation and evaluation is executed. Equivalent to one iteration of the optimizatrion process.\n\nga: (GeneticAlgorithm) GeneticAlgorithm instance to work on.\nstate: (GeneticAlgorithmState) GeneticAlgorithmState to proceed from.\nobjective: (Function) Fitness function to be used.\nrng: Instance of a random number generator to produce reproducible results.\n\n\n\n\n\n","category":"method"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = Julia4ML_GA","category":"page"},{"location":"#Julia4ML_GA","page":"Home","title":"Julia4ML_GA","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Julia4ML_GA is a package for genetic algorithms.","category":"page"},{"location":"#What-is-a-genetic-algorithm","page":"Home","title":"What is a genetic algorithm","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Genetic algorithms solve optimization problems by","category":"page"},{"location":"","page":"Home","title":"Home","text":"creating a population of candidate solutions, each with their own genomes\nevaluating them with a fitness function and iteratively selecting only the best candidates\nmaintaining the population size by creating new populants via crossover between successful populants\nmutating populants in random places of their genome","category":"page"},{"location":"","page":"Home","title":"Home","text":"(Image: Genetic Algorithm Loop)","category":"page"},{"location":"#Basic-example","page":"Home","title":"Basic example","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using Julia4ML_GA\n\n# starting point initialized with zeros\nstarting_point = Float64[0.,0.]\n\n# rosenbrock function as fitness function\nfitness_function = x->(1-x[1])^2 +100*(x[2]-x[1]^2)^2\n\n# setting populaition size manually (default is 50)\nga_instance = Julia4ML_GA.GeneticAlgorithm(populationSize=100)\n\n# 100 iterations containing crossover, mutation, evaluation, selection to be performed\niterations=100\n\n# Execute optimisation process\nfittest = Julia4ML_GA.optimize(starting_point,fitness_function,ga_instance;iterations)\n\nprintln(fittest)","category":"page"}]
}
