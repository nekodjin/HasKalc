module Parser.Expression where

import           Parser.Operator (Operator)

data Expression
    = Const Double
    | Operation Expression Operator Expression
