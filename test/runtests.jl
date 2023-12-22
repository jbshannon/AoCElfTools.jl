using AoCElfTools
using AoCElfTools: samplepath, userpath
using Test
using Printf

function check_day(filepath)
    istr = filepath |> basename |> splitext |> first
    return parse(Int, istr), istr
end

@testset verbose=true "2022" begin
    datadir = joinpath(@__DIR__, "2022/data")
    foreach(include, readdir("2022/tests"; join=true))
end
