module Parser.Checker where

import           Lexer.Lexer       (tokens)
import           Lexer.Token       (Token (..))
import           Parser.Expression (Expression)
import           Parser.Operator   (Operator)

-- Verify that all parentheses are matched
checkParens :: [Token] -> Bool
checkParens = checkParens' 0
    where
        checkParens' :: Integer -> [Token] -> Bool
        checkParens' n [] = n == 0
        checkParens' n (TLParen:xs) =
            checkParens' (n + 1) xs
        checkParens' n (TRParen:xs)
          | n == 0    = False
          | otherwise = checkParens' (n - 1) xs
        checkParens' n (_:xs) =
            checkParens' n xs

-- Check whether the list contains any illegal tokens
checkIllegal :: [Token] -> Maybe [String]
checkIllegal tokens =
    if any illegal tokens then
        Just $ map unwrap $ filter illegal tokens
    else
        Nothing
    where
        illegal :: Token -> Bool
        illegal (TIllegal _) = True
        illegal _           = False

        unwrap :: Token -> String
        unwrap (TIllegal s) = s
        unwrap _           = error "Attempted to unwrap a legal token."
