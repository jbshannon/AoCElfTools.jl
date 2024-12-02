module Day10

import ..parseday
import ..solveday

function parseday(::Val{10})
    function f(io)
        permutedims(mapreduce(collect, hcat, readlines(io)))
    end
end

const boxchars = Dict(
    '-' => Char(0x2500),
    '|' => Char(0x2502),
    'L' => Char(0x2514),
    'J' => Char(0x2518),
    '7' => Char(0x2510),
    'F' => Char(0x250c),
    'S' => Char(0x253c),
    '.' => ' ',
)

const CI = CartesianIndex
const N, E, S, W = CI(-1, 0), CI(0, 1), CI(1, 0), CI(0, -1)
const DIR = Dict(
    '|' => (N, S),
    '-' => (W, E),
    'L' => (N, E),
    'J' => (N, W),
    '7' => (S, W),
    'F' => (S, E),
    'S' => (N, S, W, E),
    '.' => (),
)

isconnected(a, b, grid) = ((b - a) in DIR[grid[a]]) & ((a - b) in DIR[grid[b]])
getfirst(f, x) = x[findfirst(f, x)]
function progress!(history, grid)
    cur = history[end]
    prev = length(history) > 1 ? history[end-1] : zero(cur)
    d = getfirst(d -> isconnected(cur, cur+d, grid) & (prev != cur+d), DIR[grid[cur]])
    push!(history, cur+d)
    return history
end

function traceloop(grid)
    history = [findfirst(==('S'), grid)]
    while length(history) == 1 || last(history) != first(history)
        progress!(history, grid)
    end
    return history
end

function shoelace(history)
    A = 0
    for i in 2:length(history)-1
        A += history[i][1] * (history[i+1][2] - history[i-1][2])
    end
    return A ÷ 2
end

function solveday(::Val{10})
    function f(input)
        loop = traceloop(input)
        ans₁ = length(loop) ÷ 2
        ans₂ = shoelace(loop) - length(loop) ÷ 2 + 1
        return ans₁, ans₂
    end
end

end # module Day10
