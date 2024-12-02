module Day15

import ..parseday
import ..solveday

function parseday(::Val{15})
    function f(io)
        return split(read(io, String), ',')
    end
end

function HASH(str)
    val = 0
    for char in str
        val = rem((val + Int(char)) * 17, 256)
    end
    return val
end

function opdash!(boxes, str)
    lab = str[1:end-1]
    box = boxes[1 + HASH(lab)]
    slot = findfirst(==(lab) ∘ first, box)
    !isnothing(slot) && deleteat!(box, slot)
    return boxes
end

function opeq!(boxes, str)
    lab, focal = split(str, '=')
    lens = (lab, parse(Int, focal))
    box = boxes[1 + HASH(lab)]
    slot = findfirst(==(lab) ∘ first, box)
    isnothing(slot) ? push!(box, lens) : setindex!(box, lens, slot)
    return boxes
end

function HASHMAP(steps)
    boxes = [Tuple{String, Int}[] for _ in 0:255]
    foreach(s -> (('=' in s) ? opeq! : opdash!)(boxes, s), steps)
    return boxes
end

boxpower(box) = sum(((slot, lens),) -> slot * last(lens), enumerate(box); init=0)
focuspower(boxes) = sum(((i, box),) -> i * boxpower(box), enumerate(boxes))

function solveday(::Val{15})
    function f(input)
        ans₁ = sum(HASH, input)
        ans₂ = focuspower(HASHMAP(input))
        return ans₁, ans₂
    end
end

end # module Day15
