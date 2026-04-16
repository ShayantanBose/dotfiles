local M = {}

local function is_nvchad_mode()
  local ok_nvconfig, nvconfig = pcall(require, "nvconfig")
  return ok_nvconfig and nvconfig.base46 and vim.g.colorscheme == "nvchad"
end

local manual_groups = {
  "Normal",
  "NormalNC",
  "NormalSB",
  "NormalFloat",
  "FloatBorder",
  "SignColumn",
  "LineNr",
  "CursorLine",
  "CursorLineNr",
  "CursorColumn",
  "ColorColumn",
  "Folded",
  "FoldColumn",
  "CursorLineFold",
  "EndOfBuffer",
  "StatusLine",
  "StatusLineNC",
  "TabLine",
  "TabLineFill",
  "TabLineSel",
  "WinBar",
  "WinBarNC",
  "MsgArea",
  "MsgSeparator",
  "WinSeparator",
  "NvimTreeNormal",
  "NvimTreeNormalNC",
  "NvimTreeEndOfBuffer",
  "NvimTreeVertSplit",
  "WhichKeyNormal",
  "WhichKeyFloat",
  "WhichKeyBorder",
  "TelescopeNormal",
  "TelescopeBorder",
  "TelescopePromptNormal",
  "TelescopePromptBorder",
  "TelescopeResultsNormal",
  "TelescopePreviewNormal",
  "BufferLineFill",
  "BufferLineBackground",
  "BufferLineBufferVisible",
  "BufferLineBuffer",
  "BufferLineTab",
  "BufferLineTabClose",
  "BufferLineTabSelected",
  "BufferLineSeparator",
  "BufferLineSeparatorVisible",
  "BufferLineSeparatorSelected",
  "BufferLineOffsetSeparator",
  "BufferLineDuplicate",
  "BufferLineDuplicateVisible",
  "BufferLineDuplicateSelected",
  "BufferLineModified",
  "BufferLineModifiedVisible",
  "BufferLineModifiedSelected",
  "BufferLineHint",
  "BufferLineHintVisible",
  "BufferLineHintSelected",
  "BufferLineInfo",
  "BufferLineInfoVisible",
  "BufferLineInfoSelected",
  "BufferLineWarning",
  "BufferLineWarningVisible",
  "BufferLineWarningSelected",
  "BufferLineError",
  "BufferLineErrorVisible",
  "BufferLineErrorSelected",
  "BufferLineDiagnostic",
  "BufferLineDiagnosticVisible",
  "BufferLineDiagnosticSelected",
  "BufferLineDiagnosticHint",
  "BufferLineDiagnosticHintVisible",
  "BufferLineDiagnosticHintSelected",
  "BufferLineDiagnosticInfo",
  "BufferLineDiagnosticInfoVisible",
  "BufferLineDiagnosticInfoSelected",
  "BufferLineDiagnosticWarning",
  "BufferLineDiagnosticWarningVisible",
  "BufferLineDiagnosticWarningSelected",
  "BufferLineDiagnosticError",
  "BufferLineDiagnosticErrorVisible",
  "BufferLineDiagnosticErrorSelected",
  "BufferLineCloseButton",
  "BufferLineCloseButtonVisible",
  "BufferLineCloseButtonSelected",
  "BufferLineNumbers",
  "BufferLineNumbersVisible",
  "BufferLineNumbersSelected",
  "BufferLinePick",
  "BufferLinePickVisible",
  "BufferLinePickSelected",
  "BufferLineIndicatorVisible",
  "BufferLineIndicatorSelected",
  "SnacksPicker",
  "SnacksPickerBorder",
  "SnacksPickerInputBorder",
  "SnacksInputNormal",
  "SnacksInputBorder",
}

local function resolve_hl(group, seen)
  seen = seen or {}
  if seen[group] then
    return {}
  end
  seen[group] = true

  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = true })
  if not ok or type(hl) ~= "table" then
    return {}
  end

  local link = hl.link
  if type(link) == "string" and link ~= "" then
    hl.link = nil
    local linked = resolve_hl(link, seen)
    hl = vim.tbl_deep_extend("force", linked, hl)
  end

  return hl
end

local function set_bg_none(group)
  if vim.fn.hlexists(group) == 0 then
    return
  end

  local hl = resolve_hl(group)
  if next(hl) == nil then
    return
  end

  hl.bg = nil
  hl.ctermbg = nil
  vim.api.nvim_set_hl(0, group, hl)
end

local function set_transparent_hl()
  for _, group in ipairs(manual_groups) do
    set_bg_none(group)
  end

  local all_groups = vim.fn.getcompletion("", "highlight")
  for _, group in ipairs(all_groups) do
    local keep_colored = group:match("^lualine_a_")
      or group:match("^lualine_z_")
      or group:match("^St_mode")
      or group:match("^St_pos")

    if not keep_colored and (group:match("^lualine_") or group:match("^St_") or group:match("^Tb")) then
      set_bg_none(group)
    end
  end

  vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#000000" })
end

function M.apply_if_enabled()
  if is_nvchad_mode() then
    return
  end

  if vim.g._manual_transparency then
    set_transparent_hl()
  end
end

function M.toggle()
  local ok_base46, base46 = pcall(require, "base46")
  local ok_nvconfig, nvconfig = pcall(require, "nvconfig")

  if ok_base46 and ok_nvconfig and nvconfig.base46 and vim.g.colorscheme == "nvchad" then
    vim.g._manual_transparency = false
    base46.toggle_transparency()
    if nvconfig.base46.transparency then
      vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#000000" })
      vim.notify("Toggled On", vim.log.levels.INFO, { title = "Transparency" })
    else
      vim.api.nvim_set_hl(0, "NotifyBackground", { link = "Normal" })
      vim.notify("Toggled Off", vim.log.levels.INFO, { title = "Transparency" })
    end
    return
  end

  vim.g._manual_transparency = not vim.g._manual_transparency
  if vim.g._manual_transparency then
    set_transparent_hl()
    vim.notify("Toggled On", vim.log.levels.INFO, { title = "Transparency" })
  else
    pcall(vim.cmd.colorscheme, vim.g.colors_name)
    vim.api.nvim_set_hl(0, "NotifyBackground", { link = "Normal" })
    vim.notify("Toggled Off", vim.log.levels.INFO, { title = "Transparency" })
  end
end

return M
