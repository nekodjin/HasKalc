module Parser.Expression where

import           Parser.Operator (Operator)

data Expression
    = EConst Double
    | EOp Expression Operator Expression
      deriving ( Show, Eq )
