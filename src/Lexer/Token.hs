module Lexer.Token where

data Token
  = TAdd -- `+`
  | TSub -- `-`
  | TMul -- `×`, `*`
  | TDiv -- `÷`, `/`
  | TExp -- `^`
  | TLParen -- `(`
  | TRParen -- `)`
  | TConst Double -- number literals
  | TIllegal String -- unparsable tokens
  deriving (Eq, Show)