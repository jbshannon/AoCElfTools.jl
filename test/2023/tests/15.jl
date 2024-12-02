i, istr = checkday(@__FILE__)
datadir = joinpath(dirname(dirname((@__FILE__))), "data")

@testset "Day $istr" begin

    # Puzzle answers
    answers = Dict(
        "sample" => (1320, 145),
        "jbshannon" => (510388, 291774),
    )

    # Test parsing the sample input
    sample = open(parseday(Val(i)), joinpath(datadir, "sample", "$istr.txt"))

    # Test solutions
    for (dir, answer) in answers
        @test open(parse_solve(i), joinpath(datadir, dir, "$istr.txt")) == answer
    end

    # Other miscellaneous tests
    using AoCElfTools.Day15: HASH
    @test HASH("HASH") == 52
    @test HASH.(sample) == [30, 253, 97, 47, 14, 180, 9, 197, 48, 214, 231]
end
