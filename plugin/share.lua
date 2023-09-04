local share = require("share.api")

vim.api.nvim_create_user_command("SnippetShare", share.create_from_buffer, {
    nargs = "?",
    desc = "Create a code share from the current buffer selection.",
    range = true,
})

vim.api.nvim_create_user_command("SnippetShareFromFile", share.create_from_file, {
    nargs = "?",
    desc = "Create a code share from the current buffer.",
    range = false,
})
