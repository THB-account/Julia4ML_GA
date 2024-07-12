```@meta
CurrentModule = Julia4ML_GA
```
# Examples

## Rosenbrock

```@docs
solve_rosenbrock
```

### Rosenbrock Example
```julia-repl
julia> import Julia4ML_GA
julia> best_solution = Julia4ML_GA.solve_rosenbrock(4, 100)
2-element Vector{Float64}:
  4.005027433832623
 16.039474997126856
```

## Knapsack

```@docs
solve_knapsack
```

### Knapsack Example
```julia-repl
julia> import Julia4ML_GA
julia> mass    = [1, 5, 3, 7, 2, 10, 5, 9, 2]
julia> utility = [1, 3, 5, 2, 5,  8, 3, 9, 5]
julia> maxMass = 30
julia> best_solution = Julia4ML_GA.solve_knapsack(mass, utility, maxMass)
julia> print(best_solution)
Bool[1, 0, 1, 0, 1, 1, 0, 1, 1]
julia> sum(best_solution .* utility)
33
julia> sum(best_solution .* mass)
27
```

## Traveling Salesman Problem

```@docs
solve_tsp
```

### Traveling Salesman Problem Example
```julia-repl
julia> import Julia4ML_GA
julia> cost = [
             0 8 10 7 2;
             8 0 4 5 10;
             10 4 0 3 6;
             7 5 3 0 4;
             2 10 6 4 0
            ]
julia> best_solution, best_solution_cost = Julia4ML_GA.solve_tsp(cost)
([1, 5, 4, 3, 2], 21)
```

## Sudoku

```@docs
solve_sudoku
```

### Sudoku Example
```julia-repl
julia> import Julia4ML_GA
julia> sudoku = [
            0 1 0 0 7 5 9 4 0;
            4 0 2 0 0 6 0 0 7;
            0 3 0 9 0 1 0 0 8;
            6 0 0 5 2 0 4 9 0;
            0 5 8 0 0 3 0 2 6;
            1 0 4 0 0 7 0 3 0;
            0 0 9 8 0 0 0 0 2;
            7 0 0 1 6 0 3 0 0;
            2 0 0 0 3 0 6 5 4
            ]
julia> best_solution, errors = Julia4ML_GA.solve_sudoku(sudoku)
julia> print("Number of errors in sudoku: ", errors)
Number of errors in sudoku: 0
julia> display(best_solution)
9×9 Matrix{Int8}:
 8  1  6  2  7  5  9  4  3
 4  9  2  3  8  6  5  1  7
 5  3  7  9  4  1  2  6  8
 6  7  3  5  2  8  4  9  1
 9  5  8  4  1  3  7  2  6
 1  2  4  6  9  7  8  3  5
 3  6  9  8  5  4  1  7  2
 7  4  5  1  6  2  3  8  9
 2  8  1  7  3  9  6  5  4
```
