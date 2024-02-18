return {
  trouble_next = function()
    local trouble = require('trouble')
    if not (trouble.is_open()) then trouble.open() end
    trouble.next({ skip_groups = true, jump = true })
  end,
  trouble_prev = function()
    local trouble = require('trouble')
    if not (trouble.is_open()) then trouble.open() end
    trouble.previous({ skip_groups = true, jump = true })
  end,
}
