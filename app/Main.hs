module Main where

import Lib

import Parser 
import Interpreter

flags :: [String]
flags = ["--generate", "--token", "--generate", "--easteregg"]

main :: IO ()
main = putStrLn "justdo!"
