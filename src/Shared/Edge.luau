local Edge = {}
Edge.__index = Edge

function Edge.new(Node1, Node2)
	local self = {}
	self.Nodes = {
		Node1 = Node1,
		Node2 = Node2,
	}
	return setmetatable(self, Edge)
end

function Edge:Generate()
	local Edge = Instance.new("Part")
	Edge.Size = Vector3.new(1, 3, 1)
	Edge.Anchored = true
	Edge.Position = Vector3.new(
		(self.Nodes.Node1.x + self.Nodes.Node2.x) / 2,
		3,
		(self.Nodes.Node1.y + self.Nodes.Node2.y) / 2
	)
end

return Edge
