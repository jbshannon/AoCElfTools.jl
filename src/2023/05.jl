module Day5

import ..parseday
import ..solveday

function parsemap(line)
    i₀ = 0
    i₁ = findnext(' ', line, i₀+1)
    i₂ = findnext(' ', line, i₁+1)
    return (
        parse(Int, line[i₀+1:i₁-1]),
        parse(Int, line[i₁+1:i₂-1]),
        parse(Int, line[i₂+1:end]),
    )
end

function parseday(::Val{5})
    function f(io)
        blocks = split(read(io, String), "\n\n")
        seeds = map(Base.Fix1(parse, Int), split(blocks[1][8:end], " "))
        maps = map(blocks[2:end]) do block
            map(parsemap, split(block, "\n")[2:end])
        end
        return seeds, maps
    end
end

function torange(tup)
    dst, src, len = tup
    return range(src, length=len) => range(dst, length=len)
end
mappairs(M) = [torange(m) for m in M]

function combinerange(a, b)
    if first(a) <= last(b) && first(b) <= last(a)
        if first(a) <= first(b)
            if last(a) <= last(b)

            else
            end
        else
        end
    end
end

function combinemap(X, Y)
    Z = eltype(X)[]
    sort!(X)
    sort!(Y, by=y->y[2])
    i, j = 1, 1
    b = min(X[i][1], Y[j][2])
    if b > 0
        Δb, b = b, 0
        Δa = Δc = Δb
        a, c = 0, 0
    else
        a, c = X[i][2], Y[j][1]
        Δa, Δc = X[i][3], Y[j][3]
    end
    a, c = 1, 1
    @info "Initial values" a b c i j Δa Δc
    # while i == 1 && j == 1
    #     Δb = min(X[i][1], Y[j][2]) - b
    #     Δa -= Δb; Δc -= Δb
    #     Δa == 0 && begin b, a, Δa = X[i]; i += 1 end
    #     Δc == 0 && begin c, b, Δc = Y[j]; j += 1 end
    #     @info "After updating" a b c i j Δa Δc
    #     push!(Z, (c, a, Δb))
    #     @info "New deltas" Δa Δb Δc
    #     a += Δa; c += Δc
    #     return Z
    # end
    return Z
end

function followmap(s, M)
    for m in M
        dst, src, len = m
        src <= s <= src+len-1 && return dst + (s - src)
    end
    return s
end

function seedtoloc(s, maps)
    for M in maps
        s = followmap(s, M)
    end
    return s
end

# need a function to combine all the maps into one long map
# combine ranges
# take a list of from ranges and a list of to ranges and split them

function solveday(::Val{5})
    function f(input)
        seeds, maps = input
        ans₁ = minimum(s -> seedtoloc(s, maps), seeds)
        ans₂ = nothing
        return ans₁, ans₂
    end
end

end # module Day5
