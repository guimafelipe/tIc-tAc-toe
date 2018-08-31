--Implements minimax algorithm
require "scripts.treenode"
require "scripts.board"
-- local inspect = require "scripts.inspect"

function decide(board)
    local z, x, y = minimax(board, false, 0)
    return x, y
end

function minimax(data, playerTurn, depth)
    depth = depth + 1
    local curr_data = data
    -- curr_data:print_board()
    if curr_data:check_win('X') then --player ganha aqui
        -- print('player win')
        -- curr_data:print_board()
        return depth - 10, -1, -1 -- using 10 as score to make it always negative
    end
    if curr_data:check_win('O') then --bot ganha aqui
        -- print('bot win')
        -- curr_data:print_board()
        return 10 - depth, -1, -1
    end
    if curr_data:velha() then -- deu velha
        -- print('velha')
        -- curr_data:print_board()
        return 0, -1, -1
    end
    local best_i = -1
    local best_j = -1
    local curr_best
    if playerTurn then curr_best = 1000
    else curr_best = -1000
    end
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
                local curr_ans, _, _ = minimax(new_data, not playerTurn, depth)
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
    -- print("Retornando: ", curr_best, best_i, best_j)
    return curr_best, best_i, best_j
end