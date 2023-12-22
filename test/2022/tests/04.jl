i, istr = check_day(@__FILE__)

@testset "Day $istr" begin

    # Puzzle answers
    answers = Dict(
        "sample" => (2, 4),
        "jbshannon" => (433, 852),
    )

    # Test parsing the sample input
    targetpath = joinpath(datadir, "sample", "$istr.txt")
    target = [
        [2:4, 6:8],
        [2:3, 4:5],
        [5:7, 7:9],
        [2:8, 3:7],
        [6:6, 4:6],
        [2:6, 4:8],
    ]
    sample = open(parse_input(i), targetpath)
    @test sample == target

    # Test solutions
    for (dir, answer) in answers
        input_path = joinpath(datadir, dir, "$istr.txt")
        @test open(parse_solve(i), input_path) == answer
    end
end
