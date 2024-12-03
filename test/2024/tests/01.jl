@testset "Day 1" begin
    # Puzzle answers

    answers = Dict(
        "sample" => (11, 31),
        "jbshannon" => (1110981, 24869388)
    )

    for (user, answer) in answers
        @test open(parse_solve(1), joinpath(datadir, user, "01.txt"))
    end
end
