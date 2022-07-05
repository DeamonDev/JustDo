module Main where

import Parser 
import Interpreter
import System.Environment.Blank (getArgs)


main :: IO ()
main =
  do 
    args <- getArgs
    putStrLn $ "The arguments are: " ++ show args
