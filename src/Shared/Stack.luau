local Stack = {}
Stack.__index = Stack

function Stack.new()
	local self = setmetatable({}, Stack)

	self._stack = {}

	return self
end

function Stack:isEmpty()
	return #self._stack == 0
end

function Stack:push(value)
	table.insert(self._stack, value)
end

function Stack:pop()
	if self:isEmpty() then
		return nil
	end

	return table.remove(self._stack, #self._stack)
end

return Stack