## 1. Parser Generator (2d)

Lexer, parser, ast <br>
(50% 05/07 100% 06/07)

## 2.Type checking (2-3d)

(idk what we will need)

## 3. Translation to asm (4-5d)

(idk how to divide)

## Others

expr and stmt def

## Notes to take in count

- FALTA definir en el lexer EOF (no se como hacerlo)
- DEFINE from line 8-11 in lexer.mll (tai)

## 11-07

1.

```<function> := fish <id> ( <args> ) <return-type> { <stmt>* <expr> }

```  

Are we going to define expr to close with semicolon or not,
because the last line needs to not have a semicolon so we dont have problems with the parser,
but how then do we define a expr, if a+b is a expr and if expression doesnt require semicolon then means a+b; is
INCORRECT fuck.  
Right now how it is is that all stmt needs to have a semicolon inside a function. BUT outsidde a function no need for a semicolon for expressions.  
Solution: I can make a token for just the returnvalue probably.  
Return can be empty (Defined Empty on expr AST)
