struct ContinuousPopulant <:AbstractPopulant
    # collection
    genes

    # initializes Populant with given gene representation
    # should be N×d[×e×...] where N is number of genes and d can be any shape afterwards
    function ContinuousPopulant(genes)
        new(genes)
    end
    
    function ContinuousPopulant(shape::Tuple{Vararg{Integer}},dtype::Type,init_f::Function)
        new(init_f(shape,dtype))
    end
end


struct Population <: AbstractPopulation
	populants

	function Population(pop_type::Type,shape::Tuple{Vararg{Integer}},dtype::Type,init_f::Function)
		#pops = Array{pop_type,N}
		#pops = init_f.(pops)
		#pops = init_f(pop_type,dtype)
		pops = init_f(pop_type,shape,dtype)
		
		new(pops)
	end
	(p::Population,eval_f::Function) = eval_f.(p.pops)
end