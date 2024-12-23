---@param cmd string
local function execute_command(cmd)
	local handle = io.popen(cmd)

	if handle == nil then
		os.exit(1)
	end
	local result = handle:read("*a")
	handle:close()

	return result
end

local M = {}

---@param executable string
M.find_derivation_path = function(executable)
	local exec_path = execute_command(string.format("which %s", executable))
	local derivation_exec_path = execute_command(string.format("readlink -f %s", exec_path))

	return string.match(derivation_exec_path, "(/nix/store/.-/)")
end

return M
