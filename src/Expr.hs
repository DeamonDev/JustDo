module Expr where

-- our enum type
data Expr = Token
          | EasterEgg
          | Generate Expr
          | And Expr Expr
      deriving ( Show, Eq )