local core = require("share.core.cmd")
local utils = require("share.core.utils")

local M = {}

local function create(content)
    if (content == nil) then
        content = utils.get_current_file_content()
    end

    local file_extension = vim.fn.expand("%:e")
    -- The server does not support typescript, so we convert it to javascript
    if file_extension == "ts" then
        file_extension = "js"
    end

    local url, err = core.create_share(file_extension, content)
    if not url then return end

    if err ~= nil then
        vim.api.nvim_err_writeln("Error: " .. err)
    else
        print("URL (copied to clipboard): " .. url)
        vim.fn.setreg("+", url)
    end
end

--- Creates a Share from the current selection
function M.from_buffer(opts)
    local content = nil
    local start_line = opts.line1
    local end_line = opts.line2

    if start_line ~= end_line then
        content = utils.get_current_selection(start_line, end_line)
    end

    return create(content)
end

--- Creates a Share from the current file.
function M.from_file()
    create(nil)
end

return M
