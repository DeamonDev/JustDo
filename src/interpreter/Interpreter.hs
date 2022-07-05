{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Interpreter where

import Expr
import GHC.IO
import Database.SQLite.Simple
import TodoItem

-- IO (Either () String) is our value type, since some computations should not be printed
-- into terminal window (e.g. reading/writing to db)
exec :: Expr -> Connection -> IO (Either () String)
exec (Generate Token) conn = return $ Right "Generated token 17"
exec (Generate EasterEgg) conn = return $ Right "Generated easter egg: cats are fun"
exec (AddTodo todoDescription) conn = do
                                    _ <- insertTodo conn todoDescription
                                    return $ Right $ "Insertedd todo: " ++ todoDescription
exec (RemoveTodo todoId) conn = return $ Right $ "remove: " ++ show todoId
exec (And e1 e2) conn = do
  s1 <- exec e1 conn
  s2 <- exec e2 conn
  case (s1, s2) of
    (Left (), Left ()) -> return $ Left ()
    (Left (), Right s2') -> return $ Right s2'
    (Right s1', Left ()) -> return $ Right s1'
    (Right s1', Right s2') -> return $ Right (s1' ++ " And " ++ s2')