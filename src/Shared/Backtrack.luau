local Stack = require(game.ReplicatedStorage.Stack)

local Neightbors = {
	"Right",
	"Left",
	"Up",
	"Down",
}

local Backtrack = {}
Backtrack.__index = Backtrack

function Backtrack.new(Maze)
	local self = setmetatable({}, Backtrack)
	self.Maze = Maze
	self.Stack = Stack.new()
	self.CurrentNode = nil
	return self
end

function Backtrack:GetUnvistedNeighbor(Node)
	local UnvistedNeighbors = {}
	for _, Direction in Neightbors do
		if not Node.Neighbors[Direction].Visited then
			table.insert(UnvistedNeighbors, Node.Neighbors[Direction])
		end
	end

	local RandomIndex = math.random(1, #UnvistedNeighbors)
	local RandomKey = UnvistedNeighbors[RandomIndex]
	local RandomUnvistedNeighbor = self.CurrentNode.Neighbors[RandomKey]
	local NewNode = self.Maze.Nodes[RandomUnvistedNeighbor.x][RandomUnvistedNeighbor.y]

	return NewNode or nil
end

function Backtrack:Start()
	self.CurrentNode = self.Maze.Nodes[self.Maze.StartNode.x][self.Maze.StartNode.y] or self.Maze.Nodes[0][0]
	self.Stack:Push(self.CurrentNode)
	self.CurrentNode:Visit(nil, self.CurrentNode)

	--while not self.Stack:IsEmpty() do
	--task.wait(0.1)

	for i = 0, 30, 1 do
		local NewNode = self:GetUnvistedNeighbor(self.CurrentNode)

        while not NewNode do
            self.Stack:Pop()
            self.CurrentNode = self.Stack:GetTop()
            NewNode = self:GetUnvistedNeighbor(self.CurrentNode)
            task.wait(1)
        end

		self.Stack:Push(NewNode)
		self.CurrentNode = self.Stack:GetTop()
		self.CurrentNode:Visit(self.Stack:GetPrevious(), self.CurrentNode)
	end
	--end
end

return Backtrack
