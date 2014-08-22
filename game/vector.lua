if math.infinity == nil then
    math.infinity = "INF"
end

-- @param _construct: map args   --> object
-- @param tcurtsnoc_: map object --> args
Klass = function (_construct, tcurtsnoc_)
    local constructor

    local function copy(o)
        return constructor(tcurtsnoc_(o))
    end

    constructor = function (...)
        local instance = _construct(unpack({...}))

        instance.copy = function ()
            return copy(instance)
        end

        return instance
    end

    return constructor
end

-- a point!
Point = Klass((function ()
    local constructor = function (x, y, z)
        return {
            getX = function () return x end,
            getY = function () return y end,
            getZ = function () return z end
        }
    end

    local copy = function (o)
        return o.x, o.y, o.z
    end

    return constructor, copy
end)())

-- a vector is a glorified point!
Vector = Klass((function ()
    local constructor
    local cache = {}

    build = function (x, y, z)
        local p = Point(x, y, z)

        -- this is the "magnitude" of the vector, or its length as a line
        p.length = function ()
            return math.sqrt(p.getX()^2 + p.getY()^2 + p.getZ()^2)
        end

        -- returns a new vector with a length of 1, for stuff
        p.to_unit = function ()
            local mag = p.length()

            if mag == 0 then return Vector(0, 0, 0) end

            return Vector(p.getX()/mag, p.getY()/mag, p.getZ()/mag)
        end

        local minus = function (o)
            return Vector(-o.getX(), -o.getY(), -o.getZ())
        end

        p.minus = function (o)
            return o.plus(minus(p))
        end

        p.reverse = function ()
            return minus(p)
        end

        p.plus = function (o)
            local x = p.getX() + o.getX()
            local y = p.getY() + o.getY()
            local z = p.getZ() + o.getZ()

            return Vector(x, y, z)
        end

        p.scale = function (s)
            local x = s*p.getX()
            local y = s*p.getY()
            local z = s*p.getZ()

            return Vector(x, y, z)
        end

        p.equal = function (o)
            return p.getX() == o.getX() and p.getY() == o.getY() and p.getZ() == o.getZ()
        end

        -- convenient getters
        p.x = p.getX()
        p.y = p.getY()
        p.z = p.getZ()

        return p
    end

    -- construct vectors with: a vector, 2 vectors, or 3 coords
    _constructor = function (a, b, c)
        if c == nil then
            -- we have vectors

            if b == nil then
                -- a vector through the origin
                return a.copy()
            else
                -- a vector between two points
                return a.minus(b)
            end
        else
            -- we have coords
            return build(a, b, c)
        end
    end

    constructor = _constructor

    local copy = function (o)
        return o.getX(), o.getY(), o.getZ()
    end

    return constructor, copy
end)())

local a = Vector(1, 2, 3)
assert(a.x == 1 and a.getX() == 1)
assert(a.y == 2 and a.getY() == 2)
assert(a.z == 3 and a.getZ() == 3)

local b = Vector(4, 8, 12)
local c = Vector(a, b) -- the vector FROM A TO B
assert(c.x == 3 and c.getX() == 3)
assert(c.y == 6 and c.getY() == 6)
assert(c.z == 9 and c.getZ() == 9)

-- the point constructor is just the minus operator
local d = a.minus(b)
assert(c.equal(d) and d.equal(c)) -- equality is symmetric

-- a - b != b - a
local e = b.minus(a)
assert(not d.equal(e))
assert(e.equal(d.reverse()))
assert(e.x == -3 and e.getX() == -3)
assert(e.y == -6 and e.getY() == -6)
assert(e.z == -9 and e.getZ() == -9)

local f = a.scale(4)
assert(f.equal(b))

local g = a.length()
local h = b.length()
assert(g == math.sqrt(14))

local i = a.to_unit()
local j = b.to_unit()
assert(i.length() == 1)
assert(j.length() == 1)

local k = Vector(a)
local l = a.copy()
assert(k.equal(l))

local m = a.plus(b)
assert(m.equal(Vector(1 + 4, 2 + 8, 3 + 12)))
