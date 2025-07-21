local Edge = {}
Edge.__index = Edge

function Edge.new(Point1, Point2, Parent)
	local self = setmetatable({}, Edge)
	self.Points = {
		Point1 = Point1,
		Point2 = Point2,
	}
	self.Parent = Parent
	self.Instance = nil
	return self
end

function Edge:Generate()
	self.Instance = Instance.new("Part")
	self.Instance.Anchored = true
	self.Instance.CanCollide = true
	self.Instance.Color = self.Parent.EdgeProperties.Color3
	self.Instance.Material = self.Parent.EdgeProperties.Material

	local Offset1 = Vector3.new(self.Parent.EdgeProperties.xScale * self.Points.Point1.x, 0, self.Parent.EdgeProperties.yScale * self.Points.Point1.y)
	local Offset2 = Vector3.new(self.Parent.EdgeProperties.xScale * self.Points.Point2.x, 0, self.Parent.EdgeProperties.yScale * self.Points.Point2.y)

	local Point1 = self.Parent.Parent.Origin + Offset1
	local Point2 = self.Parent.Parent.Origin + Offset2

	local Distance = (Point1 - Point2).Magnitude
	self.Instance.Size = Vector3.new(self.Parent.EdgeProperties.Thickness, self.Parent.EdgeProperties.Height, Distance)
	self.Instance.CFrame = CFrame.new(Point1, Point2) * CFrame.new(0, self.Parent.EdgeProperties.Height/2, -Distance/2)

	self.Instance.Parent = workspace
end

return Edge
