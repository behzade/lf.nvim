if vim.fn.exists('g:loaded_lf_hijack') ~= 0 then
    return
end

vim.g.loaded_lf_hijack = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.cmd('autocmd! FileExplorer *')

local function hijack_directory()
    local path = vim.fn.expand('%:p')
    if vim.fn.isdirectory(path) == 0 then
        return
    end

    if type(path) == "table" then
        path = path[0]
    end

    local bufnr = vim.fn.bufnr()
    vim.cmd(string.format('keepjumps keepalt term lf %s', vim.fn.fnameescape(path)))
    vim.cmd(string.format('silent! bwipeout %d', bufnr))
end

vim.api.nvim_create_augroup('lf_hijack', { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = 'lf_hijack',
    pattern = { "*" },
    nested = true,
    callback = hijack_directory
})
