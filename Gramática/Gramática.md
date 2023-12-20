# Gramática BNF

## Listado de terminales

- `ENTREGA`
- `RODOLFO`, `BRIOSO`, `DANZARIN`, `BROMISTA`, `COMETA`, `CUPIDO`
- `CANALLA`, `CHISPA`, `BUFON`, `ASTUTO`, `COPODENIEVE`, `FELICIDAD`
- `GRINCH`, `QUIEN`
- `MELCHOR`, `GASPAR`, `BALTASAR`
- `ABREREGALO`, `CIERRAREGALO`, `ABRECUENTO`, `CIERRACUENTO`, `FINREGALO`, `ABREEMPAQUE`, `CIERRAEMPAQUE`
- `ELFO`, `HADA`, `DUENDE`, `ENVUELVE`, `HACE`, `REVISA`, `ENVIA`, `CORTA`
- `NARRA`, `ESCUCHA`
- `ADORNO`
- `PERSONA`
- `BOLSA`
- `CHIMENEA`
- `COLACHO`, `SANNICOLAS`, `SINTERKLAAS`, `PAPANOEL`, `DEDMOROZ`
- `l_SANNICOLAS`, `l_SINTERKLAAS`, `l_tCOLACHO`, `l_fCOLACHO`, `l_PAPANOEL`, `l_DEDMOROZ`

## Listado de no terminales

- `navidad`
- `rutaNavideña`
- `rutaNavideñaAux`
- `tSantaClaus`
- `tlSantaClaus`
- `tlSantaClausNumero`
- `creaRegalo`
- `creaEntregaRegalo`
- `entregaRegalo`
- `trineoSanta`
- `paqueteTrineoSanta`
- `entregaTrineoSanta`
- `confites`
- `bolsaNavideña`
- `regaloPrin`
- `regaloVolador`
- `regaloCompartido`
- `regaloMultiplicado`
- `regaloAgregado`
- `personaAdornada`
- `regaloComprado`
- `regaloManual`
- `llamadaNavideña`
- `caminoNavideño`

## Símbolo inicial

- `navidad`

## Listado de producciones

- _`rutaNavideña` = bloque de código_    
_(`rutaNavideñaAux` permite un bloque vacío)_

```
rutaNavideña ::= ABREREGALO lineasNavidad CIERRAREGALO ;

rutaNavideñaAux ::=  rutaNavideña |
               ABREREGALO CIERRAREGALO ;
```

- _`tSantaClaus` = tipo de santa = tipos_

```
tSantaClaus ::= 
            COLACHO |
            SANNICOLAS |
            SINTERKLAAS |
            PAPANOEL |
            DEDMOROZ ;
```

- _`tlSantaClaus` = tipo de literal (b)_

```
tlSantaClaus ::= 
            l_SANNICOLAS |
            l_SINTERKLAAS |
            l_tCOLACHO |
            l_fCOLACHO |
            l_PAPANOEL |
            l_DEDMOROZ ;
```

- _`creaRegalo` = variables (b), (d)_

```
creaRegalo :: = tSantaClaus PERSONA FINREGALO ;
```

- _`creaEntregaRegalo` = asignar variable (d)_

```
creaEntregaRegalo :: = tSantaClaus PERSONA ENTREGA regaloPrin FINREGALO ;
creaEntregaRegalo :: = tSantaClaus PERSONA ENTREGA regaloManual FINREGALO ;

entregaRegalo ::= PERSONA ENTREGA regaloPrin FINREGALO ;
entregaRegalo ::= PERSONA ENTREGA regaloManual FINREGALO ;
```

- _`trineoSanta` = arreglo estático (c)_

```
trineoSanta ::= SANNICOLAS PERSONA ABREEMPAQUE l_SANNICOLAS CIERRAEMPAQUE FINREGALO |
                   PAPANOEL PERSONA ABREEMPAQUE l_SANNICOLAS CIERRAEMPAQUE FINREGALO ;
```

- _`paqueteTrineoSanta` = lee un elemento del arreglo_

```
paqueteTrineoSanta ::= PERSONA ABREEMPAQUE l_SANNICOLAS CIERRAEMPAQUE ;
```

- _`entregaTrineoSanta`: `AAA[0] <= 1 |` → asignar valor al arreglo estático_

```
entregaTrineoSanta ::= paqueteTrineoSanta ENTREGA tlSantaClaus FINREGALO ;
```

- _(a) funciones  -> function int persona (parametros){bloque de codigo}_

```
confites ::= confites ADORNO tSantaClaus PERSONA |
             tSantaClaus PERSONA ;

bolsaNavideña ::= BOLSA tSantaClaus PERSONA ABRECUENTO confites CIERRACUENTO REGALO |
                  BOLSA tSantaClaus PERSONA ABRECUENTO CIERRACUENTO REGALO ;
```

- _(e, f, g) expresiones y combinación de ellas, respetando precedencia_
    - _Se crean cuatro niveles, tal que no se pueda volver de una operación de mayor precedencia a una de menor precedencia: 1: `**`, 2: `~`, 3: `*` o `/`, 4: `+` o `-`_

```
regaloPrin ::= regaloAgregado ;

regaloAgregado ::= regaloAgregado RODOLFO regaloMultiplicado |
                   regaloAgregado BRIOSO regaloMultiplicado  |
                   regaloAgregado ::= regaloMultiplicado ;

regaloMultiplicado ::= regaloMultiplicado BROMISTA regaloCompartido |
                       regaloMultiplicado COMETA regaloCompartido |
                       regaloCompartido ;

regaloCompartido ::= regaloCompartido CUPIDO regaloVolador |
                     regaloVolador ;

regaloVolador ::= regaloVolador DANZARIN confite |
                  confite ;

confite ::= ABRECUENTO regaloAgregado CIERRACUENTO |
            PERSONA |
            personaAdornada |
            tl_SantaClaus | llamadaNavideña ;
```

- _(h) Operaciones unarias (el negativo lo detecta el lexer)_

```
personaAdornada ::= GRINCH PERSONA |
                    QUIEN PERSONA ;
```

- _(i) Expresiones relacionales (sobre enteros y flotantes)_

```
regaloComprado ::= regaloPrin CANALLA regaloPrin |
                   regaloPrin CHISPA regaloPrin |
                   regaloPrin BUFON regaloPrin |
                   regaloPrin ASTUTO regaloPrin |
                   regaloPrin COPODENIEVE regaloPrin |
                   regaloPrin FELICIDAD regaloPrin |
                   l_tCOLACHO | l_fCOLACHO | llamadaNavideña ;
```

- _(j) Expresiones lógicas_

```
regaloManual ::= regaloManual MELCHOR regaloManual |
                 regaloManual GASPAR regaloManual |
                 BALTASAR regaloManual |
                 regaloComprado ;
```

- _(m) Estructuras de control (if-[elif]-[else]) -> if(a > b){print{a}}_

```
galletaControl ::= galletaRegalo |
                   galletaNavidad |
                   galletaChocolate ;

galletaRegalo ::= ELFO ABRECUENTO "condicion" CIERRACUENTO ABREREGALO "contenido" CIERRAREGALO ;

galletaNavidad ::= HADA ABRECUENTO "condicion" CIERRACUENTO ABREREGALO "contenido" CIERRAREGALO ;

galletaChocolate ::= DUENDE ABREREGALO "contenido" CIERRAREGALO ;

```

_(m) do-until y for. retun, break -> do{algo}whhile(a != 0) o for(i+10,3*2,2+1){}_

```
chocolate ::= ENVUELVE ABRECUENTO cacao CIERRACUENTO 

cacao ::= l_SANNICOLAS |
          l_SANNICOLAS ADORNO l_SANNICOLAS |
          l_SANNICOLAS ADORNO l_SANNICOLAS ADORNO l_SANNICOLAS ;

```

- _(n) Entrada y salida -> print y read -> print("hola" o print("adios")) ¿read recibe variables?_

```
narraCuento ::= NARRA ABRECUENTO l_DEDMOROZ CIERRACUENTO FINREGALO |
                NARRA ABRECUENTO l_PAPANOEL CIERRACUENTO FINREGALO |
                NARRA ABRECUENTO l_SANNICOLAS CIERRACUENTO FINREGALO |
                NARRA ABRECUENTO l_SINTERKLAAS CIERRACUENTO FINREGALO |
                NARRA ABRECUENTO PERSONA CIERRACUENTO FINREGALO ;

escuchaCuento ::= ESCUCHA ABRECUENTO l_SANNICOLAS CIERRACUENTO FINREGALO |
                  ESCUCHA ABRECUENTO l_SINTERKLAAS CIERRACUENTO FINREGALO ;

```