# Specification

## 1.1 Introduction

## 1.2 Objectives

# 2. Syntax

## 2.1 Data Types

```<type> := byte | ubyte | word | uword | bytestring | bool```

**bytestring:** Used to store strings. Lenght and pointer to contigous valid byte instances. Supossed to work as a vector. (Initial length: Undefined til assigned value, only changes). Inmutable except assignation  
**uword:** 64 bits unsigned integer  
**word:** 64 bits signed integer  
**ubyte:** 8 bits unsigned integer  
**byte:** 8 bits signed integer  
**bool**: 64 bits (false 0 true any non-zero)  

## 2.2 Variables

```
<type> := bytestring | byte | ubyte | word | uword

<var-init> := = <expr> | epsilon

<var-decl> := til <id> : <type> <var-init> ;

<assign> := <id> = <expr> ;
```

Example:
```til name : bytestring = "Hassan";```

## 2.3 Binary Operators

```
<arith-op> := + | - | * | / | %

<bitwise-op> := << | >>

<rel-op> := < | > | == | != | <= | >=

<logical-op> := && | ||

<binary-op> := <arith-op> | <bitwise-op> | <rel-op> | <logical-op>
```

- `+ - * / %`: usual arithmetic operators for addition, subtraction, multiplication, division and mod; valid only with same-type operands.
- `<< >>`: bit shift operators, left and right; right operand must be a non-negative word.


Example:
```
a + b
(value) + 4 - 5

```

## 2.5 Control Structures
### 2.5.1 Conditionals

```
<comp-stmt> := { <stmt>* }
<if-statement> := if <expr> <comp-stmt> <if-tail>
<if-tail> := else <comp-stmt>
            | else <if-statement>
            | epsilon
```

Examples:
```
if a>5 { a+b; }
if a>5 { a+b; } else { a = 0; }
if a>5 { a+b; } else if a>6 { a+b+c; }
if a>5 {  }
```


### 2.5.2 Loops

```
<loop-while> := while <expr> {<stmt>*}

<loop-do-while> := do <comp-stmt> while <expr>

<loop-for> := for (<init> ; <expr> ; <expr>) <comp-stmt>

<loop> := <loop-while> | <loop-do-while> | <loop-for>

<break> := </3 ;

<stmt> := <var-decl> | <assign> | <if-statement> | <loop> | <expr> | <break>
```


## 2.4 Functions

```
<arg> := <id> : <type> ,
<args> := <arg>*

<return-type> := -> <type> | epsilon

<function> := fish <id> ( <args> ) <return-type> { <stmt>* <expr> }
```
Return value without semicolon  

Example:
```
fish MenaMood( mood : byte ) -> bytestring {
    til mena : bytestring;
    if (mood == 1) {
        mena = 'happy';
    } else { mena = 'triste'; }
    mena
}

MenaMood("TRISTE": bytestring)  
```

Roadmap for this feature (by tai):
- no args, no ret
- no args, with ret
- args and ret

_Goal: `fish <id> (<args>) [-> <type>] {<body>}`_

First version old draft:
```function := fish <id> () { <body> }```

Example:
 ```
fish Tilapia() {
    til a : byte;
    til b : byte;
    a+b
    }
```

## 2.5 Miscellaneous
<expr> := 


# 3. Tilapia

Tilapia es el nombre común de casi cien especies de peces cíclidos antes conocidos como tilapinidos y ahora incluidos en los grupos taxonómicos celotilapina, coptodonina, heterotilapina, oreocromina, pelmatolapina y tilapia, de las cuales las económicamente más importantes son los coptodoninos y los oreochrominos.
