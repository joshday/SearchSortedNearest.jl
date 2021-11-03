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
    if idx == 1
    elseif idx > length(a)
        idx = length(a)
    elseif a[idx] == x 
    else
        idx = lt(abs(by(a[idx]) - by(x)), abs(by(a[idx - 1]) - by(x))) ? idx : idx - 1
    end
    return idx
end

end
