{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module TodoItem where

import Control.Applicative
import Control.Lens
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow

data TodoItem = TodoItem
  { _id :: Int,
    _title :: String,
    _done :: Bool
  }
  deriving (Show)

$(makeLenses ''TodoItem)

instance FromRow TodoItem where
  fromRow = TodoItem <$> field <*> field <*> field

instance ToRow TodoItem where
  toRow (TodoItem _id _title _done) = toRow (_id, _title, _done)


lastRowId :: Connection -> IO Int
lastRowId conn =
  do
    xs <- query_ conn "SELECT id, description, done FROM todo_items;" :: IO [TodoItem]
    let ys = map (^. TodoItem.id) xs
    return $ last ys

insertTodo :: Connection -> String -> IO ()
insertTodo conn desc =
  do
    rowId <- lastRowId conn
    print rowId
    execute
      conn
      "INSERT INTO todo_items (id, description, done) VALUES (?,?,?)"
      (TodoItem (rowId + 1) desc False)

getAllTodos :: Connection -> IO [TodoItem]
getAllTodos conn = query_ conn "SELECT id, description, done FROM todo_items;" :: IO [TodoItem]

markAsDone :: TodoItem -> TodoItem
markAsDone todo = if todo ^. done then todo else set done True todo

markAsUndone :: TodoItem -> TodoItem
markAsUndone todo = if todo ^. done then set done False todo else todo