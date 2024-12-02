const DATA_DIR = joinpath(dirname(@__DIR__), "test", string(year(Dates.today())), "data")

"""
    samplepath(i::Int) -> String

Return the path to the sample input file for Day `i`.

# Examples
```
julia> samplepath(1)
"test/data/sample/01.txt"

julia> samplepath(14)
"test/data/sample/14.txt"
```
"""
function samplepath(i::Int)
    istr = @sprintf("%02d", i)
    return relpath(joinpath(DATA_DIR, "sample", "$istr.txt"), pwd())
end


"""
    userpath(user, i::Int) -> String

Return the path to `user`'s input file for Day `i`.

# Examples
```
julia> userpath("jbshannon", 1)
"test/data/jbshannon/01.txt"

julia> userpath("jbshannon", 13)
"test/data/jbshannon/13.txt"
```
"""
function userpath(user, i::Int)
    istr = @sprintf("%02d", i)
    return relpath(joinpath(DATA_DIR, user, "$istr.txt"), pwd())
end
