--Implements minimax algorithm
require "scripts.board"

function decide(board)
    local z, x, y = minimax(board, false, 0)
    return x, y
end

function minimax(data, playerTurn, depth, parent_ab)
    depth = depth + 1
    local curr_data = data

    if curr_data:check_win('X') then --player ganha aqui
        return depth - 11, -1, -1 -- using 10 as score to make it always negative
    end
    if curr_data:check_win('O') then --bot ganha aqui
        return 11 - depth, -1, -1
    end
    if curr_data:velha() then -- deu velha
        return 0, -1, -1
    end

    local best_i = -1
    local best_j = -1
    local curr_best

    if playerTurn then
        curr_best = 1000
    else
        curr_best = -1000
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
                local curr_ans, _, _ = minimax(new_data, not playerTurn, depth, curr_best)
                if playerTurn then
                    if curr_ans < curr_best then
                        curr_best = curr_ans
                        best_i = i
                        best_j = j
                        if parent_ab ~= nil and curr_ans < parent_ab then
                            return curr_best, best_i, best_j
                        end
                    end
                else
                    if curr_ans > curr_best then
                        curr_best = curr_ans
                        best_i = i
                        best_j = j
                        if parent_ab ~= nil and curr_ans > parent_ab then
                            return curr_best, best_i, best_j
                        end
                    end
                end
            end
        end
    end

    return curr_best, best_i, best_j
end