using JuMP, CPLEX, JLD

function AddVariable!(model,n)
    @variable(model ,0<= x[str_obj]<=1)
    return model
end

function AddConstraint!(model,n,m,coeff,bound)
    x = model[:x]
    @constraint(model, con[name_con in str_con], sum(coeff[name_con,name_obj]*x[name_obj] for name_obj in str_obj) <= bound[name_con])
    return model
end

function AddObjective!(model)
    x = model[:x]
    @objective(model, Max, sum(x[name_obj] for name_obj in str_obj))
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

JuMP.write_to_file(model, "Model2.lp")


println("\n Objectie Variabels:")
x = model[:x]
println(JuMP.value.(x))

println("\n Objective Value:")
objValue = JuMP.objective_value(model)
println(objValue)

