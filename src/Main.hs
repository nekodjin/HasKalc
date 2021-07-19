module Main where

import           Interpreter.Interpreter (eval)
import           Lexer.Lexer             (tokens)
import           Parser.Checker          (checkIllegal, checkParens)
import           Parser.Parser           (postify, treeify)
import           System.IO               (hFlush, hSetEncoding, stdout, utf8)

main :: IO ()
main = do
    hSetEncoding stdout utf8
    
    putStrLn "HasKalc - A Calculator Written in Haskell - Avery R.\n\
             \Enter an arithmetic expression for evaluation.\n\
             \Use the command `expose` to expose the intermediate\n\
             \steps of evaluation.\n\
             \Use the command `hide` to hide the intermediate steps.\n\
             \Use the command `quit` to exit the program.\n\
             \Note that all operators (i.e. `+`, `-`, `×`, `*`, `÷`,\n\
             \`/`, `^`) must be surrounded by whitespace on both sides.\n\
             \Some error checking systems are in place, but no\n\
             \guarantees are made regarding the evaluation of malformed\n\
             \inputs."
    
    hideLoop

hideLoop :: IO ()
hideLoop = do
    printPrompt

    line <- getLine

    if line == "quit" then
        putStrLn "Exiting HasKalc..."
    else if line == "expose" then
        exposeLoop
    else if line == "hide" then do
        putStrLn "You are already in hidden mode."
        hideLoop
    else if words line == [] then do
        putStrLn "Cannot evaluate an empty expression."
        hideLoop
    else do
        let toks = tokens line

        let illegals = checkIllegal toks
        let parens = checkParens toks

        case illegals of
            Just illegals -> do
                putStrLn "Illegal tokens found. Aborting evaluation."
                mapM_ (putStrLn . (<> " is an illegal token.")) illegals
            Nothing -> do
                if parens then
                    print $ interpret line
                else
                    putStrLn "Parentheses are malformed. Aborting evaluation."

        hideLoop


exposeLoop :: IO ()
exposeLoop = do
    printPrompt

    line <- getLine

    if line == "quit" then
        putStrLn "Exiting HasKalc..."
    else if line == "expose" then do
        putStrLn "You are already in exposed mode."
        exposeLoop
    else if line == "hide" then
        hideLoop
    else if words line == [] then do
        putStrLn "Cannot evaluate an empty expression."
        exposeLoop
    else do
        let toks = tokens line

        putStr "Original string:\n  "
        putStrLn line

        putStr "Tokens:\n  "
        print toks

        let illegals = checkIllegal toks

        putStrLn "Checking for illegal tokens..."
        case illegals of
            Just illegals -> do
                putStrLn "Illegal tokens found. Aborting evaluation."
                mapM_ (putStrLn . (<> " is an illegal token.")) illegals
            Nothing -> do
                putStrLn "No illegal tokens were found."
                putStrLn "Checking for matching parentheses..."
                if checkParens toks then do
                    putStrLn "Parentheses are well-formed."

                    putStr "Tokens (in postfix form):\n  "
                    print $ postify toks

                    putStr "AST:\n  "
                    print $ treeify $ postify toks

                    putStr "Final answer:\n  "
                    print $ interpret line
                else
                    putStrLn "Parentheses are malformed. Aborting evaluation."
        
        exposeLoop



printPrompt :: IO ()
printPrompt = do
    putStr ">> "
    hFlush stdout

interpret :: String -> Double
interpret = eval . treeify . postify . tokens
