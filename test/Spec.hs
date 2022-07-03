import Test.HUnit

import qualified ParserSpec 
import Control.Monad

main :: IO ()
main = void $ runTestTT ParserSpec.tests
