using SearchSortedNearest
using Test

@testset "SearchSortedNearest.jl" begin
    @testset "Range" begin
        for rng in [1:10, (1:10) .+ 0.4, (1:10) .+ 0.5, 1.0:10.0], item in rng 
            searchsortednearest(rng, item) == round(Int, item)
        end
        searchsortednearest(1:10, 0) == 1
        searchsortednearest(1:10, 11) == 10
        searchsortednearest(1:10, 0, rev=true) == 10
        searchsortednearest(1:10, 11, rev=true) == 1
    end
    @testset "By" begin 
        rng = map(x -> x => rand(), 1:10)
        for item in rng 
            searchsortednearest(rng, item, by=first) == first(item)
            searchsortednearest(rng, item, by=first, rev=true) == 11 - first(item)
        end
    end
end
