local Stack = {}
Stack.__index = Stack

function Stack.new()
	local self = setmetatable({}, Stack)

	self._stack = {}

	return self
end

function Stack:IsEmpty()
	return #self._stack == 0
end

function Stack:Push(value)
	table.insert(self._stack, value)
end

function Stack:Pop()
	if self:isEmpty() then
		return nil
	end

	return table.remove(self._stack, #self._stack)
end

function Stack:GetPrevious()
	if #self._stack < 2 then
		return nil
	end

	return self._stack[#self._stack - 1]
end

function Stack:GetTop()
	if self:IsEmpty() then
		return nil
	end

	return self._stack[#self._stack]
end

return Stack