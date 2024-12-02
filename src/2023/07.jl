module Day7

import ..parseday
import ..solveday

function parseday(::Val{7})
    function f(io)
        map(readlines(io)) do line
            hand, bid = split(line, " ")
            return Tuple(hand), parse(Int, bid)
        end
    end
end

function countmap(::Val{1})
    function f(hand)
        out = Dict{eltype(hand), Int}()
        for card in hand
            out[card] = haskey(out, card) ? out[card] + 1 : 1
        end
        return out
    end
end

function countmap(::Val{2})
    function f(hand)
        out = countmap(Val(1))(hand)
        if haskey(out, 'J') && length(out) > 1
            jokers = pop!(out, 'J')
            out[argmax(out)] += jokers
        end
        return out
    end
end

cardrank(::Val{1}) = Base.Fix2(findfirst, "23456789TJQKA")
cardrank(::Val{2}) = Base.Fix2(findfirst, "J23456789TQKA")
function handlt(A, B; by=cardrank(Val(1)))
    for (a, b) in zip(A, B)
        a == b ? continue : return by(a) < by(b)
    end
    return false
end

_scorehand(_countmap) = hand -> hand |> _countmap |> values |> collect |> sort! |> reverse! |> Tuple
scorehand(::Val{1}) = _scorehand(countmap(Val(1)))
scorehand(::Val{2}) = _scorehand(countmap(Val(2)))

function handsortperm(hands, scores; by=cardrank(Val(1)))
    lt(i, j) = scores[i] == scores[j] ? handlt(hands[i], hands[j]; by) : isless(scores[i], scores[j])
    return invperm(sortperm(eachindex(hands); lt))
end

function solvepart(part)
    function f(input)
        hands, bids = first.(input), last.(input)
        scores = scorehand(part).(hands)
        ranks = handsortperm(hands, scores; by=cardrank(part))
        return bids'ranks
    end
end

solveday(::Val{7}) = input -> ntuple(i -> solvepart(Val(i))(input), 2)

end # module Day7
