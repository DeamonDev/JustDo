{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Renderer where
import System.Console.ANSI

data TextColor = JRed
               | JWhite
               | JGreen
              deriving ( Show )

render :: [(String, TextColor)] -> IO ()
render [] = return ()
render [(s, c)] = case c of
    JRed -> do
      setSGR [SetColor Foreground Vivid System.Console.ANSI.Red]
      putStrLn s
      setSGR[SetColor Foreground Vivid System.Console.ANSI.White]
    JWhite -> do
      setSGR [SetColor Foreground Vivid System.Console.ANSI.White]
      putStrLn s
      setSGR [Reset]
    JGreen -> do
      setSGR [SetColor Foreground Vivid System.Console.ANSI.Green]
      putStrLn s
      setSGR[SetColor Foreground Vivid System.Console.ANSI.White]
render (x:xs) = render [x] >> render xs


