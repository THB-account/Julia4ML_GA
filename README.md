# Julia4ML_GA
Julia4ML_GA is a package that provides a framework for initializing [genetic algorithms](https://en.wikipedia.org/wiki/Genetic_algorithm) to solve optimization problems.


Check out our docs at [https://thb-account.github.io/Julia4ML_GA/dev/](https://thb-account.github.io/Julia4ML_GA/dev/)!


|Documentation| Build Status|
|-------------|-------------|
| <!-- [![Stable][docs-stable-img]][docs-stable-url] --> [![Build Status][docs-dev-img]][docs-dev-url]|[![codecov](https://codecov.io/gh/THB-account/Julia4ML_GA/branch/docu_update_240623/graph/badge.svg?token=M1YMJMO46Y)](https://codecov.io/gh/THB-account/Julia4ML_GA)|

## Disclaimer

This project was developed as part of a course at the TU Berlin. It will not be further developed after the end of the course.

## Demo

To use a project demo, you can open Pluto and copy the following link: https://github.com/THB-account/Julia4ML_GA/blob/Pluto/demo.jl

## Installation
For testing in Pluto notebook you can use the following command:
```
using Pkg;
Pkg.add(url="https://github.com/THB-account/Julia4ML_GA")
using Julia4ML_GA
```
or for temporary testing from Julia's REPL:
```
] activate --temp
] add https://github.com/THB-account/Julia4ML_GA.git
```

## Action Methods for Optimization
Genetic Algorithm
- Parameters

- Selection:
    - roulette_wheel
    - tournament_selection
    - rank_selection

- Crossover:
  - k_point
  - partially_mapped

- Mutation:
  - bit_inversion
  - gaussian_displacement
  - univariate_displacement
  - displacement




[docs-stable-url]: https://THB-account.github.io/Julia4ML_GA.jl/stable/
[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg

[docs-dev-url]: https://THB-account.github.io/Julia4ML_GA/dev/
[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg

[cov-url]: https://codecov.io/gh/THB-account/Julia4ML_GA
[cov-img]: https://codecov.io/gh/THB-account/Julia4ML_GA/branch/docu_update_240623/graph/badge.svg?token=M1YMJMO46Y

