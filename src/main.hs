module Main where

import           Interpreter.Interpreter (eval)
import           Lexer.Lexer             (tokens)
import           Parser.Checker          (checkIllegal, checkParens)
import           Parser.Parser           (postify, treeify)

main :: IO ()
main = do
    line <- getLine

    let toks = tokens line

    putStrLn "Tokens:"
    print toks

    putStrLn "Illegal tokens:"
    print $ checkIllegal toks

    putStrLn "Legal parens:"
    print $ checkParens toks

    putStrLn "Postified tokens:"
    print $ postify toks

    putStrLn "AST:"
    print $ treeify $ postify toks

    putStrLn "Value:"
    print $ eval $ treeify $ postify toks

    putStrLn ""

    main
