M = {}

M.animate_width = function(win, keyframes, current)
  vim.defer_fn(function()
    vim.api.nvim_win_set_width(win, keyframes[current])
    if current == #keyframes then
      return
    end
    M.animate_width(win, keyframes, current + 1)
  end, 16)
end

M.animated_resize = function(direction)
  local total_columns = vim.o.columns
  if direction == "maximize" then
    local width = vim.fn.winwidth(0)
    local keyframes = {}
    for i = 1, 10 do
      -- do a smooth animation
      keyframes[i] = math.floor(width + (total_columns - width) * (1 - math.cos(i / 10 * math.pi / 2)))
    end
    M.animate_width(0, keyframes, 1)
  elseif direction == "equal" then
    for _,win in ipairs(vim.api.nvim_list_wins()) do
      local width = vim.fn.winwidth(win)
      local keyframes = {}
      for i = 1, 10 do
        -- do a smooth animation to make each window width equal to total_columns/(number of windows)
        keyframes[i] = math.floor(width + (total_columns / #vim.api.nvim_list_wins() - width) * (1 - math.cos(i / 10 * math.pi / 2)))
      end
      M.animate_width(win, keyframes, 1)
    end
  end
end

M.setup = function(_)
  vim.keymap.set('n', '<c-w>|', function() M.animated_resize("maximize") end, { noremap = true, desc = "animated-resize: maximize current window width" })
  vim.keymap.set('n', '<c-w>=', function() M.animated_resize("equal") end, { noremap = true, desc = "animated-resize: equal all window widths" })
end

return M
