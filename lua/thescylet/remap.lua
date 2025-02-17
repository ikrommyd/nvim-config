vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-b>", "<cmd>silent !tmux neww tmux-windowizer<CR>")

vim.keymap.set("n", "<leader>f", function()
    local filetype = vim.bo.filetype
    if filetype == "python" then
        -- Use ruff for formatting Python files
        -- This assumes that you have configured ruff_lsp to be recognized and used for formatting.
        -- You might need to adjust this command based on how ruff is configured in your setup.
        local clients = vim.lsp.buf_get_clients()
        for _, client in pairs(clients) do
            if client.name == "ruff" then
                -- Trigger formatting using ruff
                vim.lsp.buf.format({ async = true, filter = function(client) return client.name == "ruff" end })
                return
            end
        end
        -- Fallback to default LSP formatting if ruff_lsp is not available
        vim.lsp.buf.format({ async = true })
    else
        -- For non-Python files, just use the default LSP formatting
        vim.lsp.buf.format({ async = true })
    end
end)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set("n", "<leader>nh", "<cmd>noh<CR>")

vim.keymap.set("n", "<leader>gc", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })
