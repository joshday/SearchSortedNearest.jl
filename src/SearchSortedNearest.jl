module SearchSortedNearest

export searchsortednearest

# from: https://discourse.julialang.org/t/findnearest-function/4143/5
"""
    searchsortednearest(a, x; by=<transform>, lt=<comparison>, rev=false)

Find the index of (sorted) collection `a` that is nearest (smallest absolute difference) to `x`.  
Ties go to the smallest index.

# Examples 

    using SearchSortedNearest

    searchsortednearest(1:10, 1.1) == 1
    searchsortednearest(1:10, 1.9) == 2
"""
function searchsortednearest(a, x; by=identity, lt=isless, rev=false)
    idx = searchsortedfirst(a, x; by, lt, rev)
    idx == 1 && return idx
    idx > length(a) && return length(a)
    a[idx] == x && return idx 
    idx = lt(abs(by(a[idx]) - by(x)), abs(by(a[idx - 1]) - by(x))) ? idx : idx - 1
    return rev ? length(a) - idx + 1 : idx
end

end
