module Day8

import ..parseday
import ..solveday

function parseday(::Val{8})
    function f(io)
        seq, N = split(read(io, String), "\n\n")
        positions = [1:3, 8:10, 13:15]
        nodes = map(line -> [line[p] for p in positions], split(N, '\n'))
        return seq, nodes
    end
end

const DIRECTIONS = Dict('L' => 2, 'R' => 3)

findnode(target, nodes) = findfirst(row -> row[1] == target, nodes)

function followstep(cur, direction, nodes)
    i = findnode(cur, nodes)
    j = Dict('L' => 2, 'R' => 3)[direction]
    # isnothing(i) && @debug("Node not found", i, cur)
    return nodes[i][j]
end

function followstep(cur, direction, nodes, imap)
    return nodes[imap[cur]][direction == 'L' ? 2 : 3]
end

function checkperiod(path, N)
    i = length(path) - N
    while i >= 1
        path[i] == path[end] && break
        i -= N
    end
    return i
end

function findcycle(start, directions, nodes, imap)
    path, cur = [start], start
    for direction in Iterators.cycle(directions)
        cur = followstep(cur, direction, nodes, imap)
        append!(path, [cur])
        checkperiod(path, length(directions)) >= 1 && return path
    end
end

function solveday(::Val{8})
    function f(input)
        seq, nodes = input
        imap = Dict(s => i for (i, s) in enumerate(first.(nodes)))
        A = filter(n -> endswith(n, 'A'), first.(nodes))
        cycles = [findcycle(a, seq, nodes, imap) for a in A]
        periods = [findfirst(Base.Fix2(endswith, 'Z'), c) - 1 for c in cycles]

        ans₁ = periods[findfirst(==("AAA"), A)]
        ans₂ = lcm(periods...)
        return ans₁, ans₂
    end
end

end # module Day8
