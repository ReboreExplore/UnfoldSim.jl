using UnfoldSim
using Documenter

GENERATED = joinpath(@__DIR__, "src", "literate")
for subfolder ∈ ["explanations","HowTo","tutorials","reference"]
    local SOURCE_FILES = Glob.glob(subfolder*"/*.jl", GENERATED)
    foreach(fn -> Literate.markdown(fn, GENERATED*"/"*subfolder), SOURCE_FILES)

end


DocMeta.setdocmeta!(UnfoldSim, :DocTestSetup, :(using UnfoldSim); recursive=true)

makedocs(;
    modules=[UnfoldSim],
authors="Luis Lips, Benedikt Ehinger, Judith Schepers",
    repo="https://github.com/behinger/UnfoldSim.jl/blob/{commit}{path}#{line}",
    sitename="UnfoldSim.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://unfoldtoolbox.github.io/UnfoldSim.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "NoiseTypes" => "literate/reference/noisetypes.md"
    ],
)

deploydocs(;
    repo="github.com/unfoldtoolbox/UnfoldSim.jl",
    devbranch="main",
)
