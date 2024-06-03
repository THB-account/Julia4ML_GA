function init_gaussian(pop_type::ContinuousPopulant,shape::Tuple{Vararg{Integer}},loc=0.0,scale=1.0)
    init_vals = randn(shape...)
    pops = Array{pop_type}(undef,shape...)
    for i in 1:length(a)
        pops[i] = ContinuousPopulant.(selectdim(a,1,i))
    end
    return pops
end