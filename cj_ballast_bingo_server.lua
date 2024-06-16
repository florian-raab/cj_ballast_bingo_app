local config = ac.storage {
}

local maxBallast_kg = ac.getCar(0).mass
local ballastChangHalfLife_sec = 30

function updateBallastValues()
    if not ac.getSim().isOnlineRace then
        return
    end
    if not ac.SessionType.Race == ac.getSim().raceSessionType then
        return
    end
    if not ac.getSim().isSessionStarted then
        physics.setCarBallast(0, 0)
        ac.log("Resetting own Ballast: " .. 0 .. "kg")
        return
    end

    -- update is called once per second
    ac.debug("race started", ac.getSim().isSessionStarted)

    local carsCount = ac.getSim().connectedCars
    --for carIndex = 0, carsCount - 1 do
    local car = ac.getCar(0)
    local racePosition = car.racePosition
    local targetBallast = (carsCount - racePosition) * maxBallast_kg / (carsCount - 1)
    local currentBallast = car.ballast
    local changeFactor = (ballastChangHalfLife_sec * maxBallast_kg / (maxBallast_kg * 0.7))
    local changedBallast = currentBallast + (targetBallast - currentBallast) / changeFactor
    ac.log(changedBallast)
    local newBallast = math.max(0, math.min(maxBallast_kg, changedBallast))
    physics.setCarBallast(0, newBallast)
    ac.log("Setting own Ballast: " .. newBallast .. "kg")
    --car.ballast
    --end
end


setInterval(updateBallastValues, 1, "updateBallastInterval")


function script.update(dt)


end
