using Crayons

function Base.show(io::IO, gw::AbstractGridWorld)
    p, d = get_agent_pos(gw), get_agent_dir(gw)
    w = convert(GridWorldBase, gw)

    println(io, "World:")
    for i in 1:size(w, 2)
        for j in 1:size(w, 3)
            if CartesianIndex(i, j) ∈ get_agent_view_inds(gw)
                bg = :dark_gray
            else
                bg = :black
            end
            if i == p[1] && j == p[2]
                agent = get_agent(gw)
                print(io, Crayon(background=bg, foreground=get_color(agent),reset=true), convert(Char, agent))
            else
                o = get_object(gw)[findfirst(w.world[:, i, j])]
                print(io, Crayon(background=bg, foreground=get_color(o),reset=true),  convert(Char, o))
            end
        end
        println(io, Crayon(reset=true))
    end
    println(io)

    println(io, "Agent's view:")
    v = get_agent_view(gw)
    for i in 1:size(v, 2)
        for j in 1:size(v, 3)
            if i == 1 && j == size(v, 3) ÷ 2 + 1
                print(io, Agent(dir=DOWN))
            else
                x = findfirst(v[:, i, j])
                if isnothing(x)
                    print(io, '_')
                else
                    print(io, get_object(gw)[x])
                end
            end
        end
        println(io)
    end
    println(io)
end