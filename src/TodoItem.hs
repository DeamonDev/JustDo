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

markAsDone :: TodoItem -> TodoItem
markAsDone todo = if todo ^. done then todo else set done True todo

markAsUndone :: TodoItem -> TodoItem
markAsUndone todo = if todo ^. done then set done False todo else todo