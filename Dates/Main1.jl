using Dates

t = DateTime(2020)

println(t)
println(typeof(t))

t = Date(2020)

println(t)
println(typeof(t))

dt1 = Date(2020,2,29)

dt2 = Date(2020,3,10)

println(dt2-dt1)

typeof(dt1-dt2)

dt1 + Day(10)

