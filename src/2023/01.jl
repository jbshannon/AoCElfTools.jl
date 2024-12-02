module Day1

import ..parseday
import ..solveday

function parseday(::Val{1})
    function f(io)
        return readlines(io)
    end
end

function calibrationvalue(line)
    ds = filter(isdigit, line)
    return parse(Int, first(ds) * last(ds))
end

function correctinput(line)
    ps = [
        "one" => "o1e",
        "two" => "t2o",
        "three" => "t3e",
        "four" => "4",
        "five" => "5e",
        "six" => "6",
        "seven" => "7n",
        "eight" => "e8t",
        "nine" => "n9e",
    ]
    f(s) = replace(s, ps...)
    return (f∘f)(line)
end

function solveday(::Val{1})
    function f(input)
        ans₁ = sum(calibrationvalue, input)
        ans₂ = sum(calibrationvalue ∘ correctinput, input)
        return ans₁, ans₂
    end
end

end # module Day1
