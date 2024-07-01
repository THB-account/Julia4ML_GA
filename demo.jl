### A Pluto.jl notebook ###
# v0.19.42

using Markdown
using InteractiveUtils

# ╔═╡ 755b8685-0711-48a2-a3eb-f80af39f10e1
begin
    using Pkg;
	Pkg.add(url="https://github.com/THB-account/Julia4ML_GA")
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
best_solution = Julia4ML_GA.solve_rosenbrock(4, 100) # a = 4, b = 100, expected solution: [4.,16.]


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

	starting_point = Float64[0.,0.]
	populationSize = 1000
    initPop = init_gaussian(starting_point, populationSize, rng)

	
    result = Julia4ML_GA.optimize(
            initPop,
            rbf,
            Julia4ML_GA.GeneticAlgorithm(
                populationSize=populationSize,
            selection=roulette_wheel_inv,
            mutation=gaussian_displacement,
            crossover=k_point
            );
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

# ╔═╡ bfd8b850-ce76-4779-b2eb-3c61f7c57ee9


# ╔═╡ 5983b9a9-d669-4ae6-85b2-76298f55d4c3
begin	
	scatter(x,y;markercolor=:blue, markersize = 1,label="Populants")
	scatter!(xm,ym;markersize=2,markercolor=:red,label="Best individuals")
	contour!(X,Y,Z;color=:turbo,levels=20,label="Cost function")
	scatter!([1],[1],label="Function minimum")
end

# ╔═╡ cb395709-4237-488d-a294-7cb6e294c724
md"### Exercise 1.2 – Broadcasting"

# ╔═╡ 2ee7ce83-a828-4468-9daf-7cdbf657e52e


# ╔═╡ c84be3a2-73a9-42f1-bf6b-3fbf64258cf5


# ╔═╡ a11ccc2b-3c5b-493a-8e8b-8b46b44bd3a4


# ╔═╡ 6a1c553d-66ef-42da-83ad-5b46a7e4c58b


# ╔═╡ 6eaffea6-099d-441e-b54b-f08bc9b478c7


# ╔═╡ a87612a8-62dd-44d4-89c4-c712870b00c3


# ╔═╡ da70e426-ea78-4969-9402-efffd5576238


# ╔═╡ 35f59a25-0ab4-4c18-82c8-466fdeeb3471
# my_square_roots


# ╔═╡ 56fc8e66-852d-4653-ad4c-2f5ecd0be769


# ╔═╡ 23174858-aa5f-42bf-ac1c-56ee88d87f7f


# ╔═╡ 7d098a0b-1a11-4225-b044-82d29f05ad05


# ╔═╡ f190cbbb-24e7-4c83-b7fb-9477ccdb5023


# ╔═╡ a4b05061-e48e-4dbb-aa1c-df242c5b2785


# ╔═╡ 077a73ca-b401-40ef-abae-ea87f78436a3


# ╔═╡ 5c6660ae-8b04-49ef-b4a7-df47b9e71f67
md"## Exercise 2: Functions
### Exercise 2.1 – Control flow"

# ╔═╡ dabfa315-fa26-4056-8b19-eaab8322db82


# ╔═╡ 49e6ab33-9452-4dc1-ac59-d47e70c325a5


# ╔═╡ ffbd5d8c-86f9-4c5d-9d9c-1d1a0083a439


# ╔═╡ 12fe4d4b-3f2f-4d26-b4f7-b8e83605c7e8


# ╔═╡ 6edb4abb-02ae-4d18-8cdb-6a47586584a2


# ╔═╡ 712c7e22-f144-4da0-9a6a-37d5a9006336


# ╔═╡ 60b79139-13d1-4945-9c50-66b0304e7e75


# ╔═╡ 3039f9f1-9077-4050-b0d6-c404612d2e38


# ╔═╡ f54461c4-392c-4a83-933c-d30a41ce4e0e


# ╔═╡ bcb0ff95-f769-46f3-abf3-d5807107413b


# ╔═╡ de7f59f0-17b5-41a0-be32-cbaad14d777e


# ╔═╡ 6d988869-35f6-4771-9002-b8b32560e1cc


# ╔═╡ d0377938-ca4b-4186-b708-b31a23e23807


# ╔═╡ 2b4dac4c-e710-407d-aa78-4ed181748cf8


# ╔═╡ af9b11ed-bb17-4ff3-a8f8-057f4777e5f9


# ╔═╡ b74c95c2-db7a-4a72-b7c6-3e6644d90158


# ╔═╡ 20283e2f-9c00-43d2-bafd-1044ef520248


# ╔═╡ 2011a382-c148-4b7b-a78d-d2813c0d4fcf


# ╔═╡ b5711f19-cd31-46b1-92c1-f51480c9065a


# ╔═╡ 16fdaf27-8345-436d-911c-ef09e9bb48e8


# ╔═╡ 2f483635-5080-48c6-b961-9dbc916268a4


# ╔═╡ 04185b35-7d17-47a1-91b7-39c2aa6d5316


# ╔═╡ adcb02c4-50b9-415a-b06b-e775d4a88c28
md"### Exercise 3.1 – Mean"

# ╔═╡ 2c6a5d50-8861-47b6-adaf-8641d73e47cd


# ╔═╡ bae3ffd7-2d9a-4450-9f5e-6b7c296529d5
function my_mean(xs)
    # Write your code here!
	my_sum = 0
	for number in xs
		my_sum = my_sum + number
	end
    return my_sum/length(xs)
end

# ╔═╡ 31ac70a3-2dcc-497f-a996-81e087615b0f


# ╔═╡ 183c4510-35d5-472e-9dc3-8ee3eb5e5760


# ╔═╡ 71e86db6-0f51-4cca-b37e-aac59d8a5fff
md"### Exercise 3.2 – Standard deviation"

# ╔═╡ 54ccc15f-2232-403f-b6cc-503bd832eed7


# ╔═╡ 2af1806e-c9af-4616-a654-9b0d52a08c65
function my_std(xs)
    v = 0
	m = my_mean(xs)
	for number in xs
		v = v + (number - m)^2
	end
    return sqrt(v/(length(xs)-1))
end

# ╔═╡ 2894e2f9-8e41-4e29-a293-dbd4982284c4


# ╔═╡ 041fe618-588e-4fb6-b1d5-455a7d8bdf6f


# ╔═╡ d05e0303-583a-45ed-af8c-2e517b5c995b


# ╔═╡ 602e2bb4-6a35-4050-9e6d-ba7bd26ecf39
md"""### Exercise 3.3 – Standardization
Standardization takes data $X$ and returns transformed data $X'$ with mean $\mu'=0$ and standard deviation $\sigma'=1$:

$X' = \frac{X-\mu}{\sigma}$
"""

# ╔═╡ 0192e66f-48fe-4e27-962c-5d6be35e45ce


# ╔═╡ 5d080901-92f2-45d5-8603-3fc8e90137e0
function standardize(xs)
    # Write your code here!
	m = my_mean(xs)
	s = my_std(xs) 
    return [(x-m)/s for x in xs]
end

# ╔═╡ ac830b8f-9ca5-4a86-981f-e9953700a6b0
md"Let's check whether the transformed data has $\mu'=0$ and $\sigma'=1$.

Note that due to [rounding errors](https://en.wikipedia.org/wiki/Machine_epsilon) arising from floating point arithmetic, the results will not be exactly zero and one:
"

# ╔═╡ 089cfc54-7010-4c3b-822b-55eacd849bf9


# ╔═╡ 6f482227-2961-44fd-9f34-7373f099e1a5


# ╔═╡ 77938197-8164-402a-b688-939312c7078e


# ╔═╡ 35c913da-6883-4c83-9f6a-d12cd85bb89e


# ╔═╡ 372cae6d-ef09-46a3-af90-03f83be6c08a
md"### Exercise 3.4 – Inverse transform
There are two more things we can improve in our `standardize` function:

1. When applying standardization, the transformation $\frac{X-\mu}{\sigma}$ depends on the mean and standard deviation of the data $X$. Applying the function `standardize` to two different datasets will therefore apply two different transformations.

    This is a problem if we want to re-apply the exact same transformation computed on our training set to our testing set.

2. Additionally, we want to have an inverse of our transformation to apply to the inference results of our machine learning model. This inverse transform should implement

$X = \left(X' \cdot \sigma\right) + \mu$

Since we haven't learned how to define our own types yet (look forward to lecture 4!), we will use higher-order functions to solve this problem.
"

# ╔═╡ 0fff4cd1-8972-4aaf-85d5-6515404b8b86


# ╔═╡ cce72fb1-b694-4b84-9cc6-e209acd398db
function get_transformations(data)
    # Write code here!
	m = my_mean(data)
	s = my_std(data) 
    function transform(xs)
        # Write code here!
        return [(x-m)/s for x in xs]
    end

    function inverse_transform(xs)
        # Write code here!
        return [(x*s)+m for x in xs]
    end

    return transform, inverse_transform # don't change this line
end

# ╔═╡ d3ff15bd-db35-403b-b30e-714ba4944221


# ╔═╡ bdb67c9d-baae-4c58-bf30-ad8490ee8549


# ╔═╡ 9d383e80-f264-4fc4-8287-66a60d03461b
md"Let's apply the function `tf` that our function returned. Once again, we will check whether the transformed data has $\mu'=0$ and $\sigma'=1$:"

# ╔═╡ 863913f2-167f-4c39-8694-83c4947a36bd


# ╔═╡ df0389aa-76b8-455f-ab0b-fd58ba6656f6


# ╔═╡ db31f84e-2e10-46a0-857e-0fb9d045b9b8


# ╔═╡ c0a59c0f-887e-43b6-86cc-91b4a9a00f0b
md"And let's test the inverse transformation. The following vectors should be equal:"

# ╔═╡ 5ce2da1a-c116-48e6-9ae2-a2c6f95c1ada


# ╔═╡ 6d335fa1-5349-4eac-973b-0e570149fe7c


# ╔═╡ e21865d8-294f-47c0-b68d-7767318c6f9f


# ╔═╡ edb7814a-eddf-4c87-8857-19bb0a0c0241
md"""# Feedback
This is the second iteration of the *"Julia programming for ML"* class. Please help us make the course better!

You can write whatever you want in the following string. Feel free to add or delete whatever you want.
"""

# ╔═╡ f60be2e0-9b43-46b5-96ef-7747ab56e164
feedback = """
The homework + first lecture took me around 70 minutes.

I liked:
* All details on basic Julia programming.

""";

# ╔═╡ Cell order:
# ╟─ff5d316f-806c-4652-97d8-323462395c69
# ╟─f7347c06-c1b7-11ed-3b8e-fbf167ce9cba
# ╟─bdcb27c5-0603-49ac-b831-d78c558b31f0
# ╟─6be73c03-925c-4afa-bd66-aca90e6b49fe
# ╟─ddd6e83e-5a0d-4ff0-afe4-dedfc860994c
# ╟─8ece9aea-20f5-41db-95ca-08c8d4d2d4c1
# ╟─d03e4e95-faab-4ab3-ab27-81189cbd8231
# ╟─44ec9e94-f6af-431e-8841-bae44431dfa3
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
# ╠═bfd8b850-ce76-4779-b2eb-3c61f7c57ee9
# ╠═5983b9a9-d669-4ae6-85b2-76298f55d4c3
# ╟─cb395709-4237-488d-a294-7cb6e294c724
# ╟─2ee7ce83-a828-4468-9daf-7cdbf657e52e
# ╠═c84be3a2-73a9-42f1-bf6b-3fbf64258cf5
# ╠═a11ccc2b-3c5b-493a-8e8b-8b46b44bd3a4
# ╟─6a1c553d-66ef-42da-83ad-5b46a7e4c58b
# ╠═6eaffea6-099d-441e-b54b-f08bc9b478c7
# ╠═a87612a8-62dd-44d4-89c4-c712870b00c3
# ╠═da70e426-ea78-4969-9402-efffd5576238
# ╟─35f59a25-0ab4-4c18-82c8-466fdeeb3471
# ╟─56fc8e66-852d-4653-ad4c-2f5ecd0be769
# ╟─23174858-aa5f-42bf-ac1c-56ee88d87f7f
# ╠═7d098a0b-1a11-4225-b044-82d29f05ad05
# ╠═f190cbbb-24e7-4c83-b7fb-9477ccdb5023
# ╟─a4b05061-e48e-4dbb-aa1c-df242c5b2785
# ╟─077a73ca-b401-40ef-abae-ea87f78436a3
# ╟─5c6660ae-8b04-49ef-b4a7-df47b9e71f67
# ╟─dabfa315-fa26-4056-8b19-eaab8322db82
# ╠═49e6ab33-9452-4dc1-ac59-d47e70c325a5
# ╟─ffbd5d8c-86f9-4c5d-9d9c-1d1a0083a439
# ╠═12fe4d4b-3f2f-4d26-b4f7-b8e83605c7e8
# ╠═6edb4abb-02ae-4d18-8cdb-6a47586584a2
# ╟─712c7e22-f144-4da0-9a6a-37d5a9006336
# ╟─60b79139-13d1-4945-9c50-66b0304e7e75
# ╟─3039f9f1-9077-4050-b0d6-c404612d2e38
# ╠═f54461c4-392c-4a83-933c-d30a41ce4e0e
# ╟─bcb0ff95-f769-46f3-abf3-d5807107413b
# ╠═de7f59f0-17b5-41a0-be32-cbaad14d777e
# ╟─6d988869-35f6-4771-9002-b8b32560e1cc
# ╟─d0377938-ca4b-4186-b708-b31a23e23807
# ╟─2b4dac4c-e710-407d-aa78-4ed181748cf8
# ╠═af9b11ed-bb17-4ff3-a8f8-057f4777e5f9
# ╟─b74c95c2-db7a-4a72-b7c6-3e6644d90158
# ╠═20283e2f-9c00-43d2-bafd-1044ef520248
# ╠═2011a382-c148-4b7b-a78d-d2813c0d4fcf
# ╟─b5711f19-cd31-46b1-92c1-f51480c9065a
# ╟─16fdaf27-8345-436d-911c-ef09e9bb48e8
# ╟─2f483635-5080-48c6-b961-9dbc916268a4
# ╟─04185b35-7d17-47a1-91b7-39c2aa6d5316
# ╟─adcb02c4-50b9-415a-b06b-e775d4a88c28
# ╟─2c6a5d50-8861-47b6-adaf-8641d73e47cd
# ╠═bae3ffd7-2d9a-4450-9f5e-6b7c296529d5
# ╟─31ac70a3-2dcc-497f-a996-81e087615b0f
# ╟─183c4510-35d5-472e-9dc3-8ee3eb5e5760
# ╟─71e86db6-0f51-4cca-b37e-aac59d8a5fff
# ╟─54ccc15f-2232-403f-b6cc-503bd832eed7
# ╠═2af1806e-c9af-4616-a654-9b0d52a08c65
# ╠═2894e2f9-8e41-4e29-a293-dbd4982284c4
# ╟─041fe618-588e-4fb6-b1d5-455a7d8bdf6f
# ╟─d05e0303-583a-45ed-af8c-2e517b5c995b
# ╟─602e2bb4-6a35-4050-9e6d-ba7bd26ecf39
# ╟─0192e66f-48fe-4e27-962c-5d6be35e45ce
# ╠═5d080901-92f2-45d5-8603-3fc8e90137e0
# ╟─ac830b8f-9ca5-4a86-981f-e9953700a6b0
# ╠═089cfc54-7010-4c3b-822b-55eacd849bf9
# ╠═6f482227-2961-44fd-9f34-7373f099e1a5
# ╠═77938197-8164-402a-b688-939312c7078e
# ╟─35c913da-6883-4c83-9f6a-d12cd85bb89e
# ╟─372cae6d-ef09-46a3-af90-03f83be6c08a
# ╟─0fff4cd1-8972-4aaf-85d5-6515404b8b86
# ╠═cce72fb1-b694-4b84-9cc6-e209acd398db
# ╠═d3ff15bd-db35-403b-b30e-714ba4944221
# ╠═bdb67c9d-baae-4c58-bf30-ad8490ee8549
# ╟─9d383e80-f264-4fc4-8287-66a60d03461b
# ╠═863913f2-167f-4c39-8694-83c4947a36bd
# ╠═df0389aa-76b8-455f-ab0b-fd58ba6656f6
# ╠═db31f84e-2e10-46a0-857e-0fb9d045b9b8
# ╟─c0a59c0f-887e-43b6-86cc-91b4a9a00f0b
# ╠═5ce2da1a-c116-48e6-9ae2-a2c6f95c1ada
# ╠═6d335fa1-5349-4eac-973b-0e570149fe7c
# ╟─e21865d8-294f-47c0-b68d-7767318c6f9f
# ╟─edb7814a-eddf-4c87-8857-19bb0a0c0241
# ╠═f60be2e0-9b43-46b5-96ef-7747ab56e164
