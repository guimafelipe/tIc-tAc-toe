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

function love.mousepressed(x, y, button)
	local cordx, cordy
	if x < Cell.ox then return end
	if y < Cell.oy then return end
	if x > Cell.ox + 3*board.snap then return end
	if y > Cell.oy + 3*board.snap then return end
	-- clicked inside grid
	cordx = x - Cell.ox
	cordx = cordx / board.snap
	cordy = y - Cell.oy
	cordy = cordy / board.snap
	cordx = math.floor(cordx)
	cordy = math.floor(cordy)
	print(cordx, cordy)
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

function board:check_win(char)
	for i = 0, 2, 1 do
		if board[i][0].value == char and board[i][1].value == char and board[i][2].value == char then
			return true
		end
		if board[0][i].value == char and board[1][i].value == char and board[2][i].value == char then
			return true
		end
	end
	if board[0][0].value == char and board[1][1].value == char and board[2][2].value == char then
		return true
	end
	if board[0][2].value == char and board[1][1].value == char and board[2][0].value == char then
		return true
	end
	return false
end

function board:change_turn()
	if board.turn == 'X' then board.turn = 'O'
	else board.turn = 'X' end
end

function board:play(char, x, y)
	if board[x][y].value == nil then
		board[x][y].value = char
		local test = board:check_win()
		if test == true then 
			print("winner: ", char)
		else
			board:change_turn()
		end
	end
end
