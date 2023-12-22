i, istr = check_day(@__FILE__)

@testset "Day $istr" begin

    # Puzzle answers
    answers = Dict(
        "sample" => (157, 70),
        "jbshannon" => (7701, 2644),
    )

    # Test parsing the sample input
    targetpath = joinpath(datadir, "sample", "$istr.txt")
    target = open(readlines, targetpath)
    sample = open(parse_input(i), targetpath)
    @test sample == target

    # Test solutions
    for (dir, answer) in answers
        input_path = joinpath(datadir, dir, "$istr.txt")
        @test open(parse_solve(i), input_path) == answer
    end
end
