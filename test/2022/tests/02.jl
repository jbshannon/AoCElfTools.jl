i, istr = check_day(@__FILE__)

@testset "Day $istr" begin

    # Puzzle answers
    answers = Dict(
        "sample" => (15, 12),
        "jbshannon" => (14069, 12411),
    )

    # Test parsing the sample input
    target = [(0, 1), (1, 0), (2, 2)]
    sample = open(parse_input(i), joinpath(datadir, "sample", "$istr.txt"))
    @test sample == target

    # Test solutions
    for (dir, answer) in answers
        input_path = joinpath(datadir, dir, "$istr.txt")
        @test open(parse_solve(i), input_path) == answer
    end

    # Test core rock-paper-scissors functions
    rock, paper, scissors = (0, 1, 2)
    lose, draw, win = (0, 1, 2)

    let f = AoCElfTools.Day2.shoot
        @test f(rock, rock) == draw
        @test f(rock, paper) == lose
        @test f(rock, scissors) == win
        @test f(paper, rock) == win
        @test f(paper, paper) == draw
        @test f(paper, scissors) == lose
        @test f(scissors, rock) == lose
        @test f(scissors, paper) == win
        @test f(scissors, scissors) == draw
    end

    let f = AoCElfTools.Day2.strategy
        @test f(win, rock) == paper
        @test f(win, paper) == scissors
        @test f(win, scissors) == rock
        @test f(draw, rock) == rock
        @test f(draw, paper) == paper
        @test f(draw, scissors) == scissors
        @test f(lose, rock) == scissors
        @test f(lose, paper) == rock
        @test f(lose, scissors) == paper
    end

    # Scoring the example rounds
    let score = AoCElfTools.Day2.score1 ∘ AoCElfTools.Day2.decode
        @test score("A Y") == 8
        @test score("B X") == 1
        @test score("C Z") == 6
    end

    let score = AoCElfTools.Day2.score2 ∘ AoCElfTools.Day2.decode
        @test score("A Y") == 4
        @test score("B X") == 1
        @test score("C Z") == 7
    end
end
