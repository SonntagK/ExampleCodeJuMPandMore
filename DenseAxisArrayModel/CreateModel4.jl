using JuMP, CPLEX, JLD

function AddVariable!(model,n)
    @variable(model,0<= x[1:n], container = DenseAxisArray)
    return model
end

function AddConstraint!(model,n,m,coeff,bound)
    x = model[:x]
    @constraint(model, con[i = 1:m], sum(coeff[i,j]*x[j] for j in 1:n) <= bound[i], container = DenseAxisArray)
    return model
end

function AddObjective!(model)
    x = model[:x]
    @objective(model, Max, sum(x))
    return model
end

#load Data

dataDict = load("Data.jld")

n = dataDict["n"]
m = dataDict["m"]



coeff = dataDict["coeff"]
bound = dataDict["bound"]

# start model build

model = Model()

model = AddVariable!(model,n)

model = AddConstraint!(model,n,m,coeff,bound)

model = AddObjective!(model)


# settings for optimization

set_optimizer(model,CPLEX.Optimizer)

JuMP.optimize!(model)

JuMP.write_to_file(model, "Model4.lp")


println("\n Objectie Variabels:")
x = model[:x]
println(JuMP.value.(x))

println("\n Objective Value:")
objValue = JuMP.objective_value(model)
println(objValue)

