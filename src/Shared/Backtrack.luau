local Stack = require(game.ReplicatedStorage.Stack)

local Backtrack = {}
Backtrack.__index = Backtrack

function Backtrack.new(Parent)
	local self = setmetatable({}, Backtrack)
	self.Parent = Parent
	self.Stack = Stack.new()
	self.CurrentNode = nil
    self.StartNode = {
		x = Parent.StartNode.x,
		y = Parent.StartNode.y,
	}
	return self
end

function Backtrack:Start()
	self.CurrentNode = self.Parent.Nodes[self.StartNode.x][self.StartNode.y] or self.Parent.Nodes[0][0]
	self.StartNode = self.CurrentNode
	self.Stack:Push(self.CurrentNode)
	self:VisitNode()

	print("Starting backtracking...")

    local NewNode = self.CurrentNode:GetUnvistedNeighbor()
    self.Stack:Push(NewNode)
	self.CurrentNode = self.Stack:GetTop()
	self:VisitNode()
    task.wait(self.Parent.BacktrackSpeed)

    while self.CurrentNode ~= self.StartNode do
        NewNode = self.CurrentNode:GetUnvistedNeighbor()

        while not NewNode do
            self.Stack:Pop()
            self.CurrentNode = self.Stack:GetTop()

			if not self.CurrentNode then
				print("No more nodes to backtrack to, finished backtracking.")
				return
			end

            NewNode = self.CurrentNode:GetUnvistedNeighbor()
            task.wait(self.Parent.BacktrackSpeed)
            print("Backtracking...")
        end

		self.Stack:Push(NewNode)
		self.CurrentNode = self.Stack:GetTop()
		self:VisitNode()
		task.wait(self.Parent.BacktrackSpeed)
		print("Visiting node at (" .. self.CurrentNode.x .. ", " .. self.CurrentNode.y .. ")")
    end
end

function Backtrack:VisitNode()
	self.CurrentNode.Visited = true

	if not self.Stack:GetPrevious() then
		return
	end

	local PreviousNode = self.Stack:GetPrevious()

	if PreviousNode.x < self.CurrentNode.x then
		self.CurrentNode.Edges.Left.Instance:Destroy()
	end

	if PreviousNode.x > self.CurrentNode.x then
	 	self.CurrentNode.Edges.Right.Instance:Destroy()
	end

	if PreviousNode.y < self.CurrentNode.y then
		self.CurrentNode.Edges.Top.Instance:Destroy()
	end

	if PreviousNode.y > self.CurrentNode.y then
		self.CurrentNode.Edges.Bottom.Instance:Destroy()
	end
end

return Backtrack
