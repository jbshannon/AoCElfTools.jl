module Day9

import ..parseday
import ..solveday

function parseday(::Val{9})
    function f(io)
        map(readlines(io)) do line
            map(Base.Fix1(parse, Int), split(line, ' '))
        end
    end
end

function pyramid(seq)
    P = [seq]
    while !all(iszero, P[end])
        append!(P, [diff(P[end])])
    end
    return P
end

extrapolate(p) = sum(last, p)
extrapolateback(p) = mapfoldr(first, -, p)

function predict(seq)
    all(iszero, seq) && return 0
    last(seq) + predict(diff(seq))
end

function solveday(::Val{9})
    function f(input)
        # P = pyramid.(input)
        # ans₁ = sum(extrapolate, P)
        # ans₂ = sum(extrapolateback, P)
        ans₁ = sum(predict, input)
        ans₂ = sum(predict ∘ reverse, input)
        return ans₁, ans₂
    end
end

end # module Day9
