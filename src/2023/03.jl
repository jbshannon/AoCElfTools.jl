module Day3

import ..parseday
import ..solveday

function parseday(::Val{3})
    function f(io)
        return vcat(map(permutedims ∘ collect, readlines(io))...)
    end
end

function outofbounds(I, A)
    Imin, Imax = extrema(CartesianIndices(A))
    return max(I, Imin) != I || min(I, Imax) != I
end

function startingdigit(I, A)
    Ipre = I - CartesianIndex(0, 1)
    return isdigit(A[I]) & (outofbounds(Ipre, A) || !isdigit(A[Ipre]))
end

function findstartofdigit(I, A)
    while !startingdigit(I, A)
        I -= CartesianIndex(0, 1)
    end
    return I
end

function digitvalue(I, A)
    val = 0
    for J in digitinds(I, A)
        val = 10*val + parse(Int, A[J])
    end
    return val
end

function digitinds(I, A)
    L = CartesianIndex(0, 1)
    J, Jpost = I, I+L
    while !(outofbounds(Jpost, A) || !isdigit(A[Jpost]))
        J, Jpost = J+L, Jpost+L
    end
    return I:J
end

function neighborhood(CI, A)
    Imin, Imax = extrema(CartesianIndices(A))
    IL = minimum(CI) - one(Imin)
    IR = maximum(CI) + one(Imax)
    return  max(Imin, IL):min(Imax, IR)
end

function partkernel(I, A)
    !startingdigit(I, A) && return 0
    adjsym = any(neighborhood(digitinds(I, A), A)) do J
        !isdigit(A[J]) & (A[J] != '.')
    end
    return adjsym ? digitvalue(I, A) : 0
end

function gearkernel(I, A)
    A[I] != '*' && return 0
    Js = neighborhood(I:I, A)
    val = 1
    adjnums = 0
    for J in Js
        if isdigit(A[J])
            Jpre = J - CartesianIndex(0, 1)
            if outofbounds(Jpre, A) || (!in(Jpre, Js) | !isdigit(A[Jpre]))
                adjnums += 1
                val *= digitvalue(findstartofdigit(J, A), A)
            end
        end
    end
    return adjnums == 2 ? val : 0
end

function finddigits(I, A)
    Ipre = I - CartesianIndex(1, 0)
    noprec = min(Ipre, CartesianIndex(1, 1)) == Ipre || !isdigit(A[Ipre])
    return isdigit(A[I]) & noprec
end

function solveday(::Val{3})
    function f(input)
        ans₁ = sum(I -> partkernel(I, input), CartesianIndices(input))
        ans₂ = sum(I -> gearkernel(I, input), CartesianIndices(input))
        return ans₁, ans₂
    end
end

end # module Day3
