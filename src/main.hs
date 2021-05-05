module Main where

import           Parser.Lexer  (tokens)
import           Parser.Parser (checkParens, checkIllegal)

main :: IO ()
main = do
    line <- getLine

    putStrLn "Tokens:"
    print . tokens $ line

    putStrLn "Illegal tokens:"
    print . checkIllegal . tokens $ line

    putStrLn "Legal parens:"
    print . checkParens . tokens $ line
    
    main
