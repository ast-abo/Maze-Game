local Node = require(game.ReplicatedStorage.Node)
local Backtrack = require(game.ReplicatedStorage.Backtrack)

local Maze = {}
Maze.__index = Maze

function Maze.new(Length: number, Width: number, BacktrackSpeed: number, GenerateSpeed: number, Origin: Vector3, EdgeProperties)
	local self = setmetatable({}, Maze)
	self.Width = Width
	self.Length = Length
	self.EdgeProperties = EdgeProperties or {}
	self.Origin = Origin or Vector3.new(30, 3, 0)
	self.Nodes = {}
	self.StartNode = {
		x = 0,
		y = 0,
	}
	self.GenerateSpeed = GenerateSpeed or 1
	self.BacktrackSpeed = BacktrackSpeed or 1
	self.Backtrack = Backtrack.new(self)
	return self
end

function Maze:Generate()
	for x = 0, self.Width - 1, 1 do
		for y = 0, self.Length - 1, 1 do
			self.Nodes[x] = self.Nodes[x] or {}
			self.Nodes[x][y] = Node.new(x, y, self)
			self.Nodes[x][y]:Generate()
		end
	end
end

function Maze:SetStartNode(Node)
	self.StartNode = Node
end

function Maze:GetNode(x, y)
	if self.Nodes[x] and self.Nodes[x][y] then
		return self.Nodes[x][y]
	else
		return nil
	end
end

function Maze:StartBacktrack()
	self.Backtrack:Start()
end

return Maze
