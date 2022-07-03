module Main where

import Test.HUnit
import qualified ParserSpec 
--import qualified InterpreterSpec
import Control.Monad

main :: IO ()
main = void $ runTestTT ParserSpec.tests
