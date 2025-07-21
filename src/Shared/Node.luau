local Edge = require(game.ReplicatedStorage.Edge)

local Node = {}
Node.__index = Node

function Node.new(x: number, y: number, Parent)
	local self = {}
	self.x = x
	self.y = y
	self.Parent = Parent
	self.Visited = false
	self.Neighbors = {
		Up = nil,
		Down = nil,
		Left = nil,
		Right = nil
	}
	self.Edges = {
		Up = nil,
		Down = nil,
		Left = nil,
		Right = nil
	}
	return setmetatable(self, Node)
end

function Node:GetNeightbor(x: number, y: number)
	return self.Parent.Nodes[x][y]
end

function Node:Generate()

	-- Set Neighbor Coordinates
	if self.y ~= 1 then
		self.Neighbors.Up = {
			x = self.x,
			y = self.y - 1,
		}
	end

	if self.y ~= self.Parent.y then
		self.Neighbors.Down = {
			x = self.x,
			y = self.y + 1,
		}
	end

	if self.x ~= 1 then
		self.Neighbors.Left = {
			x = self.x - 1,
			y = self.y,
		}
	end

	if self.x ~= self.Parent.x then
		self.Neighbors.Right = {
			x = self.x + 1,
			y = self.y,
		}
	end
	-- Determining with Edges to create

	if self.x == 1 then
		self.Edges.Left = Edge.new({
			x = self.x,
			y = self.y
		}, nil)

		self.Edges.Right = Edge.new({
			x = self.x,
			y = self.y
		}, self.Neighbors.Right)
		-- create left Edge and right Edge
	else
		self.Edges.Right = Edge.new({
			x = self.x,
			y = self.y
		}, self.Neighbors.Right)
	end

	if self.y == 1 then
		-- create upper Edge and lower Edge
	else
		-- create lower Edge
	end

	if self.x == self.Parent.x then

	end

end

return Node
