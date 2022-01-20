using Documenter, Each
Documenter.makedocs(root = "../",
       source = "src",
       build = "build",
       clean = true,
       doctest = true,
       modules = [Each],
       repo = "https://github.com/gustaphe/Each.jl",
       highlightsig = true,
       sitename = "Each.jl",
       expandfirst = [],
       pages = [
               "Each.jl" => "index.md",
               ]
       )
