module Lexer.Lexer where

import           Control.Monad  (mfilter)
import           Data.Maybe     (fromMaybe, isJust)
import           Data.Text      (pack, replace, unpack)
import           Lexer.Operator (Operator (..))
import           Lexer.Token    (Token (..))
import           Text.Read      (readMaybe)

-- Tokenize a given expression
tokens :: String -> [Token]
tokens =
    concatMap tokens'. words . unpack     .
    -- the following code enables negation of parenthesized expressions
    replace (pack ")") (pack "))")        .
    replace (pack "-((") (pack "(-1 * (") .
    replace (pack "(") (pack "((")        .
    pack
    where
        tokens' :: String -> [Token]
        tokens' [ ] = [        ]
        tokens' "+" = [TOp TAdd]
        tokens' "-" = [TOp TSub]
        tokens' "*" = [TOp TMul]
        tokens' "×" = [TOp TMul]
        tokens' "/" = [TOp TDiv]
        tokens' "÷" = [TOp TDiv]
        tokens' "^" = [TOp TExp]
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
