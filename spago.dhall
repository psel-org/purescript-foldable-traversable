{ name = ""
, dependencies =
      [ "bifunctors"
      , "const"
      , "control"
      , "either"
      , "functors"
      , "identity"
      , "maybe"
      , "newtype"
      , "orders"
      , "prelude"
      , "tuples"
      ]
    # [ "assert", "math", "integers", "console", "effect", "unsafe-coerce" ]
, packages =
    https://raw.githubusercontent.com/psel-org/package-sets/main/src/el-0.14.5-20211116/packages.dhall
, backend = "psel"
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
