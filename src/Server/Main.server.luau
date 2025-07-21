local Maze = require(game.ReplicatedStorage.Maze)
local Backtrack = require(game.ReplicatedStorage.Backtrack)

local MainMaze = Maze.new(10, 10, Vector3.new(30, 0, 0), {
    Thickness = 0.1,
    Color3 = Color3.new(0.533333, 0.478431, 0.478431),
    Material = Enum.Material.SmoothPlastic,
    xScale = 15,
    yScale = 15,
    Height = 10,
})
MainMaze:Generate()

Backtrack = Backtrack.new(MainMaze)
Backtrack:Start()