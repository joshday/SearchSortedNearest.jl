module SearchSortedNearest

export searchsortednearest

# from: https://discourse.julialang.org/t/findnearest-function/4143/5
"""
    searchsortednearest(a, x; by=<transform>, lt=<comparison>, distance=(a,b) -> abs(a-b), rev=false)

Find the index of (sorted) collection `a` that has the smallest `distance` to `x`.  
Ties go to the smallest index.

# Examples 

    using SearchSortedNearest

    searchsortednearest(1:10, 1.1) == 1
    searchsortednearest(1:10, 1.9) == 2
"""
function searchsortednearest(a, x; by=identity, lt=isless, rev=false, distance=(a,b)->abs(a-b))
    i = searchsortedfirst(a, x; by, lt, rev)
    if i == 1
    elseif i > length(a)
        i = length(a)
    elseif a[i] == x 
    else
        i = lt(distance(by(a[i]), by(x)), distance(by(a[i - 1]), by(x))) ? i : i - 1
    end
    return i
end

end
