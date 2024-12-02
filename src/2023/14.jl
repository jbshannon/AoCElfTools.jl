module Day14

import ..parseday
import ..solveday

function parseday(::Val{14})
    function f(io)
        permutedims(stack(readlines(io)))
    end
end

const 𝐍 = (dims=2, rev=true)
const 𝐒 = (dims=2, rev=false)
const 𝐖 = (dims=1, rev=true)
const 𝐄 = (dims=1, rev=false)

function rollslice!(slice; rev=true)
    prev, N = extrema(eachindex(slice))
    i1 = one(prev)
    while prev <= N
        next = findnext(==('#'), slice, prev)
        next = isnothing(next) ? N + i1 : next
        sort!(view(slice, prev:next-i1); rev)
        prev = next + i1
    end
    return slice
end

function roll!(platform; dims=2, rev=true)
    foreach(slice -> rollslice!(slice; rev), eachslice(platform; dims))
    return platform
end

function spincycle!(platform)
    foreach(d -> roll!(platform; d...), (𝐍, 𝐖, 𝐒, 𝐄))
    return platform
end

function findcycle!(platform)
    hashload(x) = hash(x), load(x)
    history = [hashload(platform)]
    while findfirst(==(last(history)), history) == last(eachindex(history))
        push!(history, hashload(spincycle!(platform)))
    end
    return history
end

function extrapolate(history, N)
    a, b = findall(==(last(history)), history)
    warmup, period = (a - 1, b - a)
    return history[N < warmup ? 1 + N : 1 + warmup + rem(N - warmup, period)]
end

function load(platform; dims=1, rev=true)
    S = eachslice(platform; dims)
    I = (rev ? reverse : identity)(eachindex(S))
    return sum(((s, i),) -> count(==('O'), s) * i, zip(S, I))
end

function solveday(::Val{14})
    function f(input)
        ans₁ = load(roll!(deepcopy(input)))
        ans₂ = extrapolate(findcycle!(deepcopy(input)), 1000000000)[end]
        return ans₁, ans₂
    end
end

end # module Day14
