-- Autopairs configuration
local autopairs = require('nvim-autopairs')
autopairs.setup{}

-- Enable autopairs for different types of characters
autopairs.add_rules({
    { '(', ')' },
    { '[', ']' },
    { '{', '}' },
    { '\'', '\'' },
    { '"', '"' },
})

