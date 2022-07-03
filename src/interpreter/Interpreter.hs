{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Interpreter where

import Expr

execute :: Expr -> IO () 
execute (Generate Token)            = putStrLn "Generated token 1424108492148714277"
execute (Generate EasterEgg)        = putStrLn "Generated easter egg: cats are fun"
execute (And e1 e2)                 = execute e1 >> putStrLn " And " >> execute e2