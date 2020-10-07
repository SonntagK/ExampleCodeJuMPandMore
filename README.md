# ExampleCodeJuMPandMore
Just example code to share regarding: Julia,JuMP,DenseAxisArrays,Dates

# ArrayModel

Example for a simple JuMP model using arrays for objective variabels and coefficients.

# BenchmarkTools_Profile

The Data.jld and DataCreator.jl is not important for this example and just helps generating data for the example in the Main.jl. Here the model build is wrapped in a function. At the end of the file there are some comments you can try in the REPL using BenchmarkTools.jl, Profile.jl and ProfileView.jl.

# DenseAxisArrayModel

In the DataCreator.jl you can find how to convert an Array to a DenseAxisArray and how to save the data using JLD.jl to Data.jl. 
In CreateModel1.jl is a simple example how to create JuMP model using DenseAxisArrays for coefficients, objective variables and constraints. Everything here is indexed by numbers 1:n. Additionally you find in the end some useful JuMP functions, namely how to save a JuMP model to a .lp file, how to get the optimal objective variables and the objective value.
In CreateModel2.jl you have the same code but here adding variabels, adding constraints and adding the objective is handled in seperate functions.

# DenseAxisArrayStrModel

Same as DenseAxisArrayModel but here everything is indexed by strings of length 20.

# JuliaExcel

Just one example how to read from an excel file in julia using XLSX.jl.

# PkgTemplates

Contains a very small example how to generate a Package using PkgTemplates.jl.