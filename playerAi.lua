local pai = {}
-- Player AI

pai.memory = {}
pai.choice = "shoot"
pai.thinkTimer = 1
pai.risk = love.math.random(1, 6) -- how many shoots other players have to do before it spins
pai.thought = false

function pai:addToMemory(self, count)
    -- cout how many times its been since last shoot/spin
    if self.choice == "shoot" then
        table.insert(self.memory, 1)
    else
        self.memory = {}
        self.risk = love.math.random(1, 6)
    end
end

function pai:think(self, dt)
    -- The player ai thinks if it will shoot or spin the chamber

    self.thinkTimer = self.thinkTimer - dt
    if self.thinkTimer <= 0 then
        self.thinkTimer = 1
        -- does it shoot or spin?
        print(#self.memory)
        if #self.memory > self.risk then
            self.choice = "spin"
            broadcast.newBroadcast("Player " .. curTurn .. " spun the chamber", 400, 300, {255, 255, 255})
        else
            self.choice = "shoot"
            broadcast.newBroadcast("Player " .. curTurn .. " shot the gun", 400, 300, {255, 255, 255})
        end

        self.thought = true
    end
end

return pai