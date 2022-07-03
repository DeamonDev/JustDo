module InterpreterSpec where
import Test.HUnit.Base (Test (TestCase), assertEqual)
import Parser (parse)
import Interpreter (execute)
import Test.HUnit

flags1 :: [String]
flags1 = ["--generate", "--token", "--generate", "--easteregg"]

test1 :: Test
test1 = TestCase $ do 
                    let expr = parse flags1
                        expected = "Generated token 17 And Generated easter egg: cats are fun"
                    result <- execute expr 
                    assertEqual "flag1" (Right expected) result

tests :: Test
tests = TestList [test1]