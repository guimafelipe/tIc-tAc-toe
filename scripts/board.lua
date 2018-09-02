require "scripts.cell"

Board = {snap = 52, turn = 'X'}

function Board:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Board:reset()
	for i = 0, 2, 1 do
		self[i] = {}
		for j = 0, 2, 1 do
			self[i][j] = Cell:new(nil)
			self[i][j]:set_snap(self.snap)
			self[i][j]:set_pos(i, j)
		end
	end
	self.turn = 'X'
end 

function Board:draw()
	for i = 0, 2, 1 do
		for j = 0, 2, 1 do
			if self[i][j].value ~= nil then
				self[i][j]:draw()
			elseif selectedX == i and selectedY == j and winner == nil then
				local cellSize = self.snap
				local cellDrawSize = cellSize
				love.graphics.setColor(.86, 0, .86, .2)
				love.graphics.rectangle(
					'fill', i*cellSize + self[i][j].ox, j*cellSize + self[i][j].oy,
					cellDrawSize, cellDrawSize)
				love.graphics.setColor(1,1,1,1)
			end
		end
	end
end

function Board:check_win(char)
	for i = 0, 2, 1 do
		if self[i][0].value == char and self[i][1].value == char and self[i][2].value == char then
			return true
		end
		if self[0][i].value == char and self[1][i].value == char and self[2][i].value == char then
			return true
		end
	end
	if self[0][0].value == char and self[1][1].value == char and self[2][2].value == char then
		return true
	end
	if self[0][2].value == char and self[1][1].value == char and self[2][0].value == char then
		return true
	end
	return false
end

function Board:change_turn()
	if self.turn == 'X' then self.turn = 'O'
	else self.turn = 'X' end
end

function Board:play(char, x, y)
	if self[x][y].value == nil then
		self[x][y].value = char
		local test = self:check_win(char)
		if test == true then 
			-- print("winner: ", char)
			return true
		else
			self:change_turn()
		end
	end
	return false
end

function Board:velha()
	for i = 0, 2, 1 do
		for j = 0, 2, 1 do
			if self[i][j].value == nil then
				return false
			end
		end
	end
	return true
end

function Board:print_board()
	for i = 0, 2, 1 do
		print(self[i][0].value, self[i][1].value, self[i][2].value)
	end
end

function Board:copy()
	copy = Board:new()
	copy:reset()
	for i = 0, 2, 1 do
		for j = 0, 2, 1 do
			copy[i][j].value = self[i][j].value
		end
	end
    return copy
end