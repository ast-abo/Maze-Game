local Node = require(game.ReplicatedStorage.Node)

local Maze = {}
Maze.__index = Maze

function Maze.new(Length: number, Width: number, Origin: Vector3)
	local self = {}
	self.x = Width
	self.y = Length
	self.Origin = Origin or Vector3.new(0, 4, 0) -- Default origin if not provided
	self.Nodes = {} -- This will hold the nodes of the maze
	self.StartNode = nil -- This will be the starting node of the maze
	self.Neighbors = {}
	return setmetatable(self, Maze)
end

function Maze:GenerateGrid()
	for x = 1, self.x, 1 do
		for y = 1, self.y, 1 do
			self.Nodes[x] = self.Nodes[x] or {}
			self.Nodes[x][y] = Node.new(x, y, self):Generate()
		end
	end
end

function Maze:SetStartNode(Node)
	self.StartNode = Node
end

return Maze
