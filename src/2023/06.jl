module Day6

import ..parseday
import ..solveday

function parseday(::Val{6})
    function f(io)
        times, distances = map(readlines(io)) do line
            map(m -> parse(Int, m.match), eachmatch(r"\d+", line))
        end
    end
end

countwins(time, distance) = count(t -> t*(time-t) > distance, 1:time-1)
countwins(tup) = countwins(tup[1], tup[2])

dcat(a, b) = a * 10^ndigits(b) + b
minroot(a, b, c) = ceil(Int, (-b - sign(a)*sqrt(b^2 - 4*a*c))/2a)
minroot(t, d) = minroot(-1, t, -d)
numwins(t, d) = (r = minroot(t, d); 1 + t - 2*(r + (r*(t-r) == d)))
numwins(tup) = numwins(tup[1], tup[2])

function solveday(::Val{6})
    function f(input)
        times, distances = input
        ans₁ = prod(numwins, zip(times, distances))
        ans₂ = numwins(foldr(dcat, times), foldr(dcat, distances))
        return ans₁, ans₂
    end
end

end # module Day6
