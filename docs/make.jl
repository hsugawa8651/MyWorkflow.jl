using MyWorkflow
using Documenter
using Weave

# Generate markdown with GitHub flavor
weave("docs/src/weavesample.jmd", "github")

makedocs(;
    modules=[MyWorkflow],
    authors="Satoshi Terasaki <hsugawa8651.math@gmail.com>",
    repo="https://github.com/hsugawa8651/MyWorkflow.jl/blob/{commit}{path}#L{line}",
    sitename="MyWorkflow.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://hsugawa8651.github.io/MyWorkflow.jl",
        assets=[asset("assets/theorem.css",islocal=true)],
    ),
    pages=[
        "Home" => "index.md",
        "Example(日本語)" => "example.md",
        "MyWorkflow.jl" => "myworkflow.md",
        "weavesample.md",
    ],
)

deploydocs(;
    repo="github.com/hsugawa8651/MyWorkflow.jl",
)
