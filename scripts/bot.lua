--Implements minimax algorithm
require "scripts.treenode"
require "scripts.board"
local inspect = require "scripts.inspect"

bot = {}
Tree:new()

function minimax(depth, isMax, node)
end

bot.tree = Tree
local initial_data = Board:new()
initial_data:reset()
bot.tree.root = Node:new(nil, nil, initial_data)

function constructTree(node, playerTurn)
    local curr_data = node.data
    if curr_data:check_win('X') then --player ganha aqui
        node.value = -1
        return
    end
    if curr_data:check_win('O') then --bot ganha aqui
        node.value = 1
        return
    end
    if curr_data:velha() then -- deu velha
        node.value = 0
        return
    end
    for i = 0, 2, 1 do
        for j = 0, 2, 1 do
            if curr_data[i][j] ~= nil then
                local new_data = curr_data
                if playerTurn == true then
                    new_data[i][j] = 'X'
                else
                    new_data[i][j] = 'O'
                end
                local new_node = Node:new(nil, nil, new_data)
                table.insert(node.children, new_node) 
                constructTree(node, not playerTurn)
            end
        end
    end
end