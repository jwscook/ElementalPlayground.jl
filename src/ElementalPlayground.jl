module ElementalPlayground

using LinearAlgebra

localindices(x::AbstractArray{T, 2}) where T  = (1:size(x, 1), 1:size(x, 2))
localindices(x::AbstractArray{T, 1}) where T  = (1:length(x),)

function qux!(b, rowthings, bvalues)
    li = localindices(b)
    values = bvalues[li...]
    b[li...] = values
end
function bar!(A, rowthing, colthing, Avalues)
  li, lj = localindices(A)
  for (i, row) in enumerate(rowthing[li])
    for (j, col) in enumerate(colthing[lj])
      v = Avalues[row, col]
      A[row:row, col:col] = v:v
    end
  end
end
function baz!(A, b)
  qrA = qr!(A)
  x = qrA \ b
end

function wozzle(A, b, rowthing, colthing)
  b .= sin.(rowthing)
  for (i, row) in enumerate(rowthing)
    for (j, col) in enumerate(colthing)
      v = eltype(A)(row * col)
      A[i, j] = v
    end
  end
  return A \ b
end

end # module ElementalPlayground
