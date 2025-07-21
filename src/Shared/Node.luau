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
		Right = nil,
	}
	self.Edges = {
		Up = nil,
		Down = nil,
		Left = nil,
		Right = nil,
	}
	self.EdgeProperties = self.Parent.EdgeProperties or {}
	return self
end

function Node:Visit(PreviousNode, NextNode)
	self.Visited = true

	if not PreviousNode then
		return
	end

	if PreviousNode.x < self.x then
		self.Edges.Left.Instance:Destroy()
	end

	if PreviousNode.x > self.x then
	 	self.Edges.Right.Instance:Destroy()
	end

	if PreviousNode.y < self.y then
		self.Edges.Top.Instance:Destroy()
	end

	if PreviousNode.y > self.y then
		self.Edges.Bottom.Instance:Destroy()
	end
end

function Node:Generate()
	if self.y ~= 0 then
		self.Neighbors.Up = {
			x = self.x,
			y = self.y - 1,
		}
	end

	if self.y ~= self.Parent.Length - 1 then
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

	if self.x ~= self.Parent.Width - 1 then
		self.Neighbors.Right = {
			x = self.x + 1,
			y = self.y,
		}
	end

	if self.x == 0 and self.y == 0 then
		self.Edges.Left = Edge.new({ x = 0, y = 0 }, { x = 0, y = 1 }, self)
		self.Edges.Right = Edge.new({ x = 1, y = 0 }, { x = 1, y = 1 }, self)
		self.Edges.Bottom = Edge.new({ x = 0, y = 1 }, { x = 1, y = 1 }, self)
		self.Edges.Top = Edge.new({ x = 0, y = 0 }, { x = 1, y = 0 }, self)

		self.Edges.Left:Generate()
		self.Edges.Right:Generate()
		self.Edges.Bottom:Generate()
		self.Edges.Top:Generate()
	elseif self.x > 0 and self.y == 0 then
		self.Edges.Left = self.Parent.Nodes[self.x - 1][self.y].Edges.Right
		self.Edges.Right = Edge.new({ x = self.x + 1, y = self.y }, { x = self.x + 1, y = self.y + 1 }, self)
		self.Edges.Top = Edge.new({ x = self.x, y = self.y }, { x = self.x + 1, y = self.y }, self)
		self.Edges.Bottom = Edge.new({ x = self.x, y = self.y + 1 }, { x = self.x + 1, y = self.y + 1 }, self)

		self.Edges.Right:Generate()
		self.Edges.Top:Generate()
		self.Edges.Bottom:Generate()
	elseif self.x == 0 and self.y > 0 then
		self.Edges.Top = self.Parent.Nodes[self.x][self.y - 1].Edges.Bottom
		self.Edges.Left = Edge.new({ x = self.x, y = self.y }, { x = self.x, y = self.y + 1 }, self)
		self.Edges.Right = Edge.new({ x = self.x + 1, y = self.y }, { x = self.x + 1, y = self.y + 1 }, self)
		self.Edges.Bottom = Edge.new({ x = self.x, y = self.y + 1 }, { x = self.x + 1, y = self.y + 1 }, self)

		self.Edges.Left:Generate()
		self.Edges.Right:Generate()
		self.Edges.Bottom:Generate()

	elseif self.x > 0 and self.y > 0 then
		self.Edges.Top = self.Parent.Nodes[self.x][self.y - 1].Edges.Bottom
		self.Edges.Left = self.Parent.Nodes[self.x - 1][self.y].Edges.Right
		self.Edges.Right = Edge.new({ x = self.x + 1, y = self.y }, { x = self.x + 1, y = self.y + 1 }, self)
		self.Edges.Bottom = Edge.new({ x = self.x, y = self.y + 1 }, { x = self.x + 1, y = self.y + 1 }, self)

		self.Edges.Right:Generate()
		self.Edges.Bottom:Generate()
	end
end

return Node
