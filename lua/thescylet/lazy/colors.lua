function ColorMyPencils(color)
	color = color or "onedark"
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

return {
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function()
            require("gruvbox").setup({
              terminal_colors = true, -- add neovim terminal colors
              undercurl = true,
              underline = true,
              bold = false,
              italic = {
                strings = false,
                emphasis = false,
                comments = false,
                operators = false,
                folds = false,
              },
              strikethrough = true,
              invert_selection = false,
              invert_signs = false,
              invert_tabline = false,
              invert_intend_guides = false,
              inverse = true, -- invert background for search, diffs, statuslines and errors
              contrast = "", -- can be "hard", "soft" or empty string
              palette_overrides = {},
              overrides = {},
              dim_inactive = false,
              transparent_mode = false,
            })
            ColorMyPencils()
        end
    },
    {
        "navarasu/onedark.nvim",
        name = "onedark",
        config = function()
            require("onedark").setup({
                style = "warmer",
                transparent = false,
                term_colors = true,
            })
            ColorMyPencils()
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                styles = {
                    bold = true,
                    italic = false,
                    transparency = false,
                },
                highlight_groups = {
                    Comment = { italic = true },
                },
            })
            ColorMyPencils()
        end
    },
}
