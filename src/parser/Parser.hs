{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Parser where

import Expr

parse :: [String] -> Expr
parse ["--token"] = Token
parse ["--easteregg"] = EasterEgg
parse ["--show"] = ShowTodos 
parse [x, y] = case x of 
  "--generate" -> Generate $ parse [y]
  "--add"      -> AddTodo y
  "--rm"       -> RemoveTodo $ read y 
  "--done"     -> Done $ read y
  "--undone"   -> Undone $ read y 
parse (x:y:ys) = case x of 
  "--generate" -> And (Generate $ parse [y]) (parse ys)
  "--add"      -> And (AddTodo y) (parse ys)
  "--rm"       -> And (RemoveTodo $ read y) (parse ys)
