using Each
using Test

@testset "Each.jl" begin
    @test sum.(each(Tuple{Vararg{Number}},((1,1),(1,2),(1,3)))) == (2,3,4)
    @test sum.(each(Tuple{Vararg{Number}},(1,1))) == (2,)
    @test_throws ErrorException each(String,((1,2),(3,4)))
    @test eltype(each(String,"something")) == String
end
