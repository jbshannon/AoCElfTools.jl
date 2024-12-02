module Day12

import ..parseday
import ..solveday

function parseday(::Val{12})
    function f(io)
        map(readlines(io)) do line
            conditions, groups = split(line, ' ')
            return conditions, parse.(Int, split(groups, ','))
        end
    end
end

const CACHE = Dict{Tuple{AbstractString, Vector{Int}}, Int}()

countrecursive(str, ints) = countrecursive((str, ints))
function countrecursive(line)
    get!(CACHE, line) do
        str, ints = line

        # No groups left, valid permutation if there are no springs left
        isempty(ints) && return Int(all(!=('#'), str))

        # Not enough characters left in string for all groups, invalid
        sum(ints) + length(ints) - 1 > length(str) && return 0

        # If no spring, move on and return count for the remaining string
        first(str) == '.' && return countrecursive(str[2:end], ints)

        # Count possible combinations
        count = first(str) == '?' ? countrecursive(str[2:end], ints) : 0
        N = first(ints)
        nogaps = all(!=('.'), first(str, N))
        canfinish = get(str, N+1, '.') != '#'
        if nogaps && canfinish
            count += countrecursive(str[N+2:end], ints[2:end])
        end
        return count
    end
end

function unfold(N)
    function f(line)
        str, ints = line
        return join(fill(str, N), '?'), repeat(ints, N)
    end
end

function solveday(::Val{12})
    function f(input)
        empty!(CACHE)
        ans₁ = sum(countrecursive, input)
        ans₂ = sum(countrecursive ∘ unfold(5), input)
        return ans₁, ans₂
    end
end

end # module Day12
