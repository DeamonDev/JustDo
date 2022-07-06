module Expr where

-- our enum type
data Expr = Token
          | EasterEgg
          | Generate Expr
          | And Expr Expr
          | AddTodo String
          | RemoveTodo Int
          | ShowTodos
          | Done Int
          | Undone Int
      deriving ( Show, Eq )