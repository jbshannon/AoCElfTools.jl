module Day4

import ..parseday
import ..solveday

readnumbers(str) = [parse(Int, str[i:i+1]) for i in 1:3:length(str)]

function parseday(::Val{4})
    function f(io)
        map(readlines(io)) do line
            card = line[findfirst(==(':'), line)+2:end]
            winning, numbers = map(readnumbers, split(card, " | "))
        end
    end
end

countmatches(card) = count(in(card[1]), card[2])
scorecard(matches) = iszero(matches) ? 0 : 2^(matches-1)

function duplicates(M)
    c = fill(1, size(M))
    for i in eachindex(M, c)
        dups = M[i]
        for j in i+1:i+dups
            c[j] += c[i]
        end
    end
    return c
end

function solveday(::Val{4})
    function f(input)
        M = countmatches.(input)
        ans₁ = sum(scorecard, M)
        ans₂ = sum(duplicates(M))
        return ans₁, ans₂
    end
end

end # module Day4
