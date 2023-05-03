local colors = require("theme").get_colors("base_30")

return {
  TabLineHead = {
    fg = colors.black2,
    bg = colors.teal,
  },
  TabLine = {
    fg = colors.white,
    bg = colors.one_bg3,
  },
  TabLineInactive = {
    fg = colors.white,
    bg = colors.statusline,
  },
  TabLineInactiveSep = {
    fg = colors.black,
    bg = colors.black,
  },
  TabLineSel = {
    fg = colors.white,
    bg = colors.grey,
  },
  TabLineFill = {
    fg = colors.light_grey,
    bg = colors.statusline,
  }
}
