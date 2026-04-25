



local a=game:GetService"Players"
local b=game:GetService"RunService"
game:GetService"ReplicatedStorage"
game:GetService"UserInputService"

local c=a.LocalPlayer
local d=c:WaitForChild"PlayerGui"




local e={

ButtonText="AutoRun",
ButtonOnColor=Color3.fromRGB(80,200,120),
ButtonOffColor=Color3.fromRGB(60,60,60),
ButtonTextColor=Color3.fromRGB(255,255,255),
ButtonSize=UDim2.new(0,130,0,44),
ButtonPosition=UDim2.new(1,-150,0.5,-22),


LoopInterval=0.1,
}




local f=Instance.new"ScreenGui"
f.Name="ToggleButtonGui"
f.ResetOnSpawn=false
f.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
f.Parent=d

local g=Instance.new"TextButton"
g.Name="ToggleBtn"
g.Size=e.ButtonSize
g.Position=e.ButtonPosition
g.AnchorPoint=Vector2.new(0.5,0.5)
g.BackgroundColor3=e.ButtonOffColor
g.TextColor3=e.ButtonTextColor
g.Text=e.ButtonText.."  [OFF]"
g.Font=Enum.Font.GothamBold
g.TextSize=14
g.AutoButtonColor=false
g.Parent=f


local h=Instance.new"UICorner"
h.CornerRadius=UDim.new(0,10)
h.Parent=g


local i=false
local j:RBXScriptConnection?

local function tweenColor(k:GuiObject,l:Color3)

local m=8
local n=k.BackgroundColor3
for o=1,m do
task.wait(0.016)
k.BackgroundColor3=n:Lerp(l,o/m)
end
end




local function onTick()
game:GetService"ReplicatedStorage":WaitForChild"Remotes":WaitForChild"MHP":FireServer()
end

local function startLoop()
if j then return end
j=b.Heartbeat:Connect(function()

end)

task.spawn(function()
while i do
onTick()
task.wait(e.LoopInterval)
end
end)
end

local function stopLoop()
if j then
j:Disconnect()
j=nil
end
end

local function toggleFeature()
i=not i

if i then
g.Text=e.ButtonText.."  [ON]"
task.spawn(tweenColor,g,e.ButtonOnColor)
startLoop()
else
g.Text=e.ButtonText.."  [OFF]"
task.spawn(tweenColor,g,e.ButtonOffColor)
stopLoop()
end
end


g.MouseButton1Click:Connect(toggleFeature)
g.TouchTap:Connect(toggleFeature)


g.MouseButton1Down:Connect(function()
g.BackgroundTransparency=0.15
end)
g.MouseButton1Up:Connect(function()
g.BackgroundTransparency=0
end)


c.CharacterRemoving:Connect(function()
if i then
i=false
stopLoop()
g.Text=e.ButtonText.."  [OFF]"
g.BackgroundColor3=e.ButtonOffColor
end
end)