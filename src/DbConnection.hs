{-# LANGUAGE OverloadedStrings #-}

module DbConnection where

import Control.Lens
import Database.SQLite.Simple
import TodoItem (TodoItem (TodoItem), id)

class DbConnection a where
  lastRowId :: a -> IO Int
  insertTodo :: a -> String -> IO ()
  getAllTodos :: a -> IO [TodoItem]
  markAsDone :: a -> Int -> IO ()
  markAsUndone :: a -> Int -> IO () 

instance DbConnection Connection where
  lastRowId conn = do
    xs <- query_ conn "SELECT id, description, done FROM todo_items;" :: IO [TodoItem]
    let ys = if null xs then [0] else map (^. TodoItem.id) xs
    return $ last ys

  insertTodo conn desc = do
    rowId <- lastRowId conn
    print rowId
    execute
      conn
      "INSERT INTO todo_items (id, description, done) VALUES (?,?,?)"
      (TodoItem (rowId + 1) desc False)

  getAllTodos conn = query_ conn "SELECT id, description, done FROM todo_items;" :: IO [TodoItem]

  markAsDone conn idx = do 
    execute 
      conn 
      "UPDATE todo_items SET done = 1 WHERE id = ?" (Only idx)

  markAsUndone conn idx = do 
    execute 
      conn 
      "UPDATE todo_items SET done = 0 WHERE id = ?" (Only idx)
