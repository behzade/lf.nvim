if vim.fn.exists('g:loaded_lf_hijack') ~= 0 then
    return
end

local autocmd = vim.api.nvim_create_autocmd

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

autocmd({ "BufEnter" }, {
    group = 'lf_hijack',
    pattern = { "*" },
    nested = true,
    callback = hijack_directory
})

local delete_term_buf = function(event)
    if (vim.fn.len(vim.fn.win_findbuf(event.buf)) > 0) then
        if (event.match ~= "UnceptionEditRequestReceived" and #vim.fn.getbufinfo({ buflisted = 1 })) == 1 then
            vim.cmd("q")
        end
        vim.cmd("silent bdelete! " .. event.buf)
    end
end

autocmd({ "TermClose" }, {
    pattern = { "*" },
    callback = delete_term_buf
})

autocmd({ "User" }, {
    pattern = { "UnceptionEditRequestReceived" },
    callback = delete_term_buf
})
