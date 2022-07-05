module InterpreterSpec where

import Interpreter (exec)
import Parser (parse)
import Test.HUnit
import Test.HUnit.Base (Test (TestCase), assertEqual)

flags1 :: [String]
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
tests = TestList [test1, test2]