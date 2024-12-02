module Day13

import ..parseday
import ..solveday

function parseday(::Val{13})
    function f(io)
        patterns = split(read(io, String), "\n\n")
        return map(permutedims ∘ stack ∘ Base.Fix2(split, '\n'), patterns)
    end
end

allslices(A) = ntuple(d -> eachslice(A; dims=d), ndims(A))
countmismatches(a, b) = sum(Base.splat(!=), zip(a, b))
score(reflection::Tuple{Int, Int}) = reflection[1] * 100 + reflection[2]

function countsmudges(slices)
    map(Iterators.take(eachindex(slices), length(slices) - 1)) do i
        window = 0:min(i-1, length(slices)-i-1)
        return sum(j -> countmismatches(slices[i-j], slices[i+j+1]), window)
    end
end

function findreflection(smudgecount)
    f(smudges) = map(smudges) do s
        i = findfirst(==(smudgecount), s)
        return isnothing(i) ? 0 : i
    end
end

function solveday(::Val{13})
    function f(input)
        smudgecounts = map(P -> map(countsmudges, allslices(P)), input)
        ans₁ = sum(score ∘ findreflection(0), smudgecounts)
        ans₂ = sum(score ∘ findreflection(1), smudgecounts)
        return ans₁, ans₂
    end
end

end # module Day13
