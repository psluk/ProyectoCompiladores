# Gramática BNF

## Listado de terminales

- ENTREGA
- RODOLFO, BRIOSO, DANZARIN, BROMISTA, COMETA, CUPIDO
- CANALLA, CHISPA, BUFON, ASTUTO, COPODENIEVE, FELICIDAD
- GRINCH, QUIEN
- MELCHOR, GASPAR, BALTASAR
- ABREREGALO, CIERRAREGALO, ABRECUENTO, CIERRACUENTO, FINREGALO
- ELFO, HADA, DUENDE, ENVUELVE, HACE, REVISA, ENVIA, CORTA
- NARRA, ESCUCHA
- ADORNO
- PERSONA

## Listado de no terminales

- navidad

## Símbolo inicial

- navidad

## Listado de producciones

// tsantaclaus = tipo de santa = tipos
tsantaclaus ::= 
            COLACHO |
            SANNICOLAS |
            SINTERKLAAS |
            PAPANOEL |
            DEDMOROZ ;   //No sé si debe terminar con ;

// tlsanta = tipo de literal (b)
tlsantaclaus ::= 
            l_SANNICOLAS |
            l_SINTERKLAAS |
            l_tCOLACHO |
            l_fCOLACHO |
            l_PAPANOEL |
            l_DEDMOROZ ;

// creaRegalo = variables (b) también d?
creaRegalo :: = tlsantaclaus PERSONA FINREGALO ;

// creaEntregaRegalo = asignar variable también d?
creaEntregaRegalo :: = tlsantaclaus PERSONA ENTREGA tlsantaclaus FINREGALO ;

// b y c mencionan arreglos, no me queda claro si solo es para int y char
// ptrineosanta = arreglo estático (b)   
ptrineosanta ::= tlsantaclaus PERSONA DecIntegerLiteral FINREGALO   // no estoy seguro si tiene sentido
                                                                    // ¿se entiende DecIntegerLiteral?

 // arreglo (c) le puse casi el mismo nombre porque creo que solo debe haber 1                                                                   
 ptTrineosanta ::= l_SANNICOLAS PERSONA DecIntegerLiteral FINREGALO |
                   l_SANNICOLAS PERSONA DecIntegerLitera FINREGALO                                                        

// (a) funciones  -> creo que mejor dejarla para despues de definir lo que lleva dentro
bolsanavideña ::= 

// (e) combinar -> primero definir funciones

// (f)

// (g)

// (h)

OperacionEntero: entero op1 entero |    
                 entero op2 entero 
// + y -
op1 ::= RODOLFO|
        BRIOSO

// * y /
op2 ::= BROMISTA |
        COMETA 

OperacionFloat::= float op2 flota |
                  flota op1 float


// gramatica inicial
navidad

function int persona (parametros){bloque de codigo}