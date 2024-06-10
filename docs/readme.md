# How to build docs locally

To build locally execute from project root:

1. (in package mode) 'activate docs'
2. 'include("docs/make.jl");'

To serve locally do:

3. using LiveServer
4. serve(;dir="docs/build", launch_browser=true)
