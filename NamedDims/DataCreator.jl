using JuMP, JLD, NamedDims

n = 10
m = 5

A = rand(m,n)
b = rand(m)+ones(m)

coeff = NamedDimsArray{(:x1,:x2)}(A)
bound = NamedDimsArray{(:x3,)}(b)


save("Data.jld", "n", n, "m", m, "coeff", coeff, "bound", bound)