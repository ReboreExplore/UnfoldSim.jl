# [![logo_UnfoldSim jl_120px](https://github.com/unfoldtoolbox/UnfoldSim.jl/assets/57703446/139a06c7-55c6-4c2e-8935-627a3c3bf036)](https://github.com/unfoldtoolbox/UnfoldSim.jl/tree/main)


[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://unfoldtoolbox.github.io/UnfoldSim.jl/dev/)
[![Build Status](https://github.com/unfoldtoolbox/UnfoldSim.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/unfoldtoolbox/UnfoldSim.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/v/UnfoldSim.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/unfoldtoolbox/UnfoldSim.jl)
[![DOI](https://zenodo.org/badge/413455526.svg)](https://zenodo.org/badge/latestdoi/413455526)

|rERP|EEG visualisation|EEG Simulations|BIDS pipeline|Decode EEG data|Statistical testing|
|---|---|---|---|---|---|
| <a href="https://github.com/unfoldtoolbox/Unfold.jl/tree/main"><img src="https://github-production-user-asset-6210df.s3.amazonaws.com/10183650/277623787-757575d0-aeb9-4d94-a5f8-832f13dcd2dd.png"></a> | <a href="https://github.com/unfoldtoolbox/UnfoldMakie.jl"><img  src="https://github-production-user-asset-6210df.s3.amazonaws.com/10183650/277623793-37af35a0-c99c-4374-827b-40fc37de7c2b.png"></a>|<a href="https://github.com/unfoldtoolbox/UnfoldSim.jl"><img src="https://github-production-user-asset-6210df.s3.amazonaws.com/10183650/277623795-328a4ccd-8860-4b13-9fb6-64d3df9e2091.png"></a>|<a href="https://github.com/unfoldtoolbox/UnfoldBIDS.jl"><img src="https://github-production-user-asset-6210df.s3.amazonaws.com/10183650/277622460-2956ca20-9c48-4066-9e50-c5d25c50f0d1.png"></a>|<a href="https://github.com/unfoldtoolbox/UnfoldDecode.jl"><img src="https://github-production-user-asset-6210df.s3.amazonaws.com/10183650/277622487-802002c0-a1f2-4236-9123-562684d39dcf.png"></a>|<a href="https://github.com/unfoldtoolbox/UnfoldStats.jl"><img  src="https://github-production-user-asset-6210df.s3.amazonaws.com/10183650/277623799-4c8f2b5a-ea84-4ee3-82f9-01ef05b4f4c6.png"></a>|

A package to simulate single timeseries model-based ERPs, fMRI activity, pupil dilation etc.
If you have one channel, it is a timeseries of (overlapping) event-related activity and some noise - you might have fun here!

Many Tutorials, Guides, How-Tos and References available in the documentation!

![grafik](https://user-images.githubusercontent.com/10183650/213565922-90feec23-3b51-4602-b50c-31561dbfc261.png)

## Install

### Julia
<details>
<summary>Click to expand</summary>

The recommended way to install julia is [juliaup](https://github.com/JuliaLang/juliaup).
It allows you to, e.g., easily update Julia at a later point, but also test out alpha/beta versions etc.

TL:DR; If you dont want to read the explicit instructions, just copy the following command

#### Windows

AppStore -> JuliaUp,  or `winget install julia -s msstore` in CMD

#### Mac & Linux

`curl -fsSL https://install.julialang.org | sh` in any shell
</details>

### Unfold.jl

```julia
using Pkg
Pkg.add("https://github.com/unfoldtoolbox/UnfoldSim.jl/tree/main")
```

Once the toolbox is registered this will translate to ```Pkg.add("UnfoldSim")```


# Quickstart
```julia
data,evts = UnfoldSim.predef_eeg(;n_repeats=1,noiselevel=0.8)
```
Produces continuous "EEG" with PinkNoise and some Overlap between 20 events (2 conditions * 10 levels of continuous variable).

## Slightly longer
```julia
# start by defining the design / event-table
design = SingleSubjectDesign(;conditions=Dict(:condA=>["levelA","levelB"])) |> d->RepeatDesign(d,10);
# next define a ground-truth signal + relation to events/design with Wilkinson Formulas
signal = LinearModelComponent(;
        basis=[0,0,0,0.5,1,1,0.5,0,0],
        formula = @formula(0~1+condA),
        β = [1,0.5]
        );
# finally, define some Onset Distribution and Noise, and simulate!
data,events = simulate(Random.MersenneTwister(1),design, signal,  UniformOnset(;offset=5,width=4), PinkNoise());        
```
All components (design, components, onsets, noise) can be easily modified and you can simply plugin your own!

## Contributions

Contributions are very welcome. These could be typos, bugreports, feature-requests, speed-optimization, new solvers, better code, better documentation.

### How-to Contribute

You are very welcome to raise issues and start pull requests!

### Adding Documentation

1. We recommend to write a Literate.jl document and place it in `docs/literate/FOLDER/FILENAME.jl` with `FOLDER` being `HowTo`, `Explanation`, `Tutorial` or `Reference` ([recommended reading on the 4 categories](https://documentation.divio.com/)).
2. Literate.jl converts the `.jl` file to a `.md` automatically and places it in `docs/src/generated/FOLDER/FILENAME.md`.
3. Edit [make.jl](https://github.com/unfoldtoolbox/Unfold.jl/blob/main/docs/make.jl) with a reference to `docs/src/generated/FOLDER/FILENAME.md`.

## Contributors List (alphabetically)

- **Benedikt Ehinger**
- **Luis Lips**
- **Maanik Marathe**
- **Judith Schepers**

## Contributors
<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->



This project follows the [all-contributors](https://allcontributors.org/docs/en/specification) specification. 

Contributions of any kind welcome!

## Citation

TBA

## Acknowledgements

Funded by Deutsche Forschungsgemeinschaft (DFG, German Research Foundation) under Germany´s Excellence Strategy – EXC 2075 – 390740016
