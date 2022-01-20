using Each
using Test

@testset "Each.jl" begin
    @testset "each()" begin
        @test sum.(each(Tuple{Vararg{Number}},((1,1),(1,2),(1,3)))) == (2,3,4)
        @test sum.(each(Tuple{Vararg{Number}},(1,1))) == (2,)
        @test_throws ErrorException each(String,((1,2),(3,4)))
        @test eltype(each(String,"something")) == String
    end
    @testset "@each" begin
        x = [5, 10, 15, 20]
        @test @each x > 0 == true
        @test @each x < 0 == false
        @test @each x % 5 == true
        @test @each x == 5 == false
    end
    
end
