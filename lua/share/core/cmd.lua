local utils = require("share.core.utils")
local M = {}

--- Creates a code share with the specified filename and description
--
-- @param filename string The filename of the Crate
-- @param content string|nil The content of the Crate
-- @return string|nil The URL of the created Crate
-- @return number|nil The error of the command
function M.create_share(file_extention, content)
    local host = os.getenv("SHARE_HOST") or "https://share.alexxi.dev"

    -- Write to tmp file
    local tmp = os.tmpname()
    local file = io.open(tmp, "w")
    if file == nil then
        return nil, "Could not open tmp file"
    end
    file:write(content)
    file:close()

    local cmd = string.format(
        'curl -s -X POST -H "ext: %s" --data-binary @%s %s',
        file_extention,
        tmp,
        host
    )

    local handle = io.popen(cmd)
    if handle == nil then
        return nil, "Could not open pipe"
    end
    local output = handle:read("*a")
    handle:close()


    -- Check for errors
    if vim.v.shell_error ~= 0 then
        print(vim.v.shell_error)
        return nil, table.concat(output, "\n")
    end

    return output, nil
end

return M
