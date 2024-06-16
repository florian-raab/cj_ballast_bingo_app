local config = ac.storage {
}

function script.windowMain(dt)
    ui.text("Pos   " .. "     Ballast           " .. " Driver")

    local carsCount = ac.getSim().carsCount
    local connectedCars = ac.getSim().connectedCars
    for carIndex = 0, carsCount - 1 do
        local car = ac.getCar(carIndex)
        if car.isConnected then
            local racePosition = car.racePosition
            ui.setCursor(vec2(10, racePosition * ui.fontSize() + 30))
            ui.text("#" .. car.racePosition)

            ui.setCursor(vec2(60, racePosition * ui.fontSize() + 30))
            ui.text(car.ballast .. " kg")

            ui.setCursor(vec2(130, racePosition * ui.fontSize() + 30))
            ui.text(car:driverName())
        end
    end


end
