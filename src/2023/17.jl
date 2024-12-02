module Day17

import ..parseday
import ..solveday

function parseday(::Val{17})
    function f(io)
        return permutedims(stack(readlines(io)))
    end
end

function solveday(::Val{17})
    function f(input)
        ans₁ = nothing
        ans₂ = nothing
        return ans₁, ans₂
    end
end

end # module Day17
