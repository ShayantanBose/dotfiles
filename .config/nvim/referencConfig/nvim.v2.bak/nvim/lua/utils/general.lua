local M = {}

function M.system_type()
  if vim.fn.has("wsl") == 1 then
    return "wsl"
  end

  local sysname = (vim.uv.os_uname().sysname or ""):lower()
  if sysname:find("darwin") then
    return "darwin"
  end
  if sysname:find("linux") then
    return "linux"
  end

  return sysname
end

function M.term_cmd(cmd)
  local ok, out = pcall(vim.fn.system, cmd)
  if not ok or not out then
    return ""
  end
  return vim.trim(out)
end

function M.in_yadm_env(callback)
  if vim.fn.executable("yadm") == 0 then
    return nil
  end

  local yadm_repo = M.term_cmd("yadm rev-parse --show-toplevel")
  if yadm_repo == "" then
    return nil
  end

  if type(callback) == "function" then
    return callback(yadm_repo)
  end

  return yadm_repo
end

function M.switch_git_dir()
  local cwd = vim.fn.getcwd()
  local yadm_repo = M.in_yadm_env()

  if yadm_repo and cwd ~= yadm_repo then
    vim.cmd("cd " .. vim.fn.fnameescape(yadm_repo))
    vim.notify("Switched to yadm repo", vim.log.levels.INFO)
    return
  end

  local git_root = M.term_cmd("git rev-parse --show-toplevel")
  if git_root ~= "" and cwd ~= git_root then
    vim.cmd("cd " .. vim.fn.fnameescape(git_root))
    vim.notify("Switched to git root", vim.log.levels.INFO)
    return
  end

  vim.notify("No alternate repo directory found", vim.log.levels.WARN)
end

return M
