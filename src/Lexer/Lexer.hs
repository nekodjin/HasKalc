module Lexer.Lexer where

import           Data.Maybe   (isJust)
import           Parser.Token (Token (..))
import           Text.Read    (readMaybe)

-- Tokenize a given expression
tokens :: String -> [Token]
tokens = concatMap tokens' . words
    where
        tokens' :: String -> [Token]
        tokens' [ ] = [    ]
        tokens' "+" = [TAdd]
        tokens' "-" = [TSub]
        tokens' "*" = [TMul]
        tokens' "×" = [TMul]
        tokens' "/" = [TDiv]
        tokens' "÷" = [TDiv]
        tokens' "^" = [TExp]
        tokens' ('(' : str) = TLParen : tokens' str
        tokens' (')' : str) = TRParen : tokens' str
        tokens' str
          | last str == '(' = tokens' (init str) ++ [TLParen]
          | last str == ')' = tokens' (init str) ++ [TRParen]
          | otherwise       = [tokens'' str]

        tokens'' :: String -> Token
        tokens'' str
          | isJust (readMaybe str :: Maybe Double) = TConst $ read str
          | otherwise                              = TIllegal str
