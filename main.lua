require "scripts.cell"
require "scripts.board"
require "scripts.bot"

Cell:set_origin(10, 10)
board = Board:new()
board:reset()

winner = nil

function love.load(arg)
	boardBg = love.graphics.newImage("assets/campo.png")
	omark = love.graphics.newImage("assets/o.png")
	xmark = love.graphics.newImage("assets/x.png")
	love.graphics.setBackgroundColor(1, 1, 1)
end

function love.update(dt)
	
end

function love.draw(dt)
	love.graphics.draw(boardBg, 0, 0)
	board:draw()
	if winner ~= nil then
		love.graphics.print({{0,0,0,1},winner}, 25, 160 )
	end
end

function love.mousepressed(x, y, button)
	local cordx, cordy
	if winner ~= nil then
		restart()
		return
	end
	if x < Cell.ox then return end
	if y < Cell.oy then return end
	if x > Cell.ox + 3*board.snap then return end
	if y > Cell.oy + 3*board.snap then return end
	if board.turn ~= 'X' then
		return
	end
	-- clicked inside grid
	cordx = x - Cell.ox
	cordx = cordx / board.snap
	cordy = y - Cell.oy
	cordy = cordy / board.snap
	cordx = math.floor(cordx)
	cordy = math.floor(cordy)
	if board[cordx][cordy].value == nil then
		local result
		result = board:play('X', cordx, cordy)
		if result then 
			winner = 'X winner'
		elseif board:velha() then
			winner = 'Deu velha'
		else
			local i, j = decide(board)
			print(i, j)
			result = board:play('O', i, j)
			if result then winner = 'O winner' end
		end
	end
	if board:velha() == true then
		winner = "Deu velha"
	end
	-- print(cordx, cordy)
end

function restart()
	board:reset()
	winner = nil
end
