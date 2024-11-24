local module = {}
local Vector2 = require("src.constructor")

---@return boolean
---@param self table
---@param t table
local function IsVector2(self, t)
    assert(type(t) ~= "nil", "Unexpected action.")

    local meta = getmetatable(t)
    return getmetatable(self) == getmetatable(t)
end

---@return nil
---@param X number
---@param Y number
function module:Set(X, Y)
    assert(type(X) == "number", "Tried to change X to "..type(X))
    assert(type(Y) == "number", ("Tried to change Y to "..type(X)))

    rawset(self, "X", X)
    rawset(self, "Y", Y)
end

---@return Vector2
function module:Normalize()
    return self / self.Magnitude
end

---@return number
---@param Vector Vector2
function module:Angle(Vector)
    assert(type(Vector) == "table" and IsVector2(self, Vector), "Vector parameter its not a Vector2.")

    return math.deg(math.atan(Vector.Y / self.Y, Vector.X / self.X))
end

---@return number
---@param Vector Vector2
function module:Dot(Vector)
    assert(type(Vector) == "table" and IsVector2(self, Vector), "Vector parameter its not a Vector2.")
    local DotProduct = (self.X * Vector.X) + (self.Y * Vector.Y)

    return DotProduct / (self.Magnitude * Vector.Magnitude)
end

---@return Vector2
function module:Perpendicular()
    return Vector2.new(-self.Y, self.X)
end

return module
