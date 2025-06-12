local plugins = {
  "github/copilot.vim",
  lazy = false,
  enabled = not vim.g.vscode,
  config = function()  -- Mapping tab is already used by NvChad
    vim.g.copilot_no_tab_map = true;
    vim.g.copilot_assume_mapped = true;
    vim.api.nvim_set_keymap("i", "<C-g>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

    -- vim.g.copilot_tab_fallback = "";
  -- The mapping is set to other key, see custom/lua/mappings
  -- or run <leader>ch to see copilot mapping section
  end
}

return plugins
