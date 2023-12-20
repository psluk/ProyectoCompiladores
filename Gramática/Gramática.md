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
            DEDMOROZ ;  

// tlsanta = tipo de literal (b)
tlsantaclaus ::= 
            l_SANNICOLAS |
            l_SINTERKLAAS |
            l_tCOLACHO |
            l_fCOLACHO |
            l_PAPANOEL |
            l_DEDMOROZ ;

// creaRegalo = variables (b), (d)
creaRegalo :: = tsantaclaus PERSONA FINREGALO ;

// creaEntregaRegalo = asignar variable (d)
creaEntregaRegalo :: = tsantaclaus PERSONA ENTREGA tlsantaclaus FINREGALO ;

entregaRegalo ::= PERSONA ENTREGA tlsantaclaus FINREGALO ;

// ptrineosanta = arreglo estático (b)   
ptrineosanta ::= tsantaclaus PERSONA ABREEMPAQUE l_SANNICOLAS CIERRAEMPAQUE FINREGALO ;

// AAA[0] <= 1 |

 // arreglo punto(c)                                                                     
 ptTrineosanta ::= SANNICOLAS PERSONA l_SANNICOLAS  FINREGALO |
                   PAPANOEL PERSONA l_SANNICOLAS FINREGALO ;                                                        

// (a) funciones  -> creo que mejor dejarla para despues de definir lo que lleva dentro
//function int persona (parametros){bloque de codigo}
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


// producción inicial -> la dejé abajo pero tengo que subirla
navidad ::=