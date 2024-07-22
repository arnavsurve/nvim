return {
  "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "html",
        "css",
        "scss",
        "javascript",
        "svelte",
      })
    end,
}
