{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Parser where

import Expr

parse :: [String] -> Expr
parse ["--token"] = Token
parse ["--easteregg"] = EasterEgg 
parse [x, y] = case x of 
  "--generate" -> Generate $ parse [y]
parse (x:y:ys) = case x of 
  "--generate" -> And (Generate $ parse [y]) (parse ys)