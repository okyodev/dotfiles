vim.cmd.highlight("clear")
vim.g.colors_name = "retrolegends"

local t = require("config.theme")

local hi = function(name, val)
	vim.api.nvim_set_hl(0, name, val)
end

-- Terminal colors (ANSI 0-15)
vim.g.terminal_color_0 = t.black
vim.g.terminal_color_1 = t.red
vim.g.terminal_color_2 = t.green
vim.g.terminal_color_3 = t.yellow
vim.g.terminal_color_4 = t.blue
vim.g.terminal_color_5 = t.magenta
vim.g.terminal_color_6 = t.cyan
vim.g.terminal_color_7 = t.white
vim.g.terminal_color_8 = t.bright_black
vim.g.terminal_color_9 = t.bright_red
vim.g.terminal_color_10 = t.bright_green
vim.g.terminal_color_11 = t.bright_yellow
vim.g.terminal_color_12 = t.bright_blue
vim.g.terminal_color_13 = t.bright_magenta
vim.g.terminal_color_14 = t.bright_cyan
vim.g.terminal_color_15 = t.bright_white

-------------------------------------------------------------------------------
-- UI
-------------------------------------------------------------------------------
hi("Normal", { fg = t.fg, bg = t.bg })
hi("NormalFloat", { fg = t.fg, bg = t.bg })
hi("FloatBorder", { fg = t.bright_black, bg = t.bg })
hi("Pmenu", { fg = t.fg, bg = t.black })
hi("PmenuSel", { fg = t.highlight_fg, bg = t.highlight_bg })
hi("PmenuSbar", { bg = t.black })
hi("PmenuThumb", { bg = t.bright_black })
hi("WinSeparator", { fg = t.bright_black, bg = t.bg })
hi("VertSplit", { link = "WinSeparator" })
hi("StatusLine", { fg = t.fg, bg = t.black })
hi("StatusLineNC", { fg = t.bright_black, bg = t.bg })
hi("TabLine", { fg = t.bright_black, bg = t.bg })
hi("TabLineSel", { fg = t.fg, bg = t.bg })
hi("TabLineFill", { bg = t.bg })
hi("CursorLine", { bg = t.black })
hi("CursorLineNr", { fg = t.fg, bold = true })
hi("CursorColumn", { bg = t.black })
hi("ColorColumn", { bg = t.black })
hi("LineNr", { fg = t.bright_black })
hi("SignColumn", { fg = t.bright_black, bg = t.bg })
hi("FoldColumn", { fg = t.bright_black, bg = t.bg })
hi("Folded", { fg = t.bright_black, bg = t.black })
hi("Visual", { bg = t.highlight_bg })
hi("VisualNOS", { bg = t.highlight_bg })
hi("Search", { fg = t.bg, bg = t.bright_yellow })
hi("IncSearch", { fg = t.bg, bg = t.yellow })
hi("CurSearch", { fg = t.bg, bg = t.bright_yellow, bold = true })
hi("MatchParen", { fg = t.bright_yellow, bold = true })
hi("NonText", { fg = t.bright_black })
hi("SpecialKey", { fg = t.bright_black })
hi("EndOfBuffer", { fg = t.bg })
hi("Directory", { fg = t.cyan })
hi("Title", { fg = t.fg, bold = true })
hi("Question", { fg = t.cyan })
hi("MoreMsg", { fg = t.cyan })
hi("ModeMsg", { fg = t.bright_green })
hi("ErrorMsg", { fg = t.bright_red })
hi("WarningMsg", { fg = t.bright_yellow })
hi("WildMenu", { fg = t.bg, bg = t.fg })
hi("Cursor", { fg = t.bg, bg = t.fg })
hi("lCursor", { link = "Cursor" })
hi("CursorIM", { link = "Cursor" })

-------------------------------------------------------------------------------
-- Syntax (generic vim groups)
-------------------------------------------------------------------------------
hi("Comment", { fg = t.bright_black, italic = true })
hi("Constant", { fg = t.yellow })
hi("String", { fg = t.white })
hi("Character", { fg = t.white })
hi("Number", { fg = t.yellow })
hi("Boolean", { fg = t.yellow })
hi("Float", { fg = t.yellow })
hi("Identifier", { fg = t.fg })
hi("Function", { fg = t.cyan })
hi("Statement", { fg = t.magenta, bold = true })
hi("Conditional", { fg = t.magenta, bold = true })
hi("Repeat", { fg = t.magenta, bold = true })
hi("Label", { fg = t.magenta, bold = true })
hi("Operator", { fg = t.bright_cyan })
hi("Keyword", { fg = t.magenta, bold = true })
hi("Exception", { fg = t.magenta, bold = true })
hi("PreProc", { fg = t.magenta })
hi("Include", { fg = t.magenta })
hi("Define", { fg = t.magenta })
hi("Macro", { fg = t.magenta })
hi("PreCondit", { fg = t.magenta })
hi("Type", { fg = t.blue })
hi("StorageClass", { fg = t.blue })
hi("Structure", { fg = t.blue })
hi("Typedef", { fg = t.blue })
hi("Special", { fg = t.magenta })
hi("SpecialChar", { fg = t.magenta })
hi("Tag", { fg = t.cyan })
hi("Delimiter", { fg = t.fg })
hi("Debug", { fg = t.red })
hi("Underlined", { fg = t.cyan, underline = true })
hi("Error", { fg = t.bright_white, bg = t.red })
hi("Todo", { fg = t.bg, bg = t.yellow, bold = true })

-------------------------------------------------------------------------------
-- Diff
-------------------------------------------------------------------------------
hi("DiffAdd", { fg = t.green, bg = "#1a2e1a" })
hi("DiffDelete", { fg = t.red, bg = "#2e1a1a" })
hi("DiffChange", { fg = t.yellow, bg = "#2e2e1a" })
hi("DiffText", { fg = t.bg, bg = t.yellow, bold = true })
hi("Added", { fg = t.green })
hi("Changed", { fg = t.cyan })
hi("Removed", { fg = t.bright_red })

-------------------------------------------------------------------------------
-- LSP Diagnostics
-------------------------------------------------------------------------------
hi("DiagnosticError", { fg = t.bright_red })
hi("DiagnosticWarn", { fg = t.bright_yellow })
hi("DiagnosticInfo", { fg = t.cyan })
hi("DiagnosticHint", { fg = t.bright_cyan })
hi("DiagnosticOk", { fg = t.green })
hi("DiagnosticUnderlineError", { sp = t.red, undercurl = true })
hi("DiagnosticUnderlineWarn", { sp = t.yellow, undercurl = true })
hi("DiagnosticUnderlineInfo", { sp = t.fg, undercurl = true })
hi("DiagnosticUnderlineHint", { sp = t.fg, undercurl = true })
hi("DiagnosticUnderlineOk", { sp = t.green, undercurl = true })

-------------------------------------------------------------------------------
-- Treesitter
-------------------------------------------------------------------------------
-- Variables
hi("@variable", { fg = t.fg })
hi("@variable.builtin", { fg = t.yellow })
hi("@variable.member", { fg = t.fg })
hi("@variable.parameter", { fg = t.fg, italic = true })
hi("@constant", { fg = t.yellow })
hi("@constant.builtin", { fg = t.yellow })
hi("@constant.macro", { fg = t.yellow })
hi("@module", { fg = t.fg })
hi("@module.builtin", { fg = t.yellow })
hi("@label", { fg = t.bright_cyan })

-- Literals
hi("@string", { fg = t.white })
hi("@string.documentation", { fg = t.white })
hi("@string.escape", { fg = t.magenta })
hi("@string.regexp", { fg = t.magenta })
hi("@string.special", { fg = t.magenta })
hi("@character", { fg = t.white })
hi("@character.special", { fg = t.magenta })
hi("@boolean", { fg = t.yellow })
hi("@number", { fg = t.yellow })
hi("@number.float", { fg = t.yellow })

-- Types
hi("@type", { fg = t.blue })
hi("@type.builtin", { fg = t.blue })
hi("@type.definition", { fg = t.blue })
hi("@type.qualifier", { fg = t.magenta })
hi("@attribute", { fg = t.magenta })
hi("@attribute.builtin", { fg = t.magenta })
hi("@property", { fg = t.white })

-- Functions
hi("@function", { fg = t.cyan })
hi("@function.builtin", { fg = t.cyan })
hi("@function.call", { fg = t.cyan })
hi("@function.macro", { fg = t.cyan })
hi("@function.method", { fg = t.cyan })
hi("@function.method.call", { fg = t.cyan })
hi("@constructor", { fg = t.cyan })

-- Keywords
hi("@keyword", { fg = t.magenta, bold = true })
hi("@keyword.coroutine", { fg = t.magenta, bold = true })
hi("@keyword.function", { fg = t.magenta, bold = true })
hi("@keyword.operator", { fg = t.magenta, bold = true })
hi("@keyword.import", { fg = t.magenta, bold = true })
hi("@keyword.type", { fg = t.magenta, bold = true })
hi("@keyword.modifier", { fg = t.magenta, bold = true })
hi("@keyword.repeat", { fg = t.magenta, bold = true })
hi("@keyword.return", { fg = t.magenta, bold = true })
hi("@keyword.debug", { fg = t.magenta, bold = true })
hi("@keyword.exception", { fg = t.magenta, bold = true })
hi("@keyword.conditional", { fg = t.magenta, bold = true })
hi("@keyword.conditional.ternary", { fg = t.bright_cyan })
hi("@keyword.directive", { fg = t.magenta })
hi("@keyword.directive.define", { fg = t.magenta })

-- Operators & punctuation
hi("@operator", { fg = t.bright_cyan })
hi("@punctuation.delimiter", { fg = t.bright_cyan })
hi("@punctuation.bracket", { fg = t.fg }) -- overridden by rainbow-delimiters
hi("@punctuation.special", { fg = t.magenta })

-- Comments
hi("@comment", { fg = t.bright_black, italic = true })
hi("@comment.documentation", { fg = t.bright_black, italic = true })
hi("@comment.error", { fg = t.bright_red })
hi("@comment.warning", { fg = t.bright_yellow })
hi("@comment.todo", { fg = t.bg, bg = t.yellow, bold = true })
hi("@comment.note", { fg = t.cyan })

-- Tags (HTML/JSX)
hi("@tag", { fg = t.cyan })
hi("@tag.attribute", { fg = t.yellow })
hi("@tag.delimiter", { fg = t.bright_cyan })
hi("@tag.builtin", { fg = t.cyan })

-------------------------------------------------------------------------------
-- Plugins: NeoTree
-------------------------------------------------------------------------------
hi("NeoTreeNormal", { fg = t.fg, bg = t.bg })
hi("NeoTreeNormalNC", { fg = t.fg, bg = t.bg })
hi("NeoTreeDirectoryIcon", { fg = t.cyan })
hi("NeoTreeDirectoryName", { fg = t.cyan })
hi("NeoTreeRootName", { fg = t.fg, bold = true })
hi("NeoTreeFileName", { fg = t.fg })
hi("NeoTreeGitAdded", { fg = t.green })
hi("NeoTreeGitModified", { fg = t.yellow })
hi("NeoTreeGitDeleted", { fg = t.red })
hi("NeoTreeGitUntracked", { fg = t.yellow })
hi("NeoTreeGitIgnored", { fg = t.bright_black })

-------------------------------------------------------------------------------
-- Plugins: Rainbow Delimiters
-------------------------------------------------------------------------------
hi("RainbowDelimiterRed", { fg = t.fg })
hi("RainbowDelimiterYellow", { fg = t.cyan })
hi("RainbowDelimiterBlue", { fg = t.yellow })
hi("RainbowDelimiterOrange", { fg = t.magenta })
hi("RainbowDelimiterGreen", { fg = t.blue })
hi("RainbowDelimiterViolet", { fg = t.bright_cyan })
hi("RainbowDelimiterCyan", { fg = t.bright_green })
