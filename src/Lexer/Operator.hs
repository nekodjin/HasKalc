module Lexer.Operator where

data Operator
  = Add
  | Sub
  | Mul
  | Div
  | Exp
    deriving ( Show, Eq )

-- The Ord instance for 
instance Ord Operator where
    (<=) _   Exp = True
    (<=) Exp _   = False
    (<=) _   Mul = True
    (<=) _   Div = True
    (<=) Mul _   = False
    (<=) Div _   = False
    (<=) _   _   = True
