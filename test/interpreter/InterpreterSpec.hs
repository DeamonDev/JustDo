{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
module InterpreterSpec where

import Interpreter (exec)
import Parser (parse)
import Test.HUnit
import Test.HUnit.Base (Test (TestCase), assertEqual)
import DbConnection
import TodoItem
import Control.Lens
import Data.List

type TestConnection = [TodoItem]

instance DbConnection TestConnection where
  lastRowId conn = do
     let ids = map (^. TodoItem.id) conn
     return $ maximum ids 

  insertTodo conn s = do 
                let ids = map (^. TodoItem.id) conn 
                    newConn = conn ++ [TodoItem (maximum ids + 1) s False]
                return ()

  getAllTodos conn = return conn

{- flags1 :: [String]
flags1 = ["--generate", "--token", "--generate", "--easteregg"]

flags2 :: [String]
flags2 = ["--add", "change my life", "--rm", "661"]

test1 :: Test
test1 = TestCase $ do
  let expr = parse flags1
      expected = "Generated token 17 And Generated easter egg: cats are fun"
  result <- exec expr
  assertEqual "flag1" (Right expected) result

test2 :: Test 
test2 = TestCase $ do 
  let expr = parse flags2 
      expected = "todo: change my life And remove: 661"
  result <- exec expr 
  assertEqual "flag2" (Right expected) result

tests :: Test
tests = TestList [test1, test2] -}