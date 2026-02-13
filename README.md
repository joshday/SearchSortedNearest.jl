[![CI](https://github.com/joshday/SearchSortedNearest.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/joshday/SearchSortedNearest.jl/actions/workflows/CI.yml)
[![Docs Build](https://github.com/joshday/SearchSortedNearest.jl/actions/workflows/Docs.yml/badge.svg)](https://github.com/joshday/SearchSortedNearest.jl/actions/workflows/Docs.yml)
[![Stable Docs](https://img.shields.io/badge/docs-stable-blue)](https://joshday.github.io/SearchSortedNearest.jl/stable/)
[![Dev Docs](https://img.shields.io/badge/docs-dev-blue)](https://joshday.github.io/SearchSortedNearest.jl/dev/)

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

[This implementation is based on code provided by `@traktofon`](https://discourse.julialang.org/t/findnearest-function/4143/5) on the Julia Discourse.
