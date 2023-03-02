local b = {}
-- Broadcast

b.broadcasts = {}

function b.newBroadcast(text, x, y, color)
    -- Create a new broadcast
    local broadcast = {}
    broadcast.text = text
    broadcast.x = x
    broadcast.y = y
    broadcast.color = color
    broadcast.timer = 0
    broadcast.time = 1
    table.insert(b.broadcasts, broadcast)
end

function b.update(dt)
    -- Update broadcasts
    for i = 1, #b.broadcasts do
        local broadcast = b.broadcasts[i]
        if broadcast then
            broadcast.timer = broadcast.timer + dt
            if broadcast.timer >= broadcast.time then
                table.remove(b.broadcasts, i)
            end
        end
    end
end

function b.draw()
    -- Draw broadcasts
    for i = 1, #b.broadcasts do
        local broadcast = b.broadcasts[i]
        love.graphics.setColor(broadcast.color)
        love.graphics.print(broadcast.text, broadcast.x, broadcast.y)
    end
end

return b