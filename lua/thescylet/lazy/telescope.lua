return {
    "nvim-telescope/telescope.nvim",

    branch = "0.1.x",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
    },

    config = function()
        local telescope = require('telescope')

        telescope.setup({
            extensions = {
                live_grep_args = {
                    mappings = {
                        i = { ["<c-f>"] = require('telescope.actions').to_fuzzy_refine },
                        n = { ["<c-f>"] = require('telescope.actions').to_fuzzy_refine },
                    },
                },
            },
            pickers = {
                grep_string = {
                    mappings = {
                        i = { ["<c-f>"] = require('telescope.actions').to_fuzzy_refine },
                        n = { ["<c-f>"] = require('telescope.actions').to_fuzzy_refine },
                    },
                }
            },
        })

        telescope.load_extension('live_grep_args')

        local builtin = require('telescope.builtin')
        -- Global variable to store the last search term
        _G.last_telescope_grep_search = nil

        local function updateAndGrep(search_term)
            _G.last_telescope_grep_search = search_term -- Store the search term
            builtin.grep_string({ search = search_term })
        end

        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            updateAndGrep(word)
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            updateAndGrep(word)
        end)
        vim.keymap.set('n', '<leader>ps', function()
            local search_term = vim.fn.input("Grep > ")
            updateAndGrep(search_term)
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

        -- New keymap for repeating the last grep search
        vim.keymap.set('n', '<leader>pr', function()
            if _G.last_telescope_grep_search then
                builtin.grep_string({ search = _G.last_telescope_grep_search })
            else
                print("No previous search term stored.")
            end
        end)

        vim.keymap.set('n', '<leader>fs', telescope.extensions.live_grep_args.live_grep_args, {})
    end
}
