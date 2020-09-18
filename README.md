# MyWorkflow

[![Build Status](https://github.com/hsugawa8651/MyWorkflow.jl/workflows/CI/badge.svg)](https://github.com/hsugawa8651/MyWorkflow.jl/actions)
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://hsugawa8651.github.io/MyWorkflow.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://hsugawa8651.github.io/MyWorkflow.jl/dev)

- An example of workflow using Docker and GitHub Actions

# Have a try MyWorkflow.jl

- MyWorkflow.jl master (nightly) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/hsugawa8651/MyWorkflow.jl/master) Julia v1.5.1

- MyWorkflow.jl v0.17.0 (stable) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/hsugawa8651/MyWorkflow.jl/v0.17.0) Julia v1.5.1

- MyWorkflow.jl v0.15.0 (legacy) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/hsugawa8651/MyWorkflow.jl/v0.15.0) Julia v1.4.2


# Feature

- This repository gives us some useful techniques such as:
  1. how to utilize Docker Docker Compose with your Julia workflow.
  2. how to customize Julia's system image via PackageCompiler.jl to reduce an overhead of package's loading time e.g. Plots.jl, PyCall.jl, or DataFrames.jl etc...
  3. how to share our work on the Internet. Check our repository on Binder from [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/hsugawa8651/MyWorkflow.jl/master)
  4. how to use GitHub actions as a CI functionality.
  5. how to communicate between a Docker container and Juno/Atom

# Directory Structure

```console
$ tree .
.
├── Dockerfile
├── LICENSE
├── Makefile
├── Project.toml
├── README.md
├── binder
│   └── Dockerfile
├── docker-compose.yml
├── docs
│   ├── Manifest.toml
│   ├── Project.toml
│   ├── make.jl
│   └── src
│       ├── assets
│       │   ├── lab.png
│       │   ├── open_notebook_on_jupyterlab.png
│       │   ├── port9999.png
│       │   └── theorem.css
│       ├── example.md
│       ├── index.md
│       ├── math.md
│       ├── myworkflow.md
│       └── weavesample.jmd
├── experiments
│   └── notebook
│       ├── Chisq.jl
│       ├── Harris.jl
│       ├── Rotation3D.jl
│       ├── apply_PCA_to_MNIST.jl
│       ├── box_and_ball_system.jl
│       ├── coordinate_system.jl
│       ├── curve.jl
│       ├── example.jl
│       ├── fitting.jl
│       ├── gradient_descent.jl
│       ├── histogram_eq.jl
│       ├── hop_step_jump.jl
│       ├── image_filtering.jl
│       ├── interact_sample.jl
│       ├── iris.jl
│       ├── lazysets.jl
│       ├── linear_regression.jl
│       ├── n-Soliton.jl
│       ├── ode.jl
│       ├── plotly_surface.jl
│       ├── plots_sample.jl
│       ├── pyplot.jl
│       ├── seaborn.jl
│       ├── tangent_space.jl
│       └── tangent_vector.jl
├── gitpod
│   └── Dockerfile
├── requirements.txt
├── src
│   └── MyWorkflow.jl
└── test
    └── runtests.jl
```

# How to use

## Prepare Environment

- Install Docker and Docker Compose. see the following link to learn more with your operating system:
  - [Install Docker Desktop on Windows](https://docs.docker.com/docker-for-windows/install/)
  - [Install Docker Desktop on Mac](https://docs.docker.com/docker-for-mac/install/)
  - [Get Docker Engine - Community for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

- To test out you've installed docker, just try:

```
$ docker run --rm -it julia
# some staff happens ...
```

- It will initialize the fresh Julia environment even if you do not have a Julia on your (host) machine.

## Buiding Docker image

- O.K. Let's build a Docker image for our purpose. Just run:

```
$ make build
```

which is exactly equivalent to the following procedure:

```
$ rm -f Manifest.toml
$ docker build -t myworkflojl .
$ docker-compose build
$ docker-compose run --rm julia julia --project=/work -e 'using Pkg; Pkg.instantiate()'
```

## Running Jupyter Notebook/JupyterLab

```console
$ docker-compose up jupyter
myjupyter  |     To access the notebook, open this file in a browser:
myjupyter  |         file:///root/.local/share/jupyter/runtime/nbserver-1-open.html
myjupyter  |     Or copy and paste one of these URLs:
myjupyter  |         http://4a27c4a06b0f:8888/?token=xxxxxxxxxxxxxxxxxxxxxxx
myjupyter  |      or http://127.0.0.1:8888/?token=xxxxxxxxxxxxxxxxxxxxxxx
```

Then open your web browser and access to `http://127.0.0.1:8888/?token=xxxxxxxxxxxxxxxxxxxxxxx`.

You can also initialize JupyterLab as you like via

```console
$ docker-compose up lab
```

- You'll see a JupyterLab screen its theme is Monokai++ (This choice comes from my preference.) :D .

![img](docs/src/assets/lab.png)

- If you like to open `experiments/notebook/<ournotebook>.jl`, right click the file to select and `Open with` -> `Notebook`. You're good to go.

 ![img](docs/src/assets/open_notebook_on_jupyterlab.png)

- Note that since we adopt `jupytext` technology, we do not have to commit/push `*.ipynb` file. Namely, we can manage Jupyter Notebook as a normal source code.

- Enjoy your Jupyter life.

## Running Pluto

[Pluto.jl](https://github.com/fonsp/Pluto.jl) is a lightweight reactive notebooks for Julia. Just run the following command:

```console
$ docker-compose up pluto
```

Then, go to `localhost:9999`

## Connect to docker container with Juno/Atom (For Linux or Mac users only)

- We we will assume you've installed Juno.
- Go to `Open Settings` -> `Julia Client` -> `Julia Options` -> `Port for Communicating with the Julia process` and set value from `random` to `9999`.

![imgs](docs/src/assets/port9999.png)

- To connect to Docker container, open your Atom editor and open command palette(via `Cmd+shift+p` or `Ctrl+shift+p`). Then select `Julia Client Connect External Process`. Finally again open command palette and select `Julia Client: New Terminal`. You'll see a terminal at the bottom of the Atom edetor's screen. After that, simply run `make atom` or


```console
# For Mac user
$  docker run --rm -it --network=host -v ${PWD}:/work -w /work myworkflowjl julia -J/sysimages/atom.so --project=@. -L .atom/init_mac.jl
```

```console
# For Linux user
$ docker run --rm -it --network=host -v ${PWD}:/work -w /work myworkflowjl julia -J/sysimages/atom.so --project=@. -L .atom/init_linux.jl
```

It will show Julia's REPL inside of the terminal. `pwd()` should output `"/work"`, otherwise (e.g. `~/work/MyWorkflow.jl`)  you're something wrong (opening your Julia session on your host).

```console
julia> pwd()
"/work"
```

- Since our Docker image adopts `sysimage` which include precompile statements related to `Atom` or `Plots.jl` generated by `PackageCompiler.jl`. You'll find the speed of `using Plots; plot(sin)` is much extremely faster than that of runs on Julia session on your host.

```
# our sysimage
julia> @time begin using Plots; plot(sin) end
  0.022140 seconds (38.23 k allocations: 1.731 MiB) # <- Fast
```

```
# normal Julia
julia> @time begin using Plots; plot(sin) end
 14.006315 seconds (42.16 M allocations: 2.131 GiB, 3.86% gc time) #<- So slow ...
```


- You can reproduce the `sysimage` by yourself to reduce the latency of loading time of heavy packages. See This issue https://github.com/JuliaLang/PackageCompiler.jl/issues/352.
