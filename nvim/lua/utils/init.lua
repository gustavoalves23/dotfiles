local function Sed(line_nr, from, to, fname)
  vim.cmd(string.format("silent !sed -i '%ss/%s/%s/' %s", line_nr, from, to, fname))
end

-- Show macro recording for lualine
local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return 'Recording @' .. recording_register
  end
end

-- Get keys from table
local function get_table_keys(t)
  local keys = {}
  for key, _ in pairs(t) do
    table.insert(keys, key)
  end
  return keys
end

local function get_attached_lsps()
  local buf_clients = vim.lsp.get_clients()
  local buf_client_names = {}
  for _, client in pairs(buf_clients) do
    table.insert(buf_client_names, client.name)
  end
  return buf_client_names
end

-- Debounce
local function debounce(ms, fn)
  local timer = vim.loop.new_timer()
  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end


local function sort_lines_by_character_count(args)
  local lines_count = args.count

  if lines_count == -1 then
    return
  end

  local start_line, end_line = args.line1, args.line2
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  table.sort(lines, function(a, b) return #a < #b end)
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
end

local slow_format_filetypes = {}

return {
  Sed = Sed,
  debounce = debounce,
  get_table_keys = get_table_keys,
  get_attached_lsps = get_attached_lsps,
  show_macro_recording = show_macro_recording,
  slow_format_filetypes = slow_format_filetypes,
  sort_lines_by_character_count = sort_lines_by_character_count,
}
