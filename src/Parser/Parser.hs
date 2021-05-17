module Parser.Parser where

import           Lexer.Operator    (Operator (..))
import           Lexer.Token       (Token (..))
import           Parser.Expression (Expression (..))
import qualified Parser.Operator   as P (Operator (..))

-- Convert an infix expression to postfix using the shunting yard
-- algorithm
postify :: [Token] -> [Token]
postify = postify' []
    where
        postify' :: [Token] -> [Token] -> [Token]
        postify' [] []               = []
        postify' (o:os) []           = o : postify' os []
        postify' ops (TConst n : ts) = TConst n : postify' ops ts
        postify' ops (TOp t : ts)    = postifyOp t ops ts
        postify' ops (TLParen : ts)  = postify' (TLParen:ops) ts
        postify' ops (TRParen : ts)  = postifyPr ops ts

        -- handle case of token is operator
        postifyOp :: Operator -> [Token] -> [Token] -> [Token]
        postifyOp op (TOp o:os) ts
          | op <= o = TOp o : postifyOp op os ts
          | otherwise = postify' (TOp op:TOp o:os) ts
        postifyOp op ops ts = postify' (TOp op:ops) ts

        -- handle case of token is right paren
        postifyPr :: [Token] -> [Token] -> [Token]
        postifyPr (TLParen:os) ts = postify' os ts
        postifyPr (o:os) ts       = o : postifyPr os ts

-- Convert a list of postfix tokens into an expression (AST)
treeify :: [Token] -> Expression
treeify = treeify' []
    where
        treeify' :: [Expression] -> [Token] -> Expression
        treeify' [exp] [] = exp
        treeify' acc (TConst n:toks) = treeify' (EConst n:acc) toks
        treeify' (y:x:acc) (TOp TAdd:toks) =
            treeify' (EOp x P.OAdd y:acc) toks
        treeify' (y:x:acc) (TOp TSub:toks) =
            treeify' (EOp x P.OSub y:acc) toks
        treeify' (y:x:acc) (TOp TMul:toks) =
            treeify' (EOp x P.OMul y:acc) toks
        treeify' (y:x:acc) (TOp TDiv:toks) =
            treeify' (EOp x P.ODiv y:acc) toks
        treeify' (y:x:acc) (TOp TExp:toks) =
            treeify' (EOp x P.OExp y:acc) toks
