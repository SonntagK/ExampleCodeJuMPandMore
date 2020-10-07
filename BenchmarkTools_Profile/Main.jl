using JuMP, CPLEX, JLD, BenchmarkTools, Profile, ProfileView

function ModelBuildAndOpt(coeff::JuMP.Containers.DenseAxisArray{Float64,2,Tuple{UnitRange{Int64},UnitRange{Int64}},Tuple{Dict{Int64,Int64},Dict{Int64,Int64}}},
	bound::JuMP.Containers.DenseAxisArray{Float64,1,Tuple{UnitRange{Int64}},Tuple{Dict{Int64,Int64}}}, n::Int64)
	#coeff 				matrix: for defintion of the linear constraints of the form coeff*x .<= bound
	#bound 				array: for definition of constraints (see above)
	#n 					integer: showing problem size
	#directMode 		bool: info for model build
	#optimization		bool: shall the JuMP model be optimized

	m = Model();
	set_optimizer(m, CPLEX.Optimizer)

	@variable(m,0<= x[1:n]<=1, container = DenseAxisArray)
	@constraint(m, con[i = 1:n], sum(coeff[i,j]*x[j] for j in 1:n) <= bound[i], container = DenseAxisArray)
	

	@objective(m, Max, sum(x[j] for j in 1:n))

	JuMP.optimize!(m)
end


dataDict = load("Data.jld")

n = dataDict["n"]
coeff = dataDict["coeff"]
bound = dataDict["bound"]

BenchmarkTools.DEFAULT_PARAMETERS.seconds = 5
BenchmarkTools.DEFAULT_PARAMETERS.samples = 10

#@benchmark ModelBuildAndOpt(coeff,	bound, n)

#Profile.clear()
#@Profile ModelBuildAndOpt(coeff,	bound, n)
#Profile.print()

#@profview ModelBuildAndOpt(coeff,	bound, n)