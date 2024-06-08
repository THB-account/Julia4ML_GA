using Julia4ML_GA
using Documenter

DocMeta.setdocmeta!(Julia4ML_GA, :DocTestSetup, :(using Julia4ML_GA); recursive=true)

makedocs(;
    modules=[Julia4ML_GA],
    authors="Jonas Engler <jonas.engler@campus.tu-berlin.de>",
    sitename="Julia4ML_GA.jl",
    format=Documenter.HTML(;
        canonical="https://THB-account.github.io/Julia4ML_GA.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Example Usage" => "example.md",
    ],
)

deploydocs(;
    repo="github.com/THB-account/Julia4ML_GA.jl"
)
