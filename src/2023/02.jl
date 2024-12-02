module Day2

import ..parseday
import ..solveday

function parseround(round)
    out = zeros(Int, 3)
    indmap = Dict("red" => 1, "green" => 2, "blue" => 3)
    for balls in split(round, ", ")
        num, color = split(balls, " ")
        out[indmap[color]] = parse(Int, num)
    end
    return out
end

function parseday(::Val{2})
    function f(io)
        map(readlines(io)) do line
            pre, post = split(line, ": ")
            id = parse(Int, pre[6:end])
            game = map(parseround, split(post, "; "))
            return game
        end
    end
end

function ispossible(balls, maxpossible)
    return all(i -> balls[i] <= maxpossible[i], eachindex(balls, maxpossible))
end

function power(round)
    out = 1
    for c in 1:3
        cur = 1
        for balls in round
            cur = max(cur, balls[c])
        end
        out *= cur
    end
    return out
end

function solveday(::Val{2})
    function f(input)
        possible = map(input) do game
            all(balls -> ispossible(balls, [12, 13, 14]), game)
        end
        ans₁ = sum(findall(possible))
        ans₂ = sum(power, input)
        return ans₁, ans₂
    end
end

end # module Day2
