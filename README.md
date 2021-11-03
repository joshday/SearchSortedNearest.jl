[![Build status](https://github.com/joshday/SearchSortedNearest.jl/workflows/CI/badge.svg)](https://github.com/joshday/SearchSortedNearest.jl/actions?query=workflow%3ACI+branch%3Amaster)

# SearchSortedNearest


This package provides a single function:

```julia
searchsortednearest(a, x; by=<transform>, lt=<comparison>, distance=(a,b)->abs(a-b), rev=false)
```

Find the index of (sorted) collection `a` that has the smallest `distance` to `x`.  
Ties go to the smallest index.

## Examples 

```julia
using SearchSortedNearest

searchsortednearest(1:10, 1.1) == 1
searchsortednearest(1:10, 1.9) == 2
```

## Attribution

[Credit goes to `@traktofon`](https://discourse.julialang.org/t/findnearest-function/4143/5) on the Julia Discourse.
