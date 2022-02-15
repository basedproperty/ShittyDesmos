warn("begin")
-- settings
local graphstart = -100
local graphend = 100
local interval = 0.05
local zoom = 50
local color = Color3.new(1,0,0)
local axiscolor = Color3.new(0,0,0)
local waituntildestroy =  5

-- scroll down for equation!

-- cache
local DrawingNew = Drawing.new
local Center = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
DrawingObjects = {}

function GenerateVectorPoint(fx,fy)
    local x = fx * zoom
    local y = fy * zoom
    return Center + Vector2.new(x,y)
end

-- generate line plots
local graphpoints = {}

for x = graphstart,graphend,interval do
    local equation = x -- EDIT THIS
    local y = equation*-1
    graphpoints[x] = y
end

-- draw graph
local xaxis = DrawingNew("Line")
xaxis.From = GenerateVectorPoint(graphstart,0)
xaxis.To = GenerateVectorPoint(graphend,0)
xaxis.Visible = true
xaxis.Color = axiscolor
xaxis.Transparency = 1
xaxis.Thickness = 2
table.insert(DrawingObjects,xaxis)

local yaxis = DrawingNew("Line")
yaxis.From = GenerateVectorPoint(0,graphstart)
yaxis.To = GenerateVectorPoint(0,graphend)
yaxis.Visible = true
yaxis.Color = axiscolor
yaxis.Transparency = 1
yaxis.Thickness = 2
table.insert(DrawingObjects,yaxis)

-- draw line

for x,y in pairs(graphpoints) do
    if graphpoints[x+interval] ~= nil then
        local CurrentPoint = GenerateVectorPoint(x,y)
        local NextPoint = GenerateVectorPoint(x+interval,graphpoints[x+interval])
        local line = DrawingNew("Line")
        line.From = CurrentPoint
        line.To = NextPoint
        line.Visible = true
        line.Transparency = 1
        line.Color = color
        line.Thickness = 2
        table.insert(DrawingObjects,line)
    end
end

wait(waituntildestroy)
for i,v in pairs(DrawingObjects) do
    v:Remove()
end