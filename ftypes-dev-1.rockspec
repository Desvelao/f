package = "ftypes"
version = "dev-1"
source = {
   url = "git://github.com/Desvelao/ftypes",
   branch = "dev"
}
description = {
   summary = [[Functional methods for tables and strings.
   Included oop tables (like-array) too.
   ]],
   homepage = "https://github.com/Desvelao/ftypes",
   license = "MIT"
}
build = {
   type = "builtin",
   modules = {
      ["ftypes.init"] = "ftypes/init.lua",
      ["ftypes.string"] = "ftypes/string.lua",
      ["ftypes.table"] = "ftypes/table.lua"
   }
}
