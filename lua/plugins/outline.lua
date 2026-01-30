return {
  "simrat39/symbols-outline.nvim",
  cmd = "SymbolsOutline",
  keys = {
    { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" },
  },
  config = function()
    local icons = require("lazyvim.config").icons
    require("symbols-outline").setup({
      symbols = {
        File = { icon = icons.kinds.File, hl = "TSURI" },
        Module = { icon = icons.kinds.Module, hl = "TSNamespace" },
        Namespace = { icon = icons.kinds.Namespace, hl = "TSNamespace" },
        Package = { icon = icons.kinds.Package, hl = "TSNamespace" },
        Class = { icon = icons.kinds.Class, hl = "TSClass" },
        Method = { icon = icons.kinds.Method, hl = "TSMethod" },
        Property = { icon = icons.kinds.Property, hl = "TSMethod" },
        Field = { icon = icons.kinds.Field, hl = "TSField" },
        Constructor = { icon = icons.kinds.Constructor, hl = "TSConstructor" },
        Enum = { icon = icons.kinds.Enum, hl = "TSEnum" },
        Interface = { icon = icons.kinds.Interface, hl = "TSInterface" },
        Function = { icon = icons.kinds.Function, hl = "TSFunction" },
        Variable = { icon = icons.kinds.Variable, hl = "TSVariable" },
        Constant = { icon = icons.kinds.Constant, hl = "TSConstant" },
        String = { icon = icons.kinds.String, hl = "TSString" },
        Number = { icon = icons.kinds.Number, hl = "TSNumber" },
        Boolean = { icon = icons.kinds.Boolean, hl = "TSBoolean" },
        Array = { icon = icons.kinds.Array, hl = "TSArray" },
        Object = { icon = icons.kinds.Object, hl = "TSObject" },
        Key = { icon = icons.kinds.Key, hl = "TSKeyword" },
        Null = { icon = icons.kinds.Null, hl = "TSNone" },
        EnumMember = { icon = icons.kinds.EnumMember, hl = "TSEnumMember" },
        Struct = { icon = icons.kinds.Struct, hl = "TSStruct" },
        Event = { icon = icons.kinds.Event, hl = "TSEvent" },
        Operator = { icon = icons.kinds.Operator, hl = "TSOperator" },
        TypeParameter = { icon = icons.kinds.TypeParameter, hl = "TSTypeParameter" },
      },
    })
  end,
}