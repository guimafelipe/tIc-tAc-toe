Tree = {}
Tree.__index = Tree

Node = {}

function Node:new(o, value, data)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o.value = value
    o.data = data
    o.parent = nil
    o.children = {}
    return o
end

function Tree:new()
    local tree = setmetatable({}, Tree)
end
