module Parser.Parser where

import Lexer.Token (Token(..))
import Parser.Expression (Expression(..))

-- Convert an infix expression to postfix
postify :: [Token] -> [Token]
postify = postify' []
    where
        postify' :: [Token] -> [Token] -> [Token]
        postify' res [] = res
        postify' (o:os) (t:ts) = case x of
            Const x -> t : postify' (o:os) ts
            
