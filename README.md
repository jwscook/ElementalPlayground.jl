# ElementalPlayground.jl

This repository serves as an example of how one can write a package with linear algebra that can be used in the same way as serial code and MPI parallelised code with [Elemental.jl](https://github.com/JuliaParallel/Elemental.jl) matrices.

See `serial/serial.jl` and `distributed/distributed.jl` for indicative usage. Run them via
 - `julia --proj=serial serial/serial.jl`
 - `julia --proj=distributed distributed/distributed.jl`
