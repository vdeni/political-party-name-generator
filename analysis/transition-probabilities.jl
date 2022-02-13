using CSV
using DataFrames

names = CSV.read(joinpath("data",
                          "clean",
                          "stranke_imena.txt"),
                 DataFrames.DataFrame;
                 types = Vector)
