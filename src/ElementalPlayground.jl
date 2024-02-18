module ElementalPlayground

using LinearAlgebra

localindices(x::AbstractArray{T, 2}) where T  = (1:size(x, 1), 1:size(x, 2))
localindices(x::AbstractArray{T, 1}) where T  = (1:length(x),)

"""
    qux!(b,rowthings,bvalues)

Fill b in a serial or distributed way.
Importantly, the last argument is used here to ensure that b is
 filled with the same values as in the serial version of the code.
In other applications, the values of xibA can just calculated from rowthings.


...
# Arguments
- `b`: Vector to fill with values
- `rowthings`: collection the same length as b
- `bvalues`: collection of values to fill b with, which in other applications
would be calculated via rowthings and business logic.
...

# Example
```julia
```
"""
function qux!(b, rowthings, bvalues)
    li = localindices(b)
    values = bvalues[li...]
    b[li...] = values
end

"""
    bar!(A,rowthings,colthings,Avalues)

Fill A in a serial or distributed way.
Importantly, the last argument is used here to ensure that A is
 filled with the same values as in the serial version of the code.
In other applications, the values of A can just calculated from rowthings and colthings.

...
# Arguments
- `A`: The matrix to fill
- `rowthings`: vector of items for the rows
- `colthings`: vector of items for the cols
- `Avalues`: collection of values to fill A with, which in other applications
would be calculated via rowthingss and business logic.

# Example
```julia
```
"""
function bar!(A, rowthings, colthings, Avalues)
  li, lj = localindices(A)
  for (i, row) in enumerate(rowthings[li])
    for (j, col) in enumerate(colthings[lj])
      v = Avalues[row, col]
      A[row:row, col:col] = v:v # note that setindex requires collections not scalars
    end
  end
end

"""
    baz!(A,b)

Do some linear algebra either in serial or distributed.

...
# Arguments
- `A`: lhs matrix
- `b`: rhs vector
...

# Example
```julia
```
"""
function baz!(A, b)
  qrA = qr!(A)
  x = qrA \ b
end

end # module ElementalPlayground
