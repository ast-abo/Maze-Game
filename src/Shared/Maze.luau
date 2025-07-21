local Node = require(game.ReplicatedStorage.Node)

local Maze = {}
Maze.__index = Maze

function Maze.new(Length: number, Width: number, Origin: Vector3, EdgeProperties)
	local self = setmetatable({}, Maze)
	self.Width = Width -- Adjusting for zero-based indexing
	self.Length = Length
	self.EdgeProperties = EdgeProperties or {}
	self.Origin = Origin or Vector3.new(30, 3, 0) -- Default origin if not provided
	self.Nodes = {} -- This will hold the nodes of the maze
	--self.StartNode = nil -- This will be the starting node of the maze
	self.Neighbors = {}
	return self
end

function Maze:Generate()
	for x = 0, self.Width, 1 do
		for y = 0, self.Length, 1 do
			self.Nodes[x] = self.Nodes[x] or {}
			self.Nodes[x][y] = Node.new(x, y, self)
			self.Nodes[x][y]:Generate()
			--task.wait(1) -- Yield to allow rendering
		end
	end
end

function Maze:SetStartNode(Node)
	self.StartNode = Node
end

return Maze
