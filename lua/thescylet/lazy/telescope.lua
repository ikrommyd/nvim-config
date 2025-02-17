return {
    "nvim-telescope/telescope.nvim",

    branch = "0.1.x",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
    },

    config = function()
        local telescope = require('telescope')
        telescope.setup({})
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

        local ts_select_dir_for_grep = function(prompt_bufnr)
          local action_state = require("telescope.actions.state")
          local fb = require("telescope").extensions.file_browser
          local live_grep = require("telescope.builtin").live_grep
          local current_line = action_state.get_current_line()

          fb.file_browser({
            files = false,
            depth = false,
            attach_mappings = function(prompt_bufnr)
              require("telescope.actions").select_default:replace(function()
                local entry_path = action_state.get_selected_entry().Path
                local dir = entry_path:is_dir() and entry_path or entry_path:parent()
                local relative = dir:make_relative(vim.fn.getcwd())
                local absolute = dir:absolute()

                live_grep({
                  results_title = relative .. "/",
                  cwd = absolute,
                  default_text = current_line,
                })
              end)

              return true
            end,
          })
        end

        vim.keymap.set('n', '<C-f>', ts_select_dir_for_grep, {})
        vim.keymap.set('i', '<C-f>', ts_select_dir_for_grep, {})

    end
}

