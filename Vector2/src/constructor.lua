---@class Vector2
---@field X number X component of the vector.
---@field Y number Y component of the vector.
---@field Magnitude number Length of this vector.
---@field Up Vector2    Return Vector2(0, 1).
---@field Down Vector2  Return Vector2(0, -1).
---@field Left Vector2  Return Vector2(-1, 0).
---@field Right Vector2 Return Vector2(1, 0).
---@field One Vector2   Return Vector2(1, 1).
---@field Zero Vector2  Return Vector2(0, 0).
---@field PositiveInfinity Vector2 Return Vector2(inf, inf).
---@field NegativeInfinity Vector2 Return Vector2(-inf, -inf).
---@field Set fun(self, X: number, Y: number): nil Set X and Y components of this vector.
---@field Normalize fun(self): Vector2 Return a normalized version of this vector.
---@field Angle fun(self, Vector: Vector2): number Return the angle between this vector and Vector2 in Vector parameter.
---@field Dot fun(self, Vector: Vector2): number Return the geometric dot product of this vector and Vector2 in Vector parameter.
---@field Perpendicular fun(self): Vector2 Return the perpendicular of this vector. The result is always rotated 90-degrees in a counter-clockwise direction.
---@operator add(Vector2 | number): Vector2
---@operator sub(Vector2 | number): Vector2
---@operator mul(Vector2 | number): Vector2
---@operator div(Vector2 | number): Vector2
---@operator pow(Vector2 | number): Vector2

local Vector2Methods

local module = {}
module._type = "Vector2" -- To check identify when its a Vector2 in internal functions

module.__index = function(t, k)
    if not Vector2Methods then
        Vector2Methods = require("src.methods")
    end

    t = rawget(t, "t")
    local ToReturn = rawget(Vector2Methods, k) or rawget(t, k) or rawget(module, k) or "undefined"
    if ToReturn == "undefined" then
        error(tostring(k).." doens't exist in Vector2.")
    end

    return ToReturn
end

module.__newindex = function(t, k, v)
    t = rawget(t, "t")
    if not t[k] and not module[k] then
        error(("Tried to add key %s with value %s to the Vector2"):format(tostring(k), tostring(v)))
    end

    if k == "X" or k == "Y" then
        assert(type(v) == "number", ("Tried to change %s to %s"):format(k, tostring(v)))

        rawset(t, k, v)
        return
    end

    error(("Tried to change %s to %s."):format(k, tostring(v)))
end

module.__tostring = function(t)
    t = rawget(t, "t")
    return "X: "..rawget(t, "X").."\nY: "..rawget(t, "Y")
end


module.__eq = function(t1, t2)
    t1 = rawget(t1, "t")
    if type(t2) == "table" and getmetatable(t2) == module then
        t2 = rawget(t2, "t")
        return rawget(t1, "X") == rawget(t2, "X") and rawget(t1, "Y") == rawget(t2, "Y")
    end

    error("Tried to compare a Vector2 with "..type(t2))
end

module.__lt = function(t1, t2)
    t1 = rawget(t1, "t")
    if getmetatable(t2) == module then
        t2 = rawget(t2, "t")
        error("Tried to compare Vector2 < Vector2")
    end

    error("Tried to compare a Vector2 < table")
end

module.__le = function(t1, t2)
    t1 = rawget(t1, "t")
    if getmetatable(t2) == module then
        t2 = rawget(t2, "t")
        error("Tried to compare Vector2 <= Vector2")
    end

    error("Tried to compare a Vector2 <= table")
end


module.__add = function(t1, t2)
    t1 = rawget(t1, "t")
    if type(t2) == "table" and getmetatable(t2) == module then
        t2 = rawget(t2, "t")
        return module.new(t1.X + t2.X, t1.Y + t2.Y)
    elseif type(t2) == "number" then
        return module.new(t1.X + t2, t1.Y + t2)
    end

    error("Tried to add Vector2 with "..type(t2))
end

module.__sub = function(t1, t2)
    t1 = rawget(t1, "t")
    if type(t2) == "table" and getmetatable(t2) == module then
        t2 = rawget(t2, "t")
        return module.new(t1.X - t2.X, t1.Y - t2.Y)
    elseif type(t2) == "number" then
        return module.new(t1.X - t2, t1.Y - t2)
    end

    error("Tried to subtract Vector2 with "..type(t2))
end

module.__mul = function(t1, t2)
    t1 = rawget(t1, "t")
    if type(t2) == "table" and getmetatable(t2) == module then
        t2 = rawget(t2, "t")
        return module.new(t1.X * t2.X, t1.Y * t2.Y)
    elseif type(t2) == "number" then
        return module.new(t1.X * t2, t1.Y * t2)
    end

    error("Tried to multiply Vector2 with "..type(t2))
end

module.__div = function(t1, t2)
    t1 = rawget(t1, "t")
    if type(t2) == "table" and getmetatable(t2) == module then
        t2 = rawget(t2, "t")
        return module.new(t1.X / t2.X, t1.Y / t2.Y)
    elseif type(t2) == "number" then
        return module.new(t1.X / t2, t1.Y / t2)
    end

    error("Tried to divide Vector2 with "..type(t2))
end


---@return Vector2?
---@param t1 Vector2
---@param t2 Vector2
module.__pow = function(t1, t2)
    t1 = rawget(t1, "t")
    if type(t2) == "table" and getmetatable(t2) == module then
        return module.new(t1.X ^ t2.X, t1.Y ^ t2.Y)
    elseif type(t2) == "number" then
        return module.new(t1.X ^ t2, t1.Y ^ t2)
    end

    error("Tried to power Vector2 with "..type(t2))
end



---@return Vector2
---@param X number
---@param Y number
function module.new(X, Y)
    local self = {}
    self.X = X or 0
    self.Y = Y or 0
    
    self.Magnitude = math.sqrt(self.X ^ 2 + self.Y ^ 2)

    return setmetatable({t = self}, module)
end


---@return Vector2
---@param ... Vector2
function module.Max(...)
    local t = table.pack(...)
    local X, Y
    ---@param Vector2 Vector2
    for _, Vector2 in pairs(t) do
        if type(Vector2) ~= "table" or getmetatable(Vector2) ~= module then
            goto continue
        end

        if not X or Vector2.X > X then
            X = Vector2.X
        end

        if not Y or Vector2.Y > Y then
            Y = Vector2.Y
        end

        :: continue ::
    end

    return module.new(X, Y)
end

---@return Vector2
function module.Min(...)
    local t = table.pack(...)
    local X, Y
    ---@param Vector2 Vector2
    for _, Vector2 in pairs(t) do
        if type(Vector2) ~= "table" or getmetatable(Vector2) ~= module then
            goto continue
        end

        if not X or Vector2.X < X then
            X = Vector2.X
        end

        if not Y or Vector2.Y < Y then
            Y = Vector2.Y
        end

        :: continue ::
    end

    return module.new(X, Y)
end

module.Up    = function() return module.new(0,  1) end
module.Down  = function() return module.new(0, -1) end
module.Left  = function() return module.new(-1, 0) end
module.Right = function() return module.new( 1, 0) end

module.One   = function() return module.new(0, 0)  end
module.Zero  = function() return module.new(1, 1)  end

module.PositiveInfinity = function() return module.new( math.huge,  math.huge) end
module.NegativeInfinity = function() return module.new(-math.huge, -math.huge) end

return module
