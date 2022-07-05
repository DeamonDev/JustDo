module Main where

import Parser 
import Interpreter
import System.Environment.Blank (getArgs)
import qualified JustDo


main :: IO ()
main = JustDo.main
