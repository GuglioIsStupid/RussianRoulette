function love.load()
    gunChamberMax = 6
    curChamber = 1
    bulletChamber = love.math.random(1, gunChamberMax)

    playerCount = 5 -- 5 other players

    curTurn = 1 -- real player is 6

    waitTimer = 0

    playerAi = {}

    broadcast = require("broadcast") -- load broadcast
    playerAIBackend = require("playerAi") -- load player ai

    for i = 1, playerCount do
        playerAi[i] = playerAIBackend.new()
    end
    dead = false
end

function love.math.random(min, max)
    -- set a random math seed
    math.randomseed(math.random(1, 1000000))

    return math.random(min, max)
end

function love.update(dt)
    broadcast.update(dt)
    if curTurn ~= 6 then 
        if not playerAi[curTurn].thought then
            playerAi[curTurn]:think(playerAi[curTurn], dt)
        else
            if playerAi[curTurn-1] then playerAi[curTurn-1].thought = false 
            else playerAi[playerCount].thought = false end
            for i = 1, #playerAi do
                playerAi[i]:addToMemory(playerAi[i], 1, playerAi[curTurn].choice)
            end
            curTurn = curTurn + 1
        end
    end
end

function love.keypressed(key)
    if curTurn == 6 then
        if key == "space" then 
            -- shoot gun
            if curChamber == bulletChamber then
                -- player dies
                dead = true
            else
                -- player lives
                curTurn = 1
                curChamber = curChamber + 1
                if curChamber > gunChamberMax then
                    curChamber = 1
                end
            end
            broadcast.newBroadcast("You shot the gun", 400, 300, {255, 255, 255})
        elseif key == "r" then
            -- spin chamber
            curChamber = love.math.random(1, gunChamberMax)
            broadcast.newBroadcast("You spun the chamber", 400, 300, {255, 255, 255})
        end
    end
end

function love.keyreleased(key)

end

function love.draw()
    if not dead then
        broadcast.draw()
    else
        love.graphics.print("You died", 400, 300)
    end
end

function love.quit()
    
end