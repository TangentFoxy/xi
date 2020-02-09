import graphics from love
import sin, cos from math
import random from love.math
tau = math.pi * 2

local hw, hh
-- hw, hh = graphics.getWidth! / 2, graphics.getHeight! / 2

class System
  new: (opts={}) =>
    @radius = opts.radius or 0.0000001
    @parent = opts.parent or {x: 0, y: 0}
    @offset = opts.offset or random! * tau
  update: (time) =>
    @x = @parent.x + @radius * sin time / @radius + @offset
    @y = @parent.y + @radius * cos time / @radius + @offset
  draw: =>
    graphics.points(@x, @y)

local galaxy
mkGalaxy = ->
  galaxy = {}
  for i = 1, 2 * math.min hw, hh
    table.insert galaxy, System radius: i, offset: 0.2 + random! * (tau - 0.2)
  for i = 1, 2 * math.min hw, hh
    table.insert galaxy, System radius: i, offset: 0

love.load = ->
  love.window.setFullscreen true, "desktop"
  hw, hh = graphics.getWidth! / 2, graphics.getHeight! / 2
  mkGalaxy!

time = os.time!
speed = 1
love.update = (dt) ->
  time += dt * speed
  for system in *galaxy
    system\update time

dist2 = (a, b) ->
  dx = a.x - b.x
  dy = a.y - b.y
  return dx * dx + dy * dy

love.draw = ->
  graphics.translate hw, hh
  graphics.scale 0.5, 0.5
  for system in *galaxy
    system\draw!

  -- currentSystem = galaxy[100]
  -- dynamic formula (more range further out)
  -- d = math.max 10, 0.25^2 * dist2 currentSystem, {x:0, y:0}
  -- for system in *galaxy
  --   if system != currentSystem
  --     if d >= dist2 currentSystem, system
  --       graphics.line currentSystem.x, currentSystem.y, system.x, system.y

  -- attempted to apply dynamic formula to everything at once, and failed
  -- for i = 1, #galaxy - 1
  --   a = galaxy[i]
  --   d = math.max 10, 0.25^2 * dist2 a, {x:0, y:0}
  --   for j = i + 1, #galaxy
  --     b = galaxy[j]
  --     d = math.min d, 0.25^2 * dist2 b, {x:0, y:0}
  --     if d >= dist2 a, b
  --       graphics.line a.x, a.y, b.x, b.y

  -- basic set formula
  for i = 1, #galaxy - 1
    a = galaxy[i]
    for j = i + 1, #galaxy
      b = galaxy[j]
      if 50^2 >= dist2 a, b
        graphics.line a.x, a.y, b.x, b.y

love.keypressed = (key) ->
  if key == "escape"
    love.event.quit!
  elseif key == "r"
    mkGalaxy!
  elseif key == "="
    speed *= 2
  elseif key == "-"
    speed /= 2
