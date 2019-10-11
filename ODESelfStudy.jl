using Plots, OrdinaryDiffEq, ParameterizedFunctions

α=1.0;β=2.0;γ=3.0;δ=0.4;

diffeq = @ode_def_all begin
    dx = α*x+β*y
    dy = γ*x+δ*y
end α β γ δ

params = [α β γ δ]'

u0=[3.0; 0.1];
ti=0.0
tf=1.0
Nt=100
tspan=(ti, tf)
t=LinRange(ti,tf,Nt)
alg=Tsit5()

prob=ODEProblem(diffeq, u0, tspan, params)

@time sol = solve(prob, alg=alg, saveat=t)

x=sol[1,:]; y=sol[2,:]
# Comment test to check for changes

gr(size=(1200, 800), grid=true);
plot(x, y)
xlims!(-2.5, 2.5); ylims!(-2., 2,)
