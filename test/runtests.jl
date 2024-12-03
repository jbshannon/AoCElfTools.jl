using AoCElfTools
using AoCElfTools: samplepath, userpath
using Test
using Printf

function check_day(filepath)
    istr = filepath |> basename |> splitext |> first
    return parse(Int, istr), istr
end

@testset verbose=true "2024" begin
    datadir = joinpath(@__DIR__, "2024/data")
    foreach(include, readdir("2024/tests"; join=true))
end
