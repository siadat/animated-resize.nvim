M = {}

-- M.animate = function(fn, current, win, keyframes)
M.animate = function(fn, current, keyframes)
  vim.defer_fn(function()
    fn(unpack(keyframes[current]))
    if current == #keyframes then
      return
    end
    M.animate(fn, current + 1, keyframes)
  end, 16)
end

M.animated_resize = function(direction)
  local total_columns = vim.o.columns
  local total_height = vim.o.lines
  if direction == "maximize" then
    local width = vim.fn.winwidth(0)
    local width_keyframes = {}
    for i = 1, 10 do
      width_keyframes[i] = {
        0,
        math.floor(width + (total_columns - width) * (1 - math.cos(i / 10 * math.pi / 2))),
      }
    end
    M.animate(vim.api.nvim_win_set_width, 1, width_keyframes)
  elseif direction == "equal" then
    -- This is just a naive implementation, it doesn't work well with complex splits
    for _,win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      local width = vim.fn.winwidth(win)
      local height = vim.fn.winheight(win)
      local width_keyframes = {}
      local height_keyframes = {}
      local rows = 1
      local cols = #vim.api.nvim_tabpage_list_wins(0)
      for i = 1, 10 do
        -- do a smooth animation to make each window width equal to total_columns/(number of windows)
        width_keyframes[i] = {
          win,
          math.floor(width + (total_columns / cols - width) * (1 - math.cos(i / 10 * math.pi / 2))),
        }
        -- do a smooth animation to make each window height equal to total_heeight/(number of windows)
        height_keyframes[i] = math.floor(height + (total_height / rows - height) * (1 - math.cos(i / 10 * math.pi / 2)))
      end
      M.animate(vim.api.nvim_win_set_width, 1, width_keyframes)
      M.animate(vim.api.nvim_win_set_height, 1, height_keyframes)
    end
  end
end

M.setup = function(_)
  vim.keymap.set('n', '<c-w>|', function() M.animated_resize("maximize") end, { noremap = true, desc = "animated-resize: maximize current window width" })
  -- vim.keymap.set('n', '<c-w>=', function() M.animated_resize("equal") end, { noremap = true, desc = "animated-resize: equal all window widths" })
end

return M
