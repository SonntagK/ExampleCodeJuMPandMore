using JuMP, CPLEX, JLD, NamedDims

#load Data

dataDict = load("Data.jld")

n = dataDict["n"]
m = dataDict["m"]



coeff = dataDict["coeff"]
bound = dataDict["bound"]

# start model build

model = Model()

x = NamedDimsArray{(:x2,)}(@variable(model, 0 <= x[1:n] <= 1))

con = NamedDimsArray{(:x1,)}(@constraint(model, con[i = 1:m], sum(coeff[x1 = i ,x2 = j]*x[j] for j in 1:n) <= bound[i] ))


@objective(model, Max, sum(x[j] for j in 1:n))

# settings for optimization

set_optimizer(model,CPLEX.Optimizer)

JuMP.optimize!(model)


println("\n Objectie Variabels:")
println(JuMP.value.(x))

println("\n Objective Value:")
objValue = JuMP.objective_value(model)
println(objValue)

