i, istr = check_day(@__FILE__)

@testset "Day $istr" begin

    # Puzzle answers
    answers = Dict(
        "sample" => (24000, 45000),
        "pbouffard" => (66487, 197301),
        "jbshannon" => (70613, 205805),
    )

    # Test parsing the sample input
    target = [6, 4, 11, 24, 10]*1000
    sample = open(parse_input(i), joinpath(datadir, "sample", "$istr.txt"))
    @test sample == target

    # Test solutions
    for (dir, answer) in answers
        input_path = joinpath(datadir, dir, "$istr.txt")
        @test open(parse_solve(i), input_path) == answer
    end

    # Other miscellaneous tests
end
