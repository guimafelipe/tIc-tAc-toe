require "scripts.cell"
require "scripts.board"
require "scripts.bot"

Cell:set_origin(10, 10)
board = Board:new()

function love.load(arg)
	boardBg = love.graphics.newImage("assets/campo.png")
	omark = love.graphics.newImage("assets/o.png")
	xmark = love.graphics.newImage("assets/x.png")
	love.graphics.setBackgroundColor(1, 1, 1)
	board:reset()
	constructTree(bot.tree.root, true)
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
