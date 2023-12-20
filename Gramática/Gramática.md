# Gramática BNF

## Listado de terminales

- `ENTREGA`
- `RODOLFO`, `BRIOSO`, `DANZARIN`, `BROMISTA`, `COMETA`, `CUPIDO`
- `CANALLA`, `CHISPA`, `BUFON`, `ASTUTO`, `COPODENIEVE`, `FELICIDAD`
- `GRINCH`, `QUIEN`
- `MELCHOR`, `GASPAR`, `BALTASAR`
- `ABREREGALO`, `CIERRAREGALO`, `ABRECUENTO`, `CIERRACUENTO`, `FINREGALO`
- `ELFO`, `HADA`, `DUENDE`, `ENVUELVE`, `HACE`, `REVISA`, `ENVIA`, `CORTA`
- `NARRA`, `ESCUCHA`
- `ADORNO`
- `PERSONA`

## Listado de no terminales

- `navidad`

## Símbolo inicial

- `navidad`

## Listado de producciones

_`tsantaclaus` = tipo de santa = tipos_

```
tsantaclaus ::= 
            COLACHO |
            SANNICOLAS |
            SINTERKLAAS |
            PAPANOEL |
            DEDMOROZ ;
```

_`tlsanta` = tipo de literal (b)_

```
tlsantaclaus ::= 
            l_SANNICOLAS |
            l_SINTERKLAAS |
            l_tCOLACHO |
            l_fCOLACHO |
            l_PAPANOEL |
            l_DEDMOROZ ;
```

_`creaRegalo` = variables (b), (d)_

```
creaRegalo :: = tsantaclaus PERSONA FINREGALO ;
```

_`creaEntregaRegalo` = asignar variable (d)_

```
creaEntregaRegalo :: = tsantaclaus PERSONA ENTREGA tlsantaclaus FINREGALO ;
entregaRegalo ::= PERSONA ENTREGA tlsantaclaus FINREGALO ;
```

_`ptrineosanta` = arreglo estático (b)_

```
ptrineosanta ::= tsantaclaus PERSONA ABREEMPAQUE l_SANNICOLAS CIERRAEMPAQUE FINREGALO ;
```

_`arreglo` punto (c)_

```
ptTrineosanta ::= SANNICOLAS PERSONA ABREEMPAQUE l_SANNICOLAS CIERRAEMPAQUE FINREGALO |
                   PAPANOEL PERSONA ABREEMPAQUE l_SANNICOLAS CIERRAEMPAQUE FINREGALO ;       
```

_`AAA[0] <= 1 |` → asignar valor al arreglo estático_

```
entregaTrineoSanta ::= PERSONA ABREEMPAQUE l_SANNICOLAS CIERRAEMPAQUE ENTREGA l_SANNICOLAS FINREGALO;
```

_(a) funciones  -> creo que mejor dejarla para despues de definir lo que lleva dentro_  
_function int persona (parametros){bloque de codigo}_

```
bolsanavideña ::= 
```

_(e) combinar -> primero definir funciones_

_(f)_

_(g)_

_(h)_

```
operacion: entero op1 entero |    
           entero op2 entero ;
```

_`+` y `-`_

```
op1 ::= RODOLFO|
        BRIOSO
```

_`*` y `/`_

```
op2 ::= BROMISTA |
        COMETA ;
```

_producción inicial -> la dejé abajo pero tengo que subirla_

```
navidad ::=
```