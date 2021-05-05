module Parser.Parser where

import           Parser.Expression (Expression)
import           Parser.Lexer      (tokens)
import           Parser.Operator   (Operator)
import           Parser.Token      (Token (..))

checkParens :: [Token] -> Bool
checkParens = checkParens' 0
    where
        checkParens' :: Integer -> [Token] -> Bool
        checkParens' n [] = n == 0
        checkParens' n (LParen:xs) =
            checkParens' (n + 1) xs
        checkParens' n (RParen:xs)
          | n == 0    = False
          | otherwise = checkParens' (n - 1) xs
        checkParens' n (_:xs) =
            checkParens' n xs

checkIllegal :: [Token] -> Maybe [String]
checkIllegal tokens =
    if any illegal tokens then
        Just $ map unwrap $ filter illegal tokens
    else
        Nothing
    where
        illegal :: Token -> Bool
        illegal (Illegal _) = True
        illegal _           = False

        unwrap :: Token -> String
        unwrap (Illegal s) = s
        unwrap _           = error "Attempted to unwrap a legal token."
