--Implements minimax algorithm
require "scripts.treenode"
require "scripts.board"
local inspect = require "scripts.inspect"

function decide(board)
    local z, x, y = minimax(board, false)
    return x, y
end

function minimax(data, playerTurn)
    local curr_data = data
    curr_data:print_board()
    if curr_data:check_win('X') then --player ganha aqui
        -- print('player win')
        return -1, -1, -1
    end
    if curr_data:check_win('O') then --bot ganha aqui
        -- print('bot win')
        return 1, -1, -1
    end
    if curr_data:velha() then -- deu velha
        print('velha')
        return 0, -1, -1
    end
    local best_i = -1
    local best_j = -1
    local curr_best = -1
    for i = 0, 2, 1 do
        for j = 0, 2, 1 do
            if curr_data[i][j].value == nil then
                local new_data = curr_data:copy()
                if playerTurn == true then
                    new_data[i][j]:set_value('X')
                else
                    new_data[i][j]:set_value('O')
                end
                -- table.insert(node.children, new_node) 
                local curr_ans, _, _ = minimax(new_data, not playerTurn)
                if playerTurn then
                    if curr_ans <= curr_best then
                        curr_best = curr_ans
                        best_i = i
                        best_j = j
                    end
                else
                    if curr_ans >= curr_best then
                        curr_best = curr_ans
                        best_i = i
                        best_j = j
                    end
                end
            end
        end
    end
    print("Retornando: ", curr_best, best_i, best_j)
    return curr_best, best_i, best_j
end