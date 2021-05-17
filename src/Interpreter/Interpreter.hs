module Interpreter.Interpreter where

import           Parser.Expression (Expression (..))
import           Parser.Operator   (Operator (..))

eval :: Expression -> Double
eval (EConst n) = n
eval (EOp x op y) = toFunc op (eval x) (eval y)

toFunc :: Operator -> Double -> Double -> Double
toFunc OAdd = (+)
toFunc OSub = (-)
toFunc OMul = (*)
toFunc ODiv = (/)
toFunc OExp = (**)
