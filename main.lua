require "scripts.cell"

board = {snap = 55}
Cell:set_origin(10, 10)

function love.load(arg)
	boardBg = love.graphics.newImage("assets/campo.png")
	omark = love.graphics.newImage("assets/o.png")
	xmark = love.graphics.newImage("assets/x.png")
	love.graphics.setBackgroundColor(1, 1, 1)
	board:reset()
end

function love.update(dt)

end

function love.draw(dt)
	love.graphics.draw(boardBg, 0, 0)
	board:draw()
end

function board:reset()
	for i = 0, 2, 1 do
		board[i] = {}
		for j = 0, 2, 1 do
			board[i][j] = Cell:new(nil)
			board[i][j]:set_snap(self.snap)
			board[i][j]:set_pos(i, j)
			if((j+i)%2 == 0) then board[i][j]:set_value('X')
			else board[i][j]:set_value('O') end
		end
	end
end 

function board:draw()
	for i = 0, 2, 1 do
		for j = 0, 2, 1 do
			board[i][j]:draw() 
		end
	end
end
