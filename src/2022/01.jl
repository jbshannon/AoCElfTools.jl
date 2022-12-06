module Day1

import ..parseday
import ..solveday

"""
    parseday(::Val{1}) -> (IO -> Vector{Int64})

Return a `Vector` containing the total number of calories each elf is carrying.

# Examples
```jldoctest
julia> open(parseday(Val(1)), samplepath(1))
5-element Vector{Int64}:
  6000
  4000
 11000
 24000
 10000
```
"""
function parseday(::Val{1})
    function f(io)
        elves = split(read(io, String), "\n\n")
        calories = map(elves) do elf
            sum(Base.Fix1(parse, Int), split(elf, '\n'))
        end
        return calories
    end
end

"Which elf is carrying the most calories?"
function mostcalories(input)
    max = 0
    current = 0
    for line in input
        if isempty(line)
            current = 0
        else
            current += parse(Int, line)
            current > max && (max = current)
        end
    end

    return max
end

"Calories carried by each elf"
function caloriescarried(input)
    calories = Int[]
    current = 0

    for line in input
        if isempty(line)
            push!(calories, current)
            current = 0
        else
            current += parse(Int, line)
        end
    end

    push!(calories, current)
    return calories
end

"""
    solveday(::Val{1}) -> (Vector{Int64} -> Tuple{Int64, Int64}})

Solve Day 1's puzzle:
- ans₁: the maximum number of calories carried by any elf
- ans₂: the sum of calories carried by the three elves carrying the most calories

# Examples
```jldoctest
julia> input = open(parseday(Val(1)), samplepath(1))
5-element Vector{Int64}:
  6000
  4000
 11000
 24000
 10000

julia> solveday(Val(1))(input)
(24000, 45000)
```
"""
function solveday(::Val{1})
    function f(input)
        partialsort!(input, 1:3; rev=true)
        return (first(input), sum(input[1:3]))
    end
end

end # module

using .Day1
