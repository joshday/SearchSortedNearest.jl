# SearchSortedNearest


This package provides a single function:

    searchsortednearest(a, x; by=<transform>, lt=<comparison>, rev=false)

Find the index of (sorted) collection `a` that is nearest (smallest absolute difference) to `x`.  
Ties go to the smallest index.

## Examples 

    using SearchSortedNearest

    searchsortednearest(1:10, 1.1) == 1
    searchsortednearest(1:10, 1.9) == 2
