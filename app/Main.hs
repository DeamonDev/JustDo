module Main where

import Lib

import Parser 
import Interpreter

flags :: [String]
flags = ["--generate", "--token", "--generate", "--easteregg"]

main :: IO ()
main = 
  do
    let expr = parse flags 
    execute expr
