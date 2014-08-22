local Vector = function (x, y, z)
    return {
        x = x,
        y = y,
        z = z
    }
end

local sum = function (a, b)
    return {
        x = a.x + b.x,
        y = a.y + b.y,
        z = a.z + b.z
    }
end

local scale = function (v, s)
    return {
        x = s*v.x,
        y = s*v.y,
        z = s*v.z
    }
end

function love.update(dt)

    if love.keyboard.isDown('up') then
        game.distance = game.distance - 0.1
    elseif love.keyboard.isDown('down') then
        game.distance = game.distance + 0.1
    end

    local h = game.draw_plane:getHeight() - 1
    local w = game.draw_plane:getWidth() - 1
    local o = game.player.eye
    local color, v, r, g, b, a

    -- for each pixel in the draw plane
    for i = 0, w do
        for j = 0, h do
            -- a vector in the direction of each pixel
            v = Vector(i - o.x, j - o.y, 100 - o.z)

            b = sum(scale(v, game.distance), scale(o, game.distance))

            if b.x >= 0 and b.x < game.bg_data:getWidth() and b.y >= 0 and b.y < game.bg_data:getHeight() then
                r, g, b, a = game.bg_data:getPixel(b.x, b.y)
            else
                r, g, b, a = 0, 0, 0, 0
            end

            game.draw_plane:setPixel(i, j, r, g, b, a)
        end
    end
end
