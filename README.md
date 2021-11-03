# SearchSortedNearest


This package provides a single function:

```julia
searchsortednearest(a, x; by=<transform>, lt=<comparison>, rev=false)
```

Find the index of (sorted) collection `a` that is nearest (smallest absolute difference) to `x`.  
Ties go to the smallest index.

## Examples 

```julia
using SearchSortedNearest

searchsortednearest(1:10, 1.1) == 1
searchsortednearest(1:10, 1.9) == 2
```

## Attribution

[Credit goes to `@traktofon`](https://discourse.julialang.org/t/findnearest-function/4143/5) on the Julia Discourse.
