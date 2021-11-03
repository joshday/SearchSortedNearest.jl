using SearchSortedNearest
using Test

@testset "SearchSortedNearest.jl" begin
    @testset "Range checks" begin
        for rng in [1:10, (1:10) .+ 0.4, (1:10) .+ 0.5, 1.0:10.0], item in rng 
            @test searchsortednearest(rng, item) == floor(Int, item)
        end
        @test searchsortednearest(1:10, 0) == 1
        @test searchsortednearest(1:10, 11) == 10
        @test searchsortednearest(10:-1:1, 0, rev=true) == 10
        @test searchsortednearest(10:-1:1, 11, rev=true) == 1
    end
    @testset "by" begin 
        struct StructWithoutOrder end
        rng = map(x -> x => StructWithoutOrder(), 1:10)
        for item in rng 
            @test searchsortednearest(rng, item, by=first) == first(item)
            @test searchsortednearest(reverse(rng), item, by=first, rev=true) == 11 - first(item)
        end
        a = ["a", "aa", "aaa", "aaaa"]
        x = "aaa"
        @test searchsortedfirst(a, x, by=length) == 3
    end
    @testset "lt" begin 
        a = 1:10.0
        x = NaN
        VERSION > v"1.5.4" && @test searchsortednearest(a, x, lt=isless) == 10
        @test searchsortednearest(a, x, lt=<) == 1
    end
    @testset "random" begin
        for _ in 1:100
            a, x = sort!(randn(100)), randn()
            @test searchsortednearest(a, x) == argmin(abs.(a .- x))
            @test searchsortednearest(reverse(a), x, rev=true) == argmin(abs.(reverse(a) .- x))
        end
    end
end
