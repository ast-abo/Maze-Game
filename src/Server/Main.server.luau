local Maze = require(game.ReplicatedStorage.Maze)

local MainMaze = Maze.new(10, 10, Vector3.new(0, 4, 0))
MainMaze:GenerateGrid()

print(MainMaze)