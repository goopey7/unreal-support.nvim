local M = {}
M.build = function()
	print("Hello from build")
end
M.gen = function()
	print("Hello from gen")
end
M.run = function()
	print("Hello from run")
end
M.clean = function()
	print("Hello from clean")
end
M.rebuild = function()
	print("Hello from rebuild")
end
M.cook = function()
	print("Hello from cook")
end
M.engine_path = function()
	print(require("usp").engine_path)
end
return M
