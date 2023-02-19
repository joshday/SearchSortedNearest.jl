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
    @testset "distance" begin 
        a = ["abc", "abd", "abe", "abz"]
        x = "abf"
        @test searchsortednearest(a, x, distance=(a,b) -> sum(map(-, a, b))) == 3
    end
    @testset "random" begin
        for _ in 1:100
            a, x = sort!(randn(100)), randn()
            @test searchsortednearest(a, x) == argmin(abs.(a .- x))
            @test searchsortednearest(reverse(a), x, rev=true) == argmin(abs.(reverse(a) .- x))
        end
    end
    @testset "searchsortedprev" begin
        @testset "range" begin
            A = sort(rand(-100:0.25:100, 20)); 
            RNG=rand(-100:0.25:100, 20)
            # @info "set = $A"
            for rng in RNG
                ind_method1 = searchsortedprevious(A, rng)
                ind_method2 = max(searchsortedfirst(rng .<= A, true) - 1, 1)
                # @info "test" rng
                @test ind_method1 == ind_method2
            end
        end
        @testset "groundtruth" begin
            @test all(searchsortedprevious.([collect(0.25:1:10.25)], 1:10) .== collect(1:10))
        end
    end
    @testset "searchsortednext" begin
        @testset "range" begin
            A = sort(rand(-100:0.25:100, 20)); 
            RNG=rand(-100:0.25:100, 20);
            for rng in RNG
                ind_method1 = searchsortednext(A, rng)
                ind_method2 = min(searchsortedfirst(rng .<= A, true),length(A))
                @test ind_method1 == ind_method2
            end
        end
        @testset "groundtruth" begin
            @test all(searchsortednext.([collect(0.75:1:10.75)], 1:10) .== (1 .+ collect(1:10)))
        end
    end
end
