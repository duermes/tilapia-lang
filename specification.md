## 1.1 Introduction

## 1.2 Objectives

## 2. especificacion

## 2.1 sintaxis

```variable := til <id> : <type>```.   

```type := bytestring | byte | ubyte | word | uword```.   

## 2.2 tipos de datos

**bytestring:** string  
**uword:** unsigned entero  
**word:** signed entero  
**ubyte:** unsigned byte  
**byte:** signed byte  

## operaciones
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

## 2.3 funciones

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


## 2.4 estructura de control

## 2.5 funciones estandar

## 2.6 variables

## 3. tilapias
