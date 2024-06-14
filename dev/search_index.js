var documenterSearchIndex = {"docs":
[{"location":"reference/#Julia4ML_GA-API","page":"API Reference","title":"Julia4ML_GA API","text":"","category":"section"},{"location":"reference/","page":"API Reference","title":"API Reference","text":"","category":"page"},{"location":"reference/","page":"API Reference","title":"API Reference","text":"Modules = [Julia4ML_GA]","category":"page"},{"location":"reference/#Julia4ML_GA.GeneticAlgorithm","page":"API Reference","title":"Julia4ML_GA.GeneticAlgorithm","text":"Contains information and functions to execute an optimization process for a genetic algorithm.\n\npopulation_size: (Integer) Number of populants to be maintained.\neliteSize: (Integer) Number of populants selected as elite.\ncrossoverRate: (Float) Probability of crossover for two populants.\nmutationRate: (Float) Probability of mutation.\nselection: (Function) Function to select populants for next iteration.\nmuation: (Function) Mutation function.\ncrossover: (Function) Crossover function.\n\nConstructor:\n\nGeneticAlgorithm(;\n    populationSize=50,\n    eliteSize=5,\n    crossoverRate=0.8,\n    mutationRate=0.1,\n    selection=roulette_wheel,\n    mutation=displacement,\n    crossover=single_point\n)\n\n\n\n\n\n","category":"type"},{"location":"reference/#Julia4ML_GA.GeneticAlgorithmState","page":"API Reference","title":"Julia4ML_GA.GeneticAlgorithmState","text":"State of a genetic algorithm.\n\npopulation: (Vector) Current population. Vector conatining elements of same type as starting point for optimization process.\npopulationFitness: (Function) Fitness function by which the population's fitness is to be evaluated.\n\nConstructor:\n\nGeneticAlgorithmState(population,objective)\n\n\n\n\n\n","category":"type"},{"location":"reference/#Julia4ML_GA.crossover!-NTuple{5, Any}","page":"API Reference","title":"Julia4ML_GA.crossover!","text":"crossover!(parents,children,selected_individuals,ga,rng)\n\nControl function for crossover.\n\nparents: (Vector) (Sub-)Population to be used to create offspring.\nchildren (Vector) Object to hold the newly created offspring.\nselected_individuals: (Vector{Integer}) The for crossover selected populant's indices.\nga: (GeneticAlgorithm) GeneticAlgorithm instance the population is part of.\nrng:  Instance of a random number generator to produce reproducible results.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.displacement-Tuple{Any, Any}","page":"API Reference","title":"Julia4ML_GA.displacement","text":"displacement(gene,rng)\n\nImplements the single point crossover method.\n\nrng: Instance of a random number generator to produce reproducible results.\ngene: (Vector) Vector containing all genes of a chromosome.\n\nReturns resulting gene.\n\nThe genes are displaced inside itself. The returned element has the same values as before, but with scrambled genes.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.evaluation!-Tuple{Any, Any, Any}","page":"API Reference","title":"Julia4ML_GA.evaluation!","text":"evaluation!(ga,state,objective)\n\nControl function for fitness evaluation.\n\nga: (GeneticAlgorithm) GeneticAlgorithm instance to work on.\nstate:  (GeneticAlgorithmState) GeneticAlgorithmState instance to proceed from.\nobjective: (Function) Fitness function by which the population is evaluated.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.gaussian_displacement-Tuple{Any, Any}","page":"API Reference","title":"Julia4ML_GA.gaussian_displacement","text":"gaussian_displacement(gene,rng)\n\nAdds gaussian noise to the gene with mathcalN(01).\n\nrng: Instance of a random number generator to produce reproducible results.\ngene: (Vector{Float64}) Vector containing all genes of a chromosome.\n\nReturns resulting gene.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.initialise_genetic_state-NTuple{4, Any}","page":"API Reference","title":"Julia4ML_GA.initialise_genetic_state","text":"initialise_genetic_state(starting_point,objective,ga,rng)\n\nInitialises populant's genes.\n\nstarting_point: (Vector{Float64})\nobjective: (Function) Fitness function to be used.\nga: (GeneticAlgorithm) GeneticAlgorithm instance to work on.\nrng: Instance of a random number generator to produce reproducible results.\n\nReturns GeneticAlgorithmState.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.mutation!-Tuple{Any, Any, Any}","page":"API Reference","title":"Julia4ML_GA.mutation!","text":"mutation!(offspring,ga,rng)\n\ncontrol function for mutation.\n\npopulation: (Vector) (Sub-)Population to be mutated.\nga: (GeneticAlgorithm) GeneticAlgorithm instance the population is part of.\nrng: Instance of a random number generator to produce reproducible results.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.optimize-Tuple{Any, Any, Julia4ML_GA.GeneticAlgorithm}","page":"API Reference","title":"Julia4ML_GA.optimize","text":"optimize(starting_point,objective,ga::GeneticAlgorithm;iterations=100,rng=default_rng())\n\nExecutes optimization process\n\nstarting_point: (Vector) Initial candidate.\nobjective: (Function) Fitness function to evaluate population. \niterations: (Integer) Maximum number of iterations.\nrng: Instance of a random number generator to produce reproducible results. Default is Random.default_rng().\n\nReturns final population's fittest populant.\n\nPopulation is initialized and build.  Then the optimization is executed using the provided fitness function.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.single_point-Tuple{Any, Any, Any}","page":"API Reference","title":"Julia4ML_GA.single_point","text":"single_point(genes1, genes2,rng)\n\nImplements the single point crossover method.\n\nrng: An instance of a random number generator to produce reproducible results.\ngenes1, genes2, child1 and child2: Vectors containing all genes of a chromosome. \n\nReturns child1 and child2.\n\ngenes1 and genes2 are used to create child1 and child2, which are returned.  child1 is a copy of genes1 up to randomly generated crossover point.  After that it is a copy of genes2. The same for child2 respectively with parent roles swapped.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.univariate_displacement-Tuple{Any, Any}","page":"API Reference","title":"Julia4ML_GA.univariate_displacement","text":"univariate_displacement(gene,rng)\n\nAdds univeriate noise to the gene with mathcalU(-11).\n\nrng: Instance of a random number generator to produce reproducible results.\ngene: (Vector{Float64}) Vector containing all genes of a chromosome.\n\nReturns resulting gene.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Julia4ML_GA.update_state!-NTuple{4, Any}","page":"API Reference","title":"Julia4ML_GA.update_state!","text":"update_state!(ga, state, objective, rng)\n\nUpdates GeneticAlgorithmState according to provided GeneticAlgorithm instance. Selection, crossover, mutation and evaluation is executed. Equivalent to one iteration of the optimizatrion process.\n\nga: (GeneticAlgorithm) GeneticAlgorithm instance to work on.\nstate: (GeneticAlgorithmState) GeneticAlgorithmState to proceed from.\nobjective: (Function) Fitness function to be used.\nrng: Instance of a random number generator to produce reproducible results.\n\n\n\n\n\n","category":"method"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = Julia4ML_GA","category":"page"},{"location":"#Julia4ML_GA","page":"Home","title":"Julia4ML_GA","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Julia4ML_GA is a package for genetic algorithms.","category":"page"},{"location":"#What-is-a-genetic-algorithm","page":"Home","title":"What is a genetic algorithm","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Genetic algorithms solve optimization problems by","category":"page"},{"location":"","page":"Home","title":"Home","text":"creating a population of candidate solutions, each with their own genomes\nevaluating them with a fitness function and iteratively selecting only the best candidates\nmaintaining the population size by creating new populants via crossover between successful populants\nmutating populants in random places of their genome","category":"page"},{"location":"","page":"Home","title":"Home","text":"(Image: Genetic Algorithm Loop)","category":"page"},{"location":"#Basic-example","page":"Home","title":"Basic example","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using Julia4ML_GA\n\n# starting point initialized with zeros\nstarting_point = Float64[0.,0.]\n\n# rosenbrock function as fitness function\nfitness_function = x->(1-x[1])^2 +100*(x[2]-x[1]^2)^2\n\n# setting populaition size manually (default is 50)\nga_instance = Julia4ML_GA.GeneticAlgorithm(populationSize=100)\n\n# 100 iterations containing crossover, mutation, evaluation, selection to be performed\niterations=100\n\n# Execute optimisation process\nfittest = Julia4ML_GA.optimize(starting_point,fitness_function,ga_instance;iterations)\n\nprintln(fittest)","category":"page"}]
}
