module Main where

import Test.HUnit
import qualified ParserSpec
import qualified InterpreterSpec
--import qualified InterpreterSpec
import Control.Monad

main :: IO ()
main = do
  void $ runTestTT ParserSpec.tests
  void $ runTestTT InterpreterSpec.tests
