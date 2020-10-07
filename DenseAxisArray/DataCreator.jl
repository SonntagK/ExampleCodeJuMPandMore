using JuMP, JLD

n = 10
m = 5

A = rand(m,n)
b = rand(m)+ones(m)

coeff = JuMP.Containers.DenseAxisArray(A,1:m,1:n)
bound = JuMP.Containers.DenseAxisArray(b,1:m)

save("Data.jld", "n", n, "m", m, "coeff", coeff, "bound", bound)