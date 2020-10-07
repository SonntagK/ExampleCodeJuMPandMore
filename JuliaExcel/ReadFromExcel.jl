using XLSX

xf = XLSX.readxlsx("example_file.xlsb.xlsx")

sheet = xf[2]

X = Array{Float64,2}(sheet["C12:J14"])