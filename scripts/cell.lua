Cell = {x = 0, y = 0, snap = 0, value = nil, ox = 0, oy = 0}

function Cell:new(o)
    o = o or {} --creates new object
    setmetatable(o, self)
    self.__index = self
    return o
end

function Cell:set_pos(x, y)
    -- print("mudando minha pos para:", x, y)
    self.x = x
    self.y = y
    -- print("mudei para: ", self.x, self.y)
end

function Cell:set_snap(snap)
    self.snap = snap
end

function Cell:set_value(new_value)
    self.value = new_value
    print(self.value, " ", self.x, " ", self.y)
end

function Cell:set_origin(x, y)
    self.ox = x
    self.oy = y
end

function Cell:draw()
    if(self.value == nil) then return end
    local posx = self.x * self.snap + self.ox
    local posy = self.y * self.snap + self.oy
    if(self.value == 'X') then
        love.graphics.draw(xmark, posx, posy)    
    elseif (self.value == 'O') then
        love.graphics.draw(omark, posx, posy)
    end
end