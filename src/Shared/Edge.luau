local Edge = {}
Edge.__index = Edge

function Edge.new(Point1, Point2, Parent, Properties)
	local self = setmetatable({}, Edge)
	self.Parent = Parent
	self.Points = {
		Point1 = Point1,
		Point2 = Point2,
	}
	self.Properties = Properties or {
		Color3 = Properties.Color3 or Color3.new(0.533333, 0.478431, 0.478431),
		Thickness = Properties.Thickness or 0.05,
		Material = Properties.Material or Enum.Material.SmoothPlastic,
		xScale = Properties.xScale or 1,
		yScale = Properties.yScale or 1,
		Height = Properties.Height or 0.5,
	}
	return self
end

function Edge:Generate()
	local Edge = Instance.new("Part")
	Edge.Anchored = true
	Edge.CanCollide = true
	Edge.Color = self.Properties.Color3
	Edge.Material = self.Properties.Material

	local Offset1 = Vector3.new(self.Properties.xScale * self.Points.Point1.x, 0, self.Properties.yScale * self.Points.Point1.y)
	local Offset2 = Vector3.new(self.Properties.xScale * self.Points.Point2.x, 0, self.Properties.yScale * self.Points.Point2.y)

	local Point1 = self.Parent.Parent.Origin + Offset1
	local Point2 = self.Parent.Parent.Origin + Offset2

	local Distance = (Point1 - Point2).Magnitude
	Edge.Size = Vector3.new(self.Properties.Thickness, self.Properties.Height, Distance)
	Edge.CFrame = CFrame.new(Point1, Point2) * CFrame.new(0, self.Properties.Height/2, -Distance/2)

	Edge.Parent = workspace
end

return Edge
