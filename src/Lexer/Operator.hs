module Lexer.Operator where

data Operator
  = TAdd
  | TSub
  | TMul
  | TDiv
  | TExp
    deriving ( Show, Eq )

-- The Ord instance for Operator indicates precedence
instance Ord Operator where
    (<=) TExp TExp = False
    (<=) _    TExp = True
    (<=) TExp _    = False
    (<=) _    TMul = True
    (<=) _    TDiv = True
    (<=) TMul _    = False
    (<=) TDiv _    = False
    (<=) _    _    = True
