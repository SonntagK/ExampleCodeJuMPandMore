using JuMP, CPLEX

function arrayModel(coeff::Array{Float64,2}, bound::Array{Float64,1}, n::Int64, directMode::Bool, optimization::Bool)
	#coeff 				matrix: for defintion of the linear constraints of the form coeff*x .<= bound
	#bound 				array: for definition of constraints (see above)
	#n 					integer: showing problem size
	#directMode 		bool: info for model build
	#optimization		bool: shall the JuMP model be optimized



	if directMode == false
		m = Model();
		set_optimizer(m, CPLEX.Optimizer)	
	else
		m = direct_model(CPLEX.Optimizer());
	end

	@variable(m,0<= x[1:n]<=1)
	@constraint(m, con[i = 1:n], sum(coeff[i,:].*x) <= bound[i] )
	
	@objective(m, Max, sum(x))
		
	if optimization == true
		JuMP.optimize!(m)
	end
	
	return(m)

end


n = 20
A = rand(n,n)
b = rand(n)

arrayModel(A, b, n, true, true)