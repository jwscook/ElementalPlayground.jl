using MPI, MPIClusterManagers, Distributed, Test
using ElementalPlayground

using Random
Random.seed!(0)

const M = 5
const N = 4

const Ahost = rand(Float64, M, N)
const bhost = rand(Float64, M)

man = MPIWorkerManager(2);

addprocs(man, exeflags="--project=distributed");

@mpi_do man begin
  using ElementalPlayground
  using LinearAlgebra
  using Elemental

  M = @fetchfrom 1 M
  N = @fetchfrom 1 N

  Aall = @fetchfrom 1 Ahost
  ball = @fetchfrom 1 bhost

  A = Elemental.DistMatrix(Float64);
  b = Elemental.DistMatrix(Float64);

  A = Elemental.zeros!(A, M, N);
  b = Elemental.zeros!(b, M);

  rowthings = 1:M
  colthings = 1:N

  ElementalPlayground.qux!(b, rowthings, ball)

  ElementalPlayground.bar!(A, rowthings, colthings, Aall)

  x = ElementalPlayground.baz!(A, b)

  localx = zeros(Float64, Elemental.localHeight(x), Elemental.localWidth(x))
  copyto!(localx, Elemental.localpart(x))
end

x = vcat((fetch(@spawnat p localx)[:] for p in workers())...)
@show x
@testset "distributed" begin
  @test x ≈ Ahost \ bhost
end
