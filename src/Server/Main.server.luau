local MazeMaker = require(game.ReplicatedStorage.Maze)

-- SO many ZEROS :Sob:
local Maze = MazeMaker.new(20, 20, 0.000000000000001, 0.000000000000001, Vector3.new(-50, 0, -150), {
    Thickness = 0.5,
    Color3 = Color3.new(0.533333, 0.478431, 0.478431),
    Material = Enum.Material.SmoothPlastic,
    xScale = 15,
    yScale = 15,
    Height = 20,
})

task.wait(10)

Maze:Generate()
Maze:StartBacktrack()

for _, Part in workspace.Model:GetChildren() do
    if Part.Name ~= "SpawnLocation" then
        Part:Destroy()
    end
end

workspace.Model.SpawnLocation.CanCollide = false
