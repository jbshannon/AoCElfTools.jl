i, istr = check_day(@__FILE__)

@testset "Day $istr" begin

    # Puzzle answers
    answers = Dict(
        "sample" => (21, 8),
        "jbshannon" => (1840, 405769),
    )

    # Test parsing the sample input
    target = [
        3 0 3 7 3
        2 5 5 1 2
        6 5 3 3 2
        3 3 5 4 9
        3 5 3 9 0
    ]

    targetpath = joinpath(datadir, "sample", "$istr.txt")
    sample = open(parse_input(i), targetpath)
    @test sample == target

    # Test solutions
    for (dir, answer) in answers
        input_path = joinpath(datadir, dir, "$istr.txt")
        @test open(parse_solve(i), input_path) == answer
    end

    # Checks from AoC setup
    # Part 1
    (𝐋, 𝐑, 𝐃, 𝐔) = AoCElfTools.Day8.getbearings(sample)
    isvisible = AoCElfTools.Day8.checkvisibility_direction(sample)

    t = 7 # top-left 5
    @test isvisible(t, 𝐋)
    @test isvisible(t, 𝐔)
    @test !isvisible(t, 𝐃)
    @test !isvisible(t, 𝐑)

    t = 12 # top-middle 5
    @test !isvisible(t, 𝐋)
    @test isvisible(t, 𝐔)
    @test !isvisible(t, 𝐃)
    @test isvisible(t, 𝐑)

    t = 17 # top-right 1
    @test !isvisible(t, 𝐋)
    @test !isvisible(t, 𝐔)
    @test !isvisible(t, 𝐃)
    @test !isvisible(t, 𝐑)

    t = 8 # left-middle 5
    @test !isvisible(t, 𝐋)
    @test !isvisible(t, 𝐔)
    @test !isvisible(t, 𝐃)
    @test isvisible(t, 𝐑)

    t = 13 # middle 3
    @test !isvisible(t, 𝐋)
    @test !isvisible(t, 𝐔)
    @test !isvisible(t, 𝐃)
    @test !isvisible(t, 𝐑)

    t = 18 # right-middle 3
    @test !isvisible(t, 𝐋)
    @test !isvisible(t, 𝐔)
    @test !isvisible(t, 𝐃)
    @test isvisible(t, 𝐑)

    # bottom row
    isvisible = AoCElfTools.Day8.checkvisibility(sample)
    @test isvisible(14)
    @test !isvisible(9)
    @test !isvisible(19)

    # Part 2
    treesviewed(i, direction) = AoCElfTools.Day8.treesviewed(i, direction, sample)
    scenicscore = AoCElfTools.Day8.checkscenery(sample)

    t = 12
    @test treesviewed(t, 𝐔) == 1
    @test treesviewed(t, 𝐋) == 1
    @test treesviewed(t, 𝐑) == 2
    @test treesviewed(t, 𝐃) == 2
    @test scenicscore(t) == 4

    t = 14
    @test treesviewed(t, 𝐔) == 2
    @test treesviewed(t, 𝐋) == 2
    @test treesviewed(t, 𝐑) == 2
    @test treesviewed(t, 𝐃) == 1
    @test scenicscore(t) == 8
end
