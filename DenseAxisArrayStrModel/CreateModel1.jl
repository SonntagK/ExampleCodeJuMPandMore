using JuMP, CPLEX, JLD

#load Data

dataDict = load("Data.jld")

n = dataDict["n"]
m = dataDict["m"]

str_obj = dataDict["str_obj"]
str_con = dataDict["str_con"]

coeff = dataDict["coeff"]
bound = dataDict["bound"]

# start model build

model = Model()

@variable(model ,0<= x[str_obj]<=1)

@constraint(model, con[name_con in str_con], sum(coeff[name_con,name_obj]*x[name_obj] for name_obj in str_obj) <= bound[name_con])

@objective(model, Max, sum(x[name_obj] for name_obj in str_obj))





# settings for optimization

set_optimizer(model,CPLEX.Optimizer)

JuMP.optimize!(model)

JuMP.write_to_file(model, "Model1.lp")


println("\n Objectie Variabels:")
println(JuMP.value.(x))

println("\n Objective Value:")
objValue = JuMP.objective_value(model)
println(objValue)

