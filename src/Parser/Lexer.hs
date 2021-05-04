module Parser.Lexer where

import           Data.Maybe   (isJust)
import           Parser.Token (Token (..))
import           Text.Read    (readMaybe)

-- Tokenize a given expression
tokens :: String -> [Token]
tokens = concatMap tokens' . words
    where
        tokens' :: String -> [Token]
        tokens' [ ] = [   ]
        tokens' "+" = [Add]
        tokens' "-" = [Sub]
        tokens' "*" = [Mul]
        tokens' "×" = [Mul]
        tokens' "/" = [Div]
        tokens' "÷" = [Div]
        tokens' "^" = [Exp]
        tokens' ('(' : str) = LParen : tokens' str
        tokens' (')' : str) = RParen : tokens' str
        tokens' str
          | last str == '(' = tokens' (init str) ++ [LParen]
          | last str == ')' = tokens' (init str) ++ [RParen]
          | otherwise       = [tokens'' str]

        tokens'' :: String -> Token
        tokens'' str
          | isJust (readMaybe str :: Maybe Double) = Const $ read str
          | otherwise                              = Illegal str
