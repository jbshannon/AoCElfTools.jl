i, istr = check_day(@__FILE__)

@testset "Day $istr" begin

    # Puzzle answers
    answers = Dict(
        "sample" => (95437, 24933642),
        "jbshannon" => (919137, 2877389),
    )

    # Test parsing the sample input
    subdirs = Dict(
        "/" => ["/a", "/d"],
        "/a" => ["/a/e"],
        "/d" => String[],
        "/a/e" => String[],
    )
    contents = Dict(
        "/" => ["14848514 b.txt", "8504156 c.dat"],
        "/a" => ["29116 f", "2557 g", "62596 h.lst"],
        "/d" => ["4060174 j", "8033020 d.log", "5626152 d.ext", "7214296 k"],
        "/a/e" => ["584 i"]
    )
    target = (subdirs, contents)

    targetpath = joinpath(datadir, "sample", "$istr.txt")
    sample = open(parse_input(i), targetpath)
    @test sample == target

    # Test solutions
    for (dir, answer) in answers
        input_path = joinpath(datadir, dir, "$istr.txt")
        @test open(parse_solve(i), input_path) == answer
    end
end
