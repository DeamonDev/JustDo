{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE TupleSections #-}

module Interpreter where

import Expr
import GHC.IO
import Database.SQLite.Simple
import TodoItem hiding (markAsDone)
import Control.Lens
import Data.List
import DbConnection
import Renderer

modifyDescs :: [String] -> [String] 
modifyDescs descs = 
  let xs = take (length descs) [1..]
      zipped = zip xs descs
  in map (\(x, y) -> "[" ++ show x ++ "] " ++ y) zipped

addColor :: [TodoItem] -> [TextColor]
addColor = map (\t -> if (^. done) t then JGreen else JWhite)

-- IO (Either () String) is our value type, since some computations should not be printed
-- into terminal window (e.g. reading/writing to db)
exec :: (DbConnection a) => Expr -> a -> IO ()
exec ShowTodos conn = do
                    allTodos <- getAllTodos conn 
                    let 
                      descriptions = modifyDescs $ map (^. TodoItem.title) allTodos
                      colors = addColor allTodos
                    Renderer.render $ zip descriptions colors

exec (Generate Token) conn = putStrLn "Generated token 17"

exec (Generate EasterEgg) conn = putStrLn "Generated easter egg: cats are fun"

exec (AddTodo todoDescription) conn = do
                                    _ <- insertTodo conn todoDescription
                                    putStrLn $ "Insertedd todo: " ++ todoDescription
                                    
exec (RemoveTodo todoId) conn = putStrLn $ "remove: " ++ show todoId

exec (Done todoId) conn = do 
                        _ <- markAsDone conn todoId 
                        putStrLn $ "updated todo: " ++ show todoId

exec (And e1 e2) conn = do
  s1 <- exec e1 conn
  s2 <- exec e2 conn
  return ()