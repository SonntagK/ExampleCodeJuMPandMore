using JuMP, JLD, Random


"""
    Creates two Array{String,1} one with length n and on ewith length m
    Each string has length 20 
"""  
function createArrayString(n::Int64, m::Int64)
    str_obj = Array{String,1}(undef,n)
    str_con = Array{String,1}(undef,m)

    #string have a length of 20 and are numbered
    for p in 1:n
		str_obj[p] = string("obj_", randstring(15-length(string(p))), "_", string(p))
    end

    for p in 1:m
		str_con[p] = string("con_", randstring(15-length(string(p))), "_", string(p))
    end
	
    return str_obj, str_con
end


n = 10
m = 5

A = rand(m,n)
b = rand(m)+ones(m)

str_obj, str_con = createArrayString(n,m)

coeff = JuMP.Containers.DenseAxisArray(A,str_con,str_obj)
bound = JuMP.Containers.DenseAxisArray(b,str_con)

save("Data.jld", "n", n, "m", m, "coeff", coeff, "bound", bound, "str_obj", str_obj, "str_con" ,str_con)