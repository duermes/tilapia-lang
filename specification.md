# Specification

## 1.1 Introduction

## 1.2 Objectives

# 2. Syntax

## 2.1 Data Types

```<type> := byte | ubyte | word | uword | bytestring```  

**bytestring:** fat string of bytes, lenght and pointer to contigous valid byte instances
**uword:** 64 bits unsigned integer  
**word:** 64 bits signed integer  
**ubyte:** 8 bits unsigned integer  
**byte:** 8 bits signed integer 

## 2.2 Variables

```variable := til <id> : <type>```.   

```type := bytestring | byte | ubyte | word | uword```.  

## 2.3 Numerical Operators

```<expression> := <exp1> <valid operation> <exp2>```  
```<valid operator> := + | - | / | & | << | >> | %```  

`+`: suma  
`-`: resta  
`/`: división  
`<<`: left shift  
`>>`: right shift  
`%`: modulo

Ejemplo:   
```a+b``` 

## 2.5 Control Structures
### 2.5.1 Conditionals

```
<if-statement> := if <condition> {<stmt>*} [<optional-else>]  
<optional-else> := else <if-statement>
                | else {<stmt>* }
```  

### 2.5.2 Loops

```while (<condition>) {<body>}```  

```do {<stmt>*} while (<condition>)```  

```for (<init>; <condition>; <inc>) { <body> }```  


## 2.4 Functions

```function := fun <id> () { <body> }```

**Ejemplo:**

```
fun Tilapia() { 
    til a : byte; 
    tyl b : byte; 
    a+b; 
    }
```

Roadmap for this feature (by tai):  
- no args, no ret  
- no args, with ret  
- args and ret  

_Goal: `fun <id> (<args>) [-> <type>] {<body>}`_  

 

# 3. Tilapia

Tilapia es el nombre común de casi cien especies de peces cíclidos antes conocidos como tilapinidos y ahora incluidos en los grupos taxonómicos celotilapina, coptodonina, heterotilapina, oreocromina, pelmatolapina y tilapia, de las cuales las económicamente más importantes son los coptodoninos y los oreochrominos.