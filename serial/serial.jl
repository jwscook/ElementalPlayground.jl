using ElementalPlayground, LinearAlgebra, Test

using Random
Random.seed!(0)

const M = 5
const N = 4

const Ahost = rand(Float64, M, N)
const bhost = rand(Float64, M)

const A = zeros(Float64, M, N)
const b = zeros(Float64, M)

const rowthings = 1:M
const colthings = 1:N

ElementalPlayground.bar!(A, rowthings, colthings, Ahost)
ElementalPlayground.qux!(b, rowthings, bhost)

x = ElementalPlayground.baz!(A, b)
@show x
@testset "distributed" begin
  @test x ≈ Ahost \ bhost
end
