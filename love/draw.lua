love.viewport = require('libs/viewport').newSingleton({
    width = 160,
    height = 144
})

function love.draw()
    -- Draw here
    game.draw_plane_image:refresh()

    love.graphics.draw(game.draw_plane_image, 0, 0)
    --love.graphics.draw(game.bg_image, 0, 0)
end
