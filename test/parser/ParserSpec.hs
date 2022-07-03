module ParserSpec where

import Expr
import Parser (parse)
import Test.HUnit

test1 :: Test
test1 = TestCase (assertEqual "justdo --token" Token $ parse ["--token"])

test2 :: Test
test2 = TestCase (assertEqual "justdo --easteregg" EasterEgg $ parse ["--easteregg"])

test3 :: Test
test3 = TestCase (assertEqual "justdo --generate --token" (Generate Token) $ parse ["--generate", "--token"])

test4 :: Test
test4 = TestCase (assertEqual "justdo --generate --easteregg" (Generate EasterEgg) $ parse ["--generate", "--easteregg"])

test5 =
  TestCase
    ( assertEqual "justdo --generate --token --generate --easteregg" (And (Generate Token) (Generate EasterEgg)) $
        parse ["--generate", "--token", "--generate", "--easteregg"]
    )

test6 :: Test
test6 =
  TestCase
    ( assertEqual "justdo --add buy milk" (AddTodo "buy milk") $
        parse ["--add", "buy milk"]
    )

test7 :: Test
test7 =
  TestCase
    ( assertEqual "justdo --add buy milk" (And (AddTodo "buy milk") (AddTodo "go to gym")) $
        parse ["--add", "buy milk", "--add", "go to gym"]
    )

test8 :: Test 
test8 = 
  TestCase
    ( assertEqual "justdo --rm 666" (RemoveTodo 666) $ 
        parse ["--rm", "666"]
    )

tests :: Test
tests = TestList [test1, test2, test3, test4, test5, test6, test7, test8]