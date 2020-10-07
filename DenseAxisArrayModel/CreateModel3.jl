using JuMP, CPLEX, JLD

#load Data

dataDict = load("Data.jld")

n = dataDict["n"]
m = dataDict["m"]



coeff = dataDict["coeff"]
bound = dataDict["bound"]

# start model build

model = Model()

@variable(model,0<= x[1:n], container = DenseAxisArray)
#@variable(m, x[1:n], lower_bound = 0, container = DenseAxisArray)
@constraint(model, con[i = 1:m], sum(coeff[i,j]*x[j] for j in 1:n) <= bound[i], container = DenseAxisArray)

@objective(model, Max, sum(x))

# settings for optimization

set_optimizer(model,CPLEX.Optimizer)

JuMP.optimize!(model)

JuMP.write_to_file(model, "Model3.lp")


println("\n Objectie Variabels:")
println(JuMP.value.(x))

println("\n Objective Value:")
objValue = JuMP.objective_value(model)
println(objValue)

