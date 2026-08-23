-- Resolves module name collision between promise-async (needed by nvim-ufo as a
-- callable) and async.nvim (needed by refactoring.nvim for .run/.await/.wrap).
-- This file sits in the user config lua/ dir, which Neovim prepends to rtp, so
-- it wins over both plugin-provided async.lua files.
local data = vim.fn.stdpath('data')

-- Load promise-async's async.lua directly via loadfile to avoid require('async')
-- recursion. Its Async table has a __call metamethod so async(fn) works (nvim-ufo).
local pa_chunk, pa_err = loadfile(data .. '/lazy/promise-async/lua/async.lua')
if not pa_chunk then
  error('async shim: could not load promise-async: ' .. (pa_err or ''))
end
local Async = pa_chunk()

-- Load async.nvim's async.lua via loadfile so its Neovim auto-config runs.
-- Its M table has .run/.await/.pawait/.wrap/.iter etc. (refactoring.nvim).
local an_chunk = loadfile(data .. '/lazy/async.nvim/lua/async.lua')
if an_chunk then
  local an = an_chunk()
  -- Graft async.nvim's methods onto promise-async's Async.
  -- No name collisions: promise-async uses .sync/.wait; async.nvim uses .run/.await/.wrap.
  Async.run      = an.run
  Async.await    = an.await
  Async.pawait   = an.pawait
  Async.wrap     = an.wrap
  Async.iter     = an.iter
  Async.sleep    = an.sleep
  Async.timeout  = an.timeout
  Async.semaphore = an.semaphore
  Async.config   = an.config
  Async.init     = an.init
end

return Async
