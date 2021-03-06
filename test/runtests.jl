using Gridworld
using Test
using Random

ENVS = [EmptyGridWorld, FourRooms, GoToDoor]
ACTIONS = [TURN_LEFT, TURN_RIGHT, MOVE_FORWARD]

@testset "Gridworld.jl" begin
    for env in ENVS
        @testset "$(env)" begin
            w = env()
            @test typeof(w.agent_pos) == CartesianIndex{2}
            @test typeof(w.agent.dir) <: LRUD
            @test size(w.world.world, 1) == length(w.world.objects)
            @test 1 ≤ w.agent_pos[1] ≤ size(w.world.world, 2)
            @test 1 ≤ w.agent_pos[2] ≤ size(w.world.world, 3)

            for _=1:1000
                w = w(rand(ACTIONS))
                @test 1 ≤ w.agent_pos[1] ≤ size(w.world.world, 2)
                @test 1 ≤ w.agent_pos[2] ≤ size(w.world.world, 3)
                @test w.world[WALL, w.agent_pos] == false
                view = get_agent_view(w)
                @test typeof(view) <: BitArray{3}
                @test size(view,1) == length(w.world.objects)
                @test size(view,2) == 7
                @test size(view,3) == 7
            end
        end
    end
end
