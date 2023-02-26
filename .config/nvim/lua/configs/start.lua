local alpha = require('alpha')
local dashboard = require('alpha.themes.startify')

dashboard.section.header.val = {} -- clear header art
dashboard.section.mru.val = {}

alpha.setup(dashboard.config)
