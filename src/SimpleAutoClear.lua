for _, bot in pairs(GetBots()) do
    RunThread(function()
        for _, tile in pairs(bot:GetWorld():GetTiles()) do
            if tile.fg ~= 6 and tile.fg ~= 8 and tile.fg ~= 242 and tile.fg ~= 226 and tile.fg ~= 202 and tile.fg ~= 9640 then
                if tile.fg ~= 0 or tile.bg ~= 0 then
                    bot:FindPath(tile.pos_x, tile.pos_y - 1)
                    while tile.bg ~= 0 or tile.fg ~= 0 do
                        bot:HitTile(tile.pos_x, tile.pos_y)
                        Sleep(150)
                    end
                    Sleep(100)
                end
            end
        end    
    end)
end
