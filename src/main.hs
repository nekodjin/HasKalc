module Main where

import           Parser.Lexer  (tokens)
import           Parser.Parser (checkParens)

main :: IO ()
main = do
    line <- getLine
    print . tokens $ line
    print . checkParens . tokens $ line
    main
