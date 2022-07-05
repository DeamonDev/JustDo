{-# LANGUAGE OverloadedStrings #-}

module JustDo where

import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow ()
import Control.Applicative
import TodoItem (insertTodo)

main :: IO ()
main = do
    conn <- open "todos.db"
    _ <- insertTodo conn "stop fapping"
    close conn