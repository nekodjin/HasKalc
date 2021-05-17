module Lexer.Token where

import           Lexer.Operator (Operator (..))

data Token
  = TOp Operator
  | TLParen -- `(`
  | TRParen -- `)`
  | TConst Double -- number literals
  | TIllegal String -- unparsable tokens
    deriving (Eq, Show)
