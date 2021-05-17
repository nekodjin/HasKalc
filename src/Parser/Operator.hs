module Parser.Operator where

data Operator
    = OAdd
    | OSub
    | OMul
    | ODiv
    | OExp
      deriving ( Show, Eq )
