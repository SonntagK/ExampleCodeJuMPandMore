using Dates, JuMP

loc= ["Wien", "Graz", "Linz"]

dt = Array{DateTime,1}(undef,24)
for i = 0:23
    dt[i+1] = DateTime(2020,10,5,i)
end

A = rand(24,3)

A_ = JuMP.Containers.DenseAxisArray(A,dt,loc)
