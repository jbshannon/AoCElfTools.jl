module Day11

import ..parseday
import ..solveday

function parseday(::Val{11})
    function f(io)
        io |> readlines |> stack |> permutedims
    end
end

expandweights(U) = [[all(==('.'), s) for s in eachslice(U; dims)] for dims in 1:ndims(U)]

function shortestpath(a, b, W; Δ=1)
    R = min(a, b):max(a, b)
    dist = -2 # don't count initial galaxy and don't double count corner
    for i in axes(R, 1)
        ii = Tuple(R[i, 1])[1]
        dist += 1 + (Δ - 1) * W[1][ii]
    end
    for j in axes(R, 2)
        jj = Tuple(R[1, j])[2]
        dist += 1 + (Δ - 1) * W[2][jj]
    end
    return dist
end

function sumpaths(G, W; Δ=1)
    dist = 0
    for i in eachindex(G), j in Iterators.drop(eachindex(G), i)
        dist += shortestpath(G[i], G[j], W; Δ)
    end
    return dist
end

function dimdistance(universe, Δ, dims)
    galaxies = sum(universe; dims) |> vec
    passed = dist = total = 0
    for i in eachindex(galaxies)
        dist += passed * (galaxies[i] > 0 ? 1 : Δ) # distance * passed galaxies
        total += dist * galaxies[i] # distance * passed galaxies * destination galaxies
        passed += galaxies[i] # count the number of galaxies passed
    end
    return total
end

function solveday(::Val{11})
    function f(input)
        # G = findall(==('#'), input)
        # W = expandweights(input)
        # ans₁ = sumpaths(G, W; Δ=2)
        # ans₂ = sumpaths(G, W; Δ=1000000)
        universe = input .== '#'
        ans₁ = sum(d -> dimdistance(universe,       2, d), 1:ndims(universe))
        ans₂ = sum(d -> dimdistance(universe, 1000000, d), 1:ndims(universe))
        return ans₁, ans₂
    end
end

end # module Day11
