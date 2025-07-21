local Edge = require(game.ReplicatedStorage.Edge)

local Node = {}
Node.__index = Node

function Node.new(x: number, y: number, Parent)
	local self = setmetatable({}, Node)
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
	self.EdgeProprerties = self.Parent.EdgeProperties or {}
	return self
end

function Node:GetNeightbor(x: number, y: number)
	return self.Parent.Nodes[x][y]
end

function Node:Generate()
	if self.y ~= 0 then
		self.Neighbors.Up = {
			x = self.x,
			y = self.y - 1,
		}
	end

	if self.y ~= self.Parent.Length then
		self.Neighbors.Down = {
			x = self.x,
			y = self.y + 1,
		}
	end

	if self.x ~= 0 then
		self.Neighbors.Left = {
			x = self.x - 1,
			y = self.y,
		}
	end

	if self.x ~= self.Parent.Width then
		self.Neighbors.Right = {
			x = self.x + 1,
			y = self.y,
		}
	end

	if self.x == 0 and self.y ~= self.Parent.Length then
		self.Edges.Left = Edge.new(
		{x = 0, y = self.y},
		{x = 0, y = self.y + 1},
			self,
			self.EdgeProprerties
		)

		self.Edges.Right = Edge.new(
			{x = 1, y = self.y},
			{x = 1, y = self.y + 1},
			self,
			self.EdgeProprerties
		)

		self.Edges.Left:Generate()
		self.Edges.Right:Generate()
	elseif self.x > 1 and self.x < self.Parent.Width and self.y < self.Parent.Length then
		self.Edges.Right = Edge.new(
			{x = self.x, y = self.y},
			{x = self.Neighbors.Down.x, y = self.Neighbors.Down.y},
			self,
			self.EdgeProprerties
		)

		self.Edges.Right:Generate()
	elseif self.x == self.Parent.Width and self.y < self.Parent.Length then
		self.Edges.Right = Edge.new(
			{x = self.x, y = self.y},
			{x = self.x, y = self.y + 1},
			self,
			self.EdgeProprerties
		)
		self.Edges.Right:Generate()
	end


	if self.y == 0 and self.x < self.Parent.Width then
		self.Edges.Top = Edge.new(
		{x = self.x, y = 0},
		{x = self.x + 1, y = 0},
			self,
			self.EdgeProprerties
		)

		self.Edges.Bottom = Edge.new(
			{x = self.x, y = 1},
			{x = self.x + 1, y = 1},
			self,
			self.EdgeProprerties
		)

		self.Edges.Top:Generate() 
		self.Edges.Bottom:Generate()

	elseif self.y > 1 and self.y < self.Parent.Length and self.x < self.Parent.Width then
		self.Edges.Bottom = Edge.new(
			{x = self.x, y = self.y},
			{x = self.x + 1, y = self.y},
			self,
			self.EdgeProprerties
		)

		self.Edges.Bottom:Generate()
	elseif self.y == self.Parent.Length and self.x < self.Parent.Width then
		self.Edges.Bottom = Edge.new(
			{x = self.x, y = self.y},
			{x = self.x + 1, y = self.y},
			self,
			self.EdgeProprerties
		)

		self.Edges.Bottom:Generate()
	end
end

return Node
