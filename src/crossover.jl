"""
    single_point_crossover(p1, p2)

A single crossover point is selected. Both populant's (`p1` and `p1`) genes will be swapped after that point.
"""
function single_point_crossover(p1::ContinuousPopulant,p2::ContinuousPopulant)
    i = rand(1:length(p1.genes))
    return ContinuousPopulant(vcat(p1.genes[begin:i],p2.genes[i:end])),ContinuousPopulant(vcat(p2.genes[begin:i],p1.genes[i:end]))
end

