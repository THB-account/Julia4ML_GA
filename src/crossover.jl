function single_point_crossover(p1::ContinuousPopulant,p2::ContinuousPopulant)
    i = rand(1:length(p1.genes))
    return ContinuousPopulant(vcat(p1.genes[begin:i],p2.genes[i:end])),ContinuousPopulant(vcat(p2.genes[begin:i],p1.genes[i:end]))
end