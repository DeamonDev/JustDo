module ParserSpec where
import Test.HUnit
import Parser (parse)
import Expr 

test1 :: Test
test1 = TestCase (assertEqual "justdo --token" Token $ parse ["--token"])

test2 :: Test 
test2 = TestCase (assertEqual "justdo --easteregg" EasterEgg $ parse ["--easteregg"]) 

test3 :: Test 
test3 = TestCase (assertEqual "justdo --generate --token" (Generate Token) $ parse["--generate", "--token"])

test4 :: Test 
test4 = TestCase (assertEqual "justdo --generate --easteregg" (Generate EasterEgg) $ parse["--generate", "--easteregg"])

test5 = TestCase (assertEqual "justdo --generate --token --generate --easteregg" (And (Generate Token) (Generate EasterEgg)) 
                      $ parse ["--generate", "--token", "--generate", "--easteregg"])

tests :: Test
tests = TestList [test1, test2, test3, test4, test5]