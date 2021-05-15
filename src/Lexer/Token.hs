module Lexer.Token where

data Token
  = Add -- `+`
  | Sub -- `-`
  | Mul -- `×`, `*`
  | Div -- `÷`, `/`
  | Exp -- `^`
  | LParen -- `(`
  | RParen -- `)`
  | Const Double -- number literals
  | Illegal String -- unparsable tokens
  deriving (Eq, Show)