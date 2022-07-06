{-# LANGUAGE OverloadedStrings #-}

module JustDo where

import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow ()
import Control.Applicative
import System.Environment.Blank (getArgs)
import Parser
import Interpreter
import System.Console.ANSI


main :: IO ()
main = do
    args <- getArgs
    let
      expr = parse args
    conn <- open "todos.db"
    execute_ conn "CREATE TABLE IF NOT EXISTS todo_items (id INTEGER PRIMARY KEY, description TEXT, done INTEGER);"
    _ <- exec expr conn
    close conn