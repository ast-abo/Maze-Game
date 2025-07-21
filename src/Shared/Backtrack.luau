local Stack = require(game.ReplicatedStorage.Stack)

local Backtrack = {}
Backtrack.__index = Backtrack

function Backtrack.new(Maze)
    local self = setmetatable({}, Backtrack)
    self.Maze = Maze
    self.Stack = Stack.new()
    self.CurrentNode = nil
    return self
end

function Backtrack:Start()
    self.CurrentNode = self.Maze.StartNode or self.Maze.Nodes[0][0]
    self.Stack:push(self.CurrentNode)

    while not self.Stack:isEmpty() do
        local node = self.Stack:pop()
        if not node.Visited then
            node.Visited = true
            self:VisitNode(node)
        end
    end
end

return Backtrack