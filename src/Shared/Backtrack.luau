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
    self.StartNode = self.Maze.Nodes[0][0]
	return self
end

function Backtrack:GetUnvistedNeighbor()
	local UnvistedNeighbors = {}
	for _, Neighbor in self.CurrentNode.Neighbors do
        local NeighboringNode = self.Maze.Nodes[Neighbor.x][Neighbor.y]

        if not NeighboringNode then
			continue
		end

		if not NeighboringNode.Visited then
			table.insert(UnvistedNeighbors, NeighboringNode)
		end
	end

    if #UnvistedNeighbors == 0 then
        return nil
    end
    
	local RandomIndex = math.random(1, #UnvistedNeighbors)
	local RandomUnvistedNeighbor = UnvistedNeighbors[RandomIndex]

	return RandomUnvistedNeighbor or nil
end

function Backtrack:Start()
	self.CurrentNode = self.Maze.Nodes[self.Maze.StartNode.x][self.Maze.StartNode.y] or self.Maze.Nodes[0][0]
	self.Stack:Push(self.CurrentNode)
	self.CurrentNode:Visit(nil, self.CurrentNode)

	--while not self.Stack:IsEmpty() do
	--task.wait(0.1)
    local NewNode = self:GetUnvistedNeighbor()
    self.Stack:Push(NewNode)
	self.CurrentNode = self.Stack:GetTop()
	self.CurrentNode:Visit(self.Stack:GetPrevious(), self.CurrentNode)
    task.wait(1)


    while self.CurrentNode ~= self.StartNode do
        NewNode = self:GetUnvistedNeighbor()

        while not NewNode do
            self.Stack:Pop()
            self.CurrentNode = self.Stack:GetTop()
            NewNode = self:GetUnvistedNeighbor()
            task.wait(1)
            print("Backtracking...")
        end

		self.Stack:Push(NewNode)
		self.CurrentNode = self.Stack:GetTop()
		self.CurrentNode:Visit(self.Stack:GetPrevious(), self.CurrentNode)
        task.wait(1)
    end

    print("Backtracking completed.")
end

return Backtrack
