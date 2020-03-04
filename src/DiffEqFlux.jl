module DiffEqFlux

using DiffEqBase, Tracker, DiffResults, DiffEqSensitivity, ForwardDiff,
      Flux, Requires, Adapt, LinearAlgebra, RecursiveArrayTools, Juno, Optim,
      StaticArrays, Base.Iterators

import ZygoteRules, ReverseDiff, NLopt

gpu_or_cpu(x) = Array

function diffeq_fd(p,f,n,prob,solver=nothing,args...;u0=prob.u0,kwargs...)
  @warn("diffeq_fd has been deprecated in the update of DiffEqFlux to Zygote support. Use the concrete_solve function with sensealg=ForwardDiffSensitivity() to recover the same functionality. See https://docs.juliadiffeq.org/latest/analysis/sensitivity/ for more details")
  f(concrete_solve(prob,solver,u0,p,args...;kwargs...))
end

function diffeq_rd(p,prob,solver=nothing,args...;u0=prob.u0,kwargs...)
  @warn("diffeq_rd has been deprecated in the update of DiffEqFlux to Zygote support. Use the concrete_solve function with sensealg=TrackerAdjoint() to recover the same functionality. See https://docs.juliadiffeq.org/latest/analysis/sensitivity/ for more details")
  concrete_solve(prob,solver,u0,p,args...;kwargs...)
end

function diffeq_adjoint(p,prob,solver=nothing,args...;u0=prob.u0,kwargs...)
  @warn("diffeq_adjoint has been deprecated in the update of DiffEqFlux to Zygote support. Use the concrete_solve function to recover the same functionality. See https://docs.juliadiffeq.org/latest/analysis/sensitivity/ for more details")
  concrete_solve(prob,solver,u0,p,args...;kwargs...)
end

function neural_ode(args...;kwargs...)
  @error("neural_ode has be removed and replaced by NeuralODE. Please consult the README for more details.")
end

function neural_ode_rd(args...;kwargs...)
  @error("neural_ode_rd has be removed and replaced by NeuralODE. Please consult the README for more details.")
end

function neural_dmsde(args...;kwargs...)
  @error("neural_dmsde has be removed and replaced by NeuralDMSDE. Please consult the README for more details.")
end

function neural_dmsde(model,x,mp,tspan,
                      args...;kwargs...)
    error("neural_dmsde has been deprecated with the change to Zygote. Please see the documentation on the new NeuralDSDE layer.")
end

function neural_ode_rd(model,x,tspan,
                       args...;
                       kwargs...)
    error("neural_ode_rd has been deprecated with the change to Zygote. Please see the documentation on the new NeuralODE layer.")
end

function neural_ode(model,x,tspan,args...;kwargs...)
    error("neural_ode has been deprecated with the change to Zygote. Please see the documentation on the new NeuralODE layer.")
end

Flux.Zygote.grad_mut(d::IdDict) = IdDict()

include("train.jl")
include("fast_layers.jl")
include("neural_de.jl")
include("require.jl")

__init__()

export diffeq_fd, diffeq_rd, diffeq_adjoint
export NeuralODE, NeuralDSDE, NeuralSDE, NeuralCDDE, NeuralDAE, NeuralODEMM
export neural_ode, neural_ode_rd
export neural_dmsde
export FastDense, StaticDense, FastChain, initial_params
end
