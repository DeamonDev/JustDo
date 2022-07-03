module InterpreterSpec where
import Test.HUnit.Base (Test (TestCase), assertEqual)
import Parser (parse)
import Interpreter (execute)

flags1 :: [String]
flags1 = ["--generate", "--token"]

test1 :: Test
test1 = TestCase $ do 
                    let expr = parse flags1
                        expected = "Generated token 17 And Generated easter egg: cats are fun"
                    result <- execute expr 
                    assertEqual "flag1" (Right expected) result