using SearchSortedNearest
using Test

@testset "SearchSortedNearest.jl" begin
    @testset "Range" begin
        for rng in [1:10, (1:10) .+ 0.4, (1:10) .+ 0.5, 1.0:10.0], item in rng 
            @test searchsortednearest(rng, item) == floor(Int, item)
        end
        @test searchsortednearest(1:10, 0) == 1
        @test searchsortednearest(1:10, 11) == 10
        @test searchsortednearest(1:10, 0, rev=true) == 10
        @test searchsortednearest(1:10, 11, rev=true) == 1
    end
    @testset "By" begin 
        struct StructWithoutOrder end
        rng = map(x -> x => StructWithoutOrder(), 1:10)
        for item in rng 
            @test searchsortednearest(rng, item, by=first) == first(item)
            @test searchsortednearest(rng, item, by=first, rev=true) == 11 - first(item)
        end
    end
    for _ in 1:100
        a = sort!(randn(100))
        x = randn()
        @test searchsortednearest(a, x) == argmin(abs.(a .- x))
        @test searchsortednearest(a, x, rev=true) == argmin(abs.(reverse(a) .- x))
    end
end
