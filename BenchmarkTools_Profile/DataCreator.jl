using JuMP, JLD

n = 100

A = rand(n,n)
b = rand(n)+ones(n)

coeff = JuMP.Containers.DenseAxisArray(A,1:n,1:n)
bound = JuMP.Containers.DenseAxisArray(b,1:n)

save("Data.jld", "n", n, "coeff", coeff, "bound", bound)