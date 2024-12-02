module AoCElfTools

# Project dependencies (from Base)
using Printf
using Dates

# Abstract function to be extended for each day
function parseday end
function solveday end

# Include utility functions
include("utils.jl")

export samplepath
export userpath

# Include solution code
foreach(include, readdir(joinpath(@__DIR__, "2023"); join=true))

"""
    parse_input(i::Int) -> (IO -> puzzle input)

Returns a function that parses Day `i`'s puzzle input into a data structure that can then
be used to find a solution.

Designed to be passed as a first argument to `open`.

# Examples
```jldoctest
julia> input = samplepath(1);

julia> println(read(input, String))
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000

julia> open(parse_input(1), input)
5-element Vector{Int64}:
  6000
  4000
 11000
 24000
 10000
```
"""
parse_input(i::Int) = parseday(Val(i))


"""
    solve(i::Int) -> (puzzle input -> solution)

Returns a function that receive's Day `i`'s puzzle input and returns a solution as a `Tuple`
containing the two answers.

# Examples
```jldoctest
julia> input = open(parse_input(1), samplepath(1))
5-element Vector{Int64}:
  6000
  4000
 11000
 24000
 10000

julia> solve(1)(input)
(24000, 45000)
```
"""
solve(i::Int) = solveday(Val(i))


"""
    parse_solve(i::Int) -> (IO -> solution)

Returns a function that combines the parsing and solution steps for Day `i`.

Designed to be passed as a first argument to `open`.

# Examples
```jldoctest
julia> input = samplepath(1);

julia> println(read(input, String))
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000

julia> open(parse_solve(1), input)
(24000, 45000)
```
"""
parse_solve(i) = solveday(Val(i)) ∘ parseday(Val(i))

export parse_input
export solve
export parse_solve

export parseday
export solveday

end
