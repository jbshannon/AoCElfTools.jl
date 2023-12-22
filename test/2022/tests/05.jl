i, istr = check_day(@__FILE__)

@testset "Day $istr" begin

    # Puzzle answers
    answers = Dict(
        "sample" => ("CMZ", "MCD"),
        "jbshannon" => ("QMBMJDFTD", "NBTVTJNFJ"),
    )

    # Test parsing the sample input
    targetpath = joinpath(datadir, "sample", "$istr.txt")
    stacks = [['Z', 'N'], ['M', 'C', 'D'], ['P']]
    instructions = [[1, 2, 1], [3, 1, 3], [2, 2, 1], [1, 1, 2]]
    target = (stacks, instructions)
    sample = open(parse_input(i), targetpath)
    @test sample == target

    # Test solutions
    for (dir, answer) in answers
        input_path = joinpath(datadir, dir, "$istr.txt")
        @test open(parse_solve(i), input_path) == answer
    end
end
