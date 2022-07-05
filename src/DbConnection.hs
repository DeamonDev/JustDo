{-# LANGUAGE OverloadedStrings #-}

module DbConnection where

import Control.Lens
import Database.SQLite.Simple
import TodoItem (TodoItem (TodoItem), id)

class DbConnection a where
  lastRowId :: a -> IO Int
  insertTodo :: a -> String -> IO ()
  getAllTodos :: a -> IO [TodoItem]

instance DbConnection Connection where
  lastRowId conn = do
    xs <- query_ conn "SELECT id, description, done FROM todo_items;" :: IO [TodoItem]
    let ys = map (^. TodoItem.id) xs
    return $ last ys

  insertTodo conn desc = do
    rowId <- lastRowId conn
    print rowId
    execute
      conn
      "INSERT INTO todo_items (id, description, done) VALUES (?,?,?)"
      (TodoItem (rowId + 1) desc False)

  getAllTodos conn = query_ conn "SELECT id, description, done FROM todo_items;" :: IO [TodoItem]
