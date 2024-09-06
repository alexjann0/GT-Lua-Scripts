bots = {
    GetBot("") 
}
bg = 284
left = 50 
right = 45 
interval = 100 

RunThread(function()
    if bots[1] == nil then
        return
    end

    local function amount(id)
        if bots[1]:GetInventory():GetItem(id) then
            return bots[1]:GetInventory():GetItem(id).amount
        else
            return 0
        end
    end

    local function hook(c,v,n,d)
        if v[0]:find("OnDialogRequest") and v[1]:find("end_dialog|grinder") then
            c:SendPacket(2,("action|dialog_return\ndialog_name|grinder\ntilex|%d|\ntiley|%d|\nitemID|%d|\ncount|%d"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)"),v[1]:match("itemID|(%d+)"),v[1]:match("count||(%d+)")))
        end
        if v[0]:find("OnDialogRequest") and v[1]:find("end_dialog|vending") then
            if  v[1]:find("end_dialog|vending|Close||") then
                c:SendPacket(2,("action|dialog_return\ndialog_name|vending\ntilex|%d|\ntiley|%d|\nstockitem|4562"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)")))
            end
            if  v[1]:find("end_dialog|vending|Close|Update|") then
                c:SendPacket(2,("action|dialog_return\ndialog_name|vending\ntilex|%d|\ntiley|%d|\nbuttonClicked|addstock\n\nsetprice|%d\nchk_peritem|%d\nchk_perlock|%d"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)"),v[1]:match("setprice|Price|(%d+)"),v[1]:match("chk_peritem|World Locks per Item|(%d+)"),v[1]:match("chk_perlock|Items per World Lock|(%d+)")))
            end
        end
    end
    bots[1]:AddCallback(VARIANTLIST,"hook",hook)

    tile = {}
    for _,t in pairs(bots[1]:GetWorld():GetTiles()) do
        if t.bg == bg then
            tile[#tile+1] = {x = t.pos_x,y = t.pos_y}
        end
    end

    while true do
        if amount(880) >= 150 and amount(881) >= 100 then
            
            for _,t in pairs(bots[1]:GetWorld():GetTiles()) do
                if t.fg == 4582 then
                    bots[1]:FindPath(t.pos_x,t.pos_y-1)
		    Sleep(interval)
                    bots[1]:PlaceTile(t.pos_x,t.pos_y,880)
                    Sleep(1000)
                end
            end

            for _,t in pairs(bots[1]:GetWorld():GetTiles()) do
                if t.fg == 2978 then
                    bots[1]:FindPath(t.pos_x,t.pos_y)
		    Sleep(interval)
                    bots[1]:WrenchTile(t.pos_x,t.pos_y)
                    Sleep(1000)
                end
            end
        end
        bots[1]:FindPath(tile[1].x,tile[1].y)
	Sleep(interval)

        while amount(880) > 0 do
            bots[1]:PlaceTile(tile[1].x-1,tile[1].y,880)
            Sleep(200)
            bots[1]:PlaceTile(tile[1].x+1,tile[1].y,880)
            Sleep(200)
            bots[1]:HitTile(tile[1].x-1,tile[1].y)
            Sleep(200)
            bots[1]:HitTile(tile[1].x+1,tile[1].y)
            Sleep(200)
            bots[1]:HitTile(tile[1].x-1,tile[1].y)
            Sleep(200)
            bots[1]:HitTile(tile[1].x+1,tile[1].y)
            Sleep(200)
        end
        
        for i = -2, -(left+1), -1 do
            bots[1]:FindPath(tile[1].x+i,tile[1].y)
	    Sleep(interval)
            bots[1]:HitTile(tile[1].x+i,tile[1].y)
            Sleep(200)
        end

        for i = -(left+1), -2 do
            bots[1]:FindPath(tile[1].x+i,tile[1].y)
	    Sleep(interval)
            bots[1]:PlaceTile(tile[1].x+i,tile[1].y,881)
            Sleep(200)
        end

        if amount(880) >= 150 and amount(881) >= 100 then
            for _,t in pairs(bots[1]:GetWorld():GetTiles()) do
                if t.fg == 4582 then
                    bots[1]:FindPath(t.pos_x,t.pos_y-1)
		    Sleep(interval)
                    bots[1]:PlaceTile(t.pos_x,t.pos_y,880)
                    Sleep(1000)
                end
            end
            for _,t in pairs(bots[1]:GetWorld():GetTiles()) do
                if t.fg == 2978 then
                    bots[1]:FindPath(t.pos_x,t.pos_y)
		    Sleep(interval)
                    bots[1]:WrenchTile(t.pos_x,t.pos_y)
                    Sleep(1000)
                end
            end
        end

        bots[1]:FindPath(tile[1].x,tile[1].y)
	Sleep(interval)

        while amount(880) > 0 do
            bots[1]:PlaceTile(tile[1].x-1,tile[1].y,880)
            Sleep(200)
            bots[1]:PlaceTile(tile[1].x+1,tile[1].y,880)
            Sleep(200)
            bots[1]:HitTile(tile[1].x-1,tile[1].y)
            Sleep(200)
            bots[1]:HitTile(tile[1].x+1,tile[1].y)
            Sleep(200)
            bots[1]:HitTile(tile[1].x-1,tile[1].y)
            Sleep(200)
            bots[1]:HitTile(tile[1].x+1,tile[1].y)
            Sleep(200)
        end

        for i = 2, right+1 do
            bots[1]:FindPath(tile[1].x+i,tile[1].y)
	    Sleep(interval)
            bots[1]:HitTile(tile[1].x+i,tile[1].y)
            Sleep(200)
        end

        for i = right+1, 2, -1 do
            bots[1]:FindPath(tile[1].x+i,tile[1].y)
	    Sleep(interval)
            bots[1]:PlaceTile(tile[1].x+i,tile[1].y,881)
            Sleep(200)
        end
    end
end)
