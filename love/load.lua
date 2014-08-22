function love.load()
    require('game/controls')
    require('game/sounds')
    require('game/vector')

    local WIDTH = 160
    local HEIGHT = 144

    game.draw_plane = love.image.newImageData(WIDTH, HEIGHT)
    game.draw_plane_image = love.graphics.newImage(game.draw_plane)
    game.vector_cache = {}

    game.bg_data = love.image.newImageData('assets/dude_frowning.jpg')
    game.bg_image = love.graphics.newImage(game.bg_data)

    local player = {}
    player.eye = Vector(WIDTH/2, HEIGHT/2, 0)

    game.player = player
    game.distance = 10
end
