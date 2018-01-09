--[[ 
	Plugin Box.
	The Manager Plugins for PlayStation®Vita.
	
	Licensed by GNU General Public License v3.0
	
	Designed By:
	- DevDavisNunez (https://twitter.com/DevDavisNunez).
	
	Version 0.2 at 10:00 am - 09/01/18
	
]]

color.loadpalette()

-- stdout
console.init()
console.clear(color.new(0,0,0,0))
--console.bgcolor(color.new(0,0,0,0))
function print(...) -- Hook a print to debug with console module :)
	console.print(string.format(...))
	console.render()
	screen.flip()
end

dofile("utils.lua")
dofile("tai.lua")
print("PluginBox Beta 0.2 - Designed by DevDavisNunez\n")
if files.exists("ux0:/tai/config.txt") then
	console.txtcolor(color.red)
	print("Exists Config in ux0, will be deleted!\n")
	console.txtcolor(color.white)
end
print("Loading a Config in ur0!\n")
tai.load("ur0:/tai/config.txt") -- First load config.txt
console.txtcolor(color.cyan)
print("Check if exists a SD2VITA driver file...")
if files.exists("ur0:/tai/gamesd.skprx") then
	console.txtcolor(color.green)
	print("Ok\n")
else
	console.txtcolor(color.red)
	print("Fail, installing!\n")
	files.copy("gamesd.skprx", "ur0:/tai/")
end
console.txtcolor(color.cyan)
print("Check if exists a SD2VITA driver config...")
if tai.find("KERNEL", "ur0:/tai/gamesd.skprx") then
	console.txtcolor(color.green)
	print("Ok\n")
	console.txtcolor(color.white)
	print("Press X to exit!\n")
	while not buttons.cross do
		buttons.read()
	end
	os.exit()
else
	console.txtcolor(color.red)
	print("Fail\n")
	console.txtcolor(color.white)
	print("The driver will be installed in a moment\n")
	print("Installing...")
	local res = tai.put("KERNEL", "ur0:/tai/gamesd.skprx")
	tai.sync()
	if res then
		console.txtcolor(color.green)
		print("Ok\n")
	else
		console.txtcolor(color.red)
		print("Fail\n")
	end
	console.txtcolor(color.white)
	print("Press X to restart the console!\n")
	while not buttons.cross do
		buttons.read()
	end
	power.restart()
end
