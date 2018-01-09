net = {zock = nil}
function bool2msg(v)
	if v then return "Ok"
	else return "Fail"
	end
end
function net.connect(ip,port)
	net.zock = socket.connect(ip,port)
end

function net.print(text)
	if net.zock then
		net.zock:send(text)
	end
end

--print(string.char(33).."["..(10)..";"..(12).."H")

function println(...)
	net.print(string.format(...))
	--files.write("Depuracion.txt",string.format(...),"a+")
end
--net.connect("192.168.1.79", 18194)

function trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

--[[
	## Library Scroll ##
	Designed By DevDavis (Davis Nuñez) 2011 - 2017.
	Based on library of Robert Galarga.
	Create a obj scroll, this is very usefull for list show
	]]
function newScroll(a,b,c)
	local obj = {ini=1,sel=1,lim=1,maxim=1,minim = 1}
	function obj:set(tab,mxn,modemintomin) -- Set a obj scroll
		obj.ini,obj.sel,obj.lim,obj.maxim,obj.minim = 1,1,1,1,1
		--os.message(tostring(type(tab)))
		if(type(tab)=="number")then
			if tab > mxn then obj.lim=mxn else obj.lim=tab end
			obj.maxim = tab
		else
			if #tab > mxn then obj.lim=mxn else obj.lim=#tab end
			obj.maxim = #tab
		end
		if modemintomin then obj.minim = obj.lim end
	end
	function obj:max(mx)
		obj.maxim = #mx
	end
	function obj:up()
		if obj.sel>obj.ini then obj.sel=obj.sel-1
		elseif obj.ini-1>=obj.minim then
			obj.ini,obj.sel,obj.lim=obj.ini-1,obj.sel-1,obj.lim-1
		end
	end
	function obj:down()
		if obj.sel<obj.lim then obj.sel=obj.sel+1
		elseif obj.lim+1<=obj.maxim then
			obj.ini,obj.sel,obj.lim=obj.ini+1,obj.sel+1,obj.lim+1
		end
	end
	function obj:test(x,y,h,tabla,high,low,size)
		local py = y
		for i=obj.ini,obj.lim do 
			if i==obj.sel then screen.print(x,py,tabla[i],size,high)
			else screen.print(x,py,tabla[i],size,low)
			end
			py += h
		end
	end
	if a and b then
		obj:set(a,b,c)
	end
	return obj
end

function files.write(path,data,mode) -- Write a file.
	local fp = io.open(path, mode or "w+");
	if fp == nil then return end
	fp:write(data);
	fp:flush();
	fp:close();
end

function files.read(path,mode) -- Read a file.
	local fp = io.open(path, mode or "r")
	if not fp then return nil end
	local data = fp:read("*a")
	fp:close()
	return data
end