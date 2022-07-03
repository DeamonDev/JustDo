{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Interpreter where

import Expr
import GHC.IO

-- IO (Either () String) is our value type, since some computations should not be printed
-- into terminal window (e.g. reading/writing to db)
execute :: Expr -> IO (Either () String)
execute (Generate Token) = return $ Right "Generated token 17"
execute (Generate EasterEgg) = return $ Right "Generated easter egg: cats are fun"
execute (AddTodo todoDescription) = return $ Right $ "todo: " ++ todoDescription
execute (And e1 e2) = do
  s1 <- execute e1
  s2 <- execute e2
  case (s1, s2) of
    (Left (), Left ()) -> return $ Left ()
    (Left (), Right s2') -> return $ Right s2'
    (Right s1', Left ()) -> return $ Right s1'
    (Right s1', Right s2') -> return $ Right (s1' ++ " And " ++ s2')