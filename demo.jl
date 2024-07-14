### A Pluto.jl notebook ###
# v0.19.42

using Markdown
using InteractiveUtils

# ╔═╡ 755b8685-0711-48a2-a3eb-f80af39f10e1
begin
    using Pkg;
	
	# install our package
	Pkg.add(url="https://github.com/THB-account/Julia4ML_GA")
	
	# install packages used in this notebook
	Pkg.add("Plots")
	Pkg.add("Random")
	using Julia4ML_GA
end

# ╔═╡ faa24988-4ed2-44da-80a1-81a85573f309
begin 
	using Random:default_rng
	using Plots
end

# ╔═╡ ff5d316f-806c-4652-97d8-323462395c69


# ╔═╡ f7347c06-c1b7-11ed-3b8e-fbf167ce9cba
html"""
	<h1 style="text-align:left">
		Julia programming for ML
	</h1>
	<div style="text-align:left">
		<p style="font-weight:bold; font-size: 35px; font-variant: small-caps; margin: 0px">
			Project: Genetic Algorithms
		</p>
		<p style="font-size: 20px;">
			TU Berlin, Summer Semester 2024<br>
		</p>
	</div>
"""

# ╔═╡ bdcb27c5-0603-49ac-b831-d78c558b31f0
md"Date: **June 27th 2024**"

# ╔═╡ 6be73c03-925c-4afa-bd66-aca90e6b49fe


# ╔═╡ ddd6e83e-5a0d-4ff0-afe4-dedfc860994c
md"### Content
This notebook shows our project and how you can use your own ideas to interact with our code.
"

# ╔═╡ 8ece9aea-20f5-41db-95ca-08c8d4d2d4c1
md"#### Examples
In this section we present example problems we solved with genetic algorithms. 
You can change the input values to see the results for other values.
"

# ╔═╡ d03e4e95-faab-4ab3-ab27-81189cbd8231
md"##### Rosenbrock
One very simple example is the rosenbrock function. The global minimum (x,y) is at (a,a**2).
More information: https://en.wikipedia.org/wiki/Rosenbrock_function.
"


# ╔═╡ 44ec9e94-f6af-431e-8841-bae44431dfa3
best_solution = Julia4ML_GA.solve_rosenbrock(4, 100;obj_bound=0.001, iterations=1000) # a = 4, b = 100, expected solution: [4.,16.]


# ╔═╡ 06c0ad65-22d4-4c8e-ae19-4f05ba125e79
md"### Initializing packages
**Note:** Running this notebook for the first time can take several minutes.
"

# ╔═╡ 5061a130-fc0a-4306-bdf5-6966e8de938a


# ╔═╡ 74e27f45-9897-4ddd-8516-59669b17b1ad


# ╔═╡ d358da52-ee09-4533-a2ef-c68b847e24d5
md"## Rosenbrock function
### Initialisation of problem"

# ╔═╡ 4b06ffe3-b990-4a91-b971-a8421823b4ea
md"
Change the variable 'starting_point' for different behaviour. You will be able to see how the populations \"move\" towards the minimum.
"

# ╔═╡ e5670193-6221-49c6-a880-d287f717545e
begin 
	rng = default_rng()

	rbf = x -> (1-x[1])^2 +100*(x[2]-x[1]^2)^2

	starting_point = Float64[20.,0.]
	populationSize = 1000
    initPop = init_gaussian(populationSize, starting_point, rng)

	
    result = Julia4ML_GA.optimize(
            initPop,
            rbf,
            Julia4ML_GA.GeneticAlgorithm(
                populationSize=populationSize,
            selection=roulette_wheel_inv,
            mutation=gaussian_noise,
            crossover=k_point
            );
            obj_bound=0.001, 
			iterations=100,
            rng=rng,
			trace_optimization=true
        )
end

# ╔═╡ 4958c999-7f3d-4875-b8dc-bc7dae63781b
md"### Get and evaluate trace"

# ╔═╡ 7abd97cc-48cb-4608-89d4-9607d75affd1
begin
	trace = Julia4ML_GA.trace(result)
	populations = trace.populations
	fitnessValues = trace.fitnessValues
	fittestPopulants = trace.fittestPopulants
end

# ╔═╡ 57dde6d4-b5d5-4b09-bd24-b3787dabe2b7
md"### The cost function

Below the rosenbrock function (https://en.wikipedia.org/wiki/Rosenbrock_function) is plotted for whom the optimal value is at (1,1)."

# ╔═╡ 047d6484-e61f-42d6-a8fa-023dd73d6aea
begin
	x = [populations[generation][populant][1] for generation in eachindex(populations) for populant in eachindex(populations[generation])]
	y = [populations[generation][populant][2] for generation in eachindex(populations) for populant in eachindex(populations[generation])]
	z = [fitnessValues[generation][populant] for generation in eachindex(fitnessValues) for populant in eachindex(fitnessValues[generation])]

	xm = [fittestPopulants[generation][1] for generation in eachindex(fittestPopulants)]
	ym = [fittestPopulants[generation][2] for generation in eachindex(fittestPopulants)]
	
	rbf_2d = (X,Y) -> (1 - X) .^ 2 + 100 * (Y - X .^2) .^2
	min_x = minimum(x)-0.5
	max_x = maximum(x)+0.5
	min_y = minimum(y)-0.5
	max_y = maximum(y)+0.5
	n = 1000
	X = range(min_x,max_x;length=n)
	Y = range(min_y,max_y;length=n)
	Z = rbf_2d.(X',Y);
end

# ╔═╡ 221efb5b-088e-421e-a2fd-b6829541efff
begin
	surface(X,Y,Z)
end 

# ╔═╡ 18522f4c-44bd-44b1-9b10-1a4432f550ef
md"### Plotting algorithm generations.
Below is a contour plot of the cost function depicted. In it we can see as blue dots each individiual produced trough selection, crossover and mutation across **ALL** generations. In red are the best individuals from each generation, meaning that from, for example, 50 individuals in that generation these are the the ones that minimize the cost function for that generation. In purple is the point that minimizes the cost function.
"

# ╔═╡ 5983b9a9-d669-4ae6-85b2-76298f55d4c3
begin	
	scatter(x,y;markercolor=:blue, markersize = 1,label="Populants")
	scatter!(xm,ym;markersize=2,markercolor=:red,label="Best individuals")
	contour!(X,Y,Z;color=:turbo,levels=20,label="Cost function")
	scatter!([1],[1],label="Function minimum")
end

# ╔═╡ Cell order:
# ╟─ff5d316f-806c-4652-97d8-323462395c69
# ╟─f7347c06-c1b7-11ed-3b8e-fbf167ce9cba
# ╟─bdcb27c5-0603-49ac-b831-d78c558b31f0
# ╟─6be73c03-925c-4afa-bd66-aca90e6b49fe
# ╟─ddd6e83e-5a0d-4ff0-afe4-dedfc860994c
# ╟─8ece9aea-20f5-41db-95ca-08c8d4d2d4c1
# ╠═d03e4e95-faab-4ab3-ab27-81189cbd8231
# ╠═44ec9e94-f6af-431e-8841-bae44431dfa3
# ╟─06c0ad65-22d4-4c8e-ae19-4f05ba125e79
# ╠═755b8685-0711-48a2-a3eb-f80af39f10e1
# ╟─5061a130-fc0a-4306-bdf5-6966e8de938a
# ╟─74e27f45-9897-4ddd-8516-59669b17b1ad
# ╟─d358da52-ee09-4533-a2ef-c68b847e24d5
# ╠═faa24988-4ed2-44da-80a1-81a85573f309
# ╟─4b06ffe3-b990-4a91-b971-a8421823b4ea
# ╠═e5670193-6221-49c6-a880-d287f717545e
# ╟─4958c999-7f3d-4875-b8dc-bc7dae63781b
# ╠═7abd97cc-48cb-4608-89d4-9607d75affd1
# ╟─57dde6d4-b5d5-4b09-bd24-b3787dabe2b7
# ╠═047d6484-e61f-42d6-a8fa-023dd73d6aea
# ╠═221efb5b-088e-421e-a2fd-b6829541efff
# ╟─18522f4c-44bd-44b1-9b10-1a4432f550ef
# ╠═5983b9a9-d669-4ae6-85b2-76298f55d4c3
