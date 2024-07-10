using CairoMakie
using Distributions

d = Normal(0, 0.5)

# That's a normal distribution.
# This is testing out comment-based text.

fig = Figure()

for i in 1:4
    ax = Axis(fig[
        ceil(Int, i / 2), # 1,1,2,2
        2 - i % 2]; # 1,2,1,2
        xlabel = "10^$i samples"
    )

    lines!(ax, (d))
    hist!(ax, rand(d, 10^i); normalization=:pdf)
end

fig
