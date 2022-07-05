{-# LANGUAGE OverloadedStrings #-}

module JustDo where

import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow ()
import Control.Applicative
import TodoItem (insertTodo)
import System.Environment.Blank (getArgs)
import Parser
import Interpreter

main :: IO ()
main = do
    args <- getArgs
    let
      expr = parse args
    conn <- open "todos.db"
    s <- exec expr conn
    _ <- case s of 
        Right(output) -> putStr output 
        Left(_) -> return ()
    close conn