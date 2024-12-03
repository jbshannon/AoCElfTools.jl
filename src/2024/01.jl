module Day1

import ..parseday
import ..solveday

function parseday(::Val{1})
    function f(io)
        lines = map(readlines(io)) do line
            map(d -> parse(Int, d), split(line, "   "))
        end
        return first.(lines), last.(lines)
    end
end

distance!(L, R) = sum(abs ∘ splat(-), zip(sort!(L), sort!(R)))
similarity(L, R) = sum(i -> L[i] * count(==(L[i]), R), eachindex(L))

function solveday(::Val{1})
    function f(input)
        L, R = input
        ans₁ = distance!(L, R)
        ans₂ = similarity(L, R)
        return ans₁, ans₂
    end
end

end
