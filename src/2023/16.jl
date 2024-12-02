module Day16

import ..parseday
import ..solveday

function parseday(::Val{16})
    function f(io)
        return permutedims(stack(readlines(io)))
    end
end

const CI = CartesianIndex
const U, D, L, R = CI.(((-1, 0), (1, 0), (0, -1), (0, 1)))

const DIRECTIONS = Dict(
    '.' => Dict(
        U => [U],
        D => [D],
        L => [L],
        R => [R],
    ),
    '\\' => Dict(
        D => [R],
        L => [U],
        R => [D],
        U => [L],
    ),
    '/' => Dict(
        R => [U],
        D => [L],
        U => [R],
        L => [D],
    ),
    '|' => Dict(
        R => [U, D],
        L => [U, D],
        U => [U],
        D => [D],
    ),
    '-' => Dict(
        R => [R],
        L => [L],
        U => [L, R],
        D => [L, R],
    ),
)

function beam!(energy, beam, mirrors)
    pos, dir = beam
    energy[pos] += 1
    next = pos + dir
    if next in CartesianIndices(mirrors)
        # foreach(dir -> beam!(energy, (next, dir), mirrors), DIRECTIONS[mirrors[next]])
        length(DIRECTIONS[mirrors[next]][dir]) > 1 && @debug("Split at $next")
        for d in DIRECTIONS[mirrors[next]][dir]
            newbeam = (next, d)
            @debug beam newbeam
            beam!(energy, newbeam, mirrors)
        end
    end
    return energy
end

function solveday(::Val{16})
    function f(input)
        energy = zeros(Int, size(input))
        beam₀ = (CI(1, 1), R)
        @debug beam₀
        beam!(energy, beam₀, input)
        ans₁ = count(>(0), energy)
        ans₂ = nothing
        return ans₁, ans₂
    end
end

end # module Day16
