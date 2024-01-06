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

- `rutaNavideña`
- `gengibre`
- `rutaNavideñaAux`
- `tSantaClaus`
- `tlSantaClaus`
- `creaRegalo`
- `creaEntregaRegalo`
- `regaloPrin`
- `regaloManual`
- `entregaRegalo`
- `nueces`
- `trineoSanta`
- `paqueteTrineoSanta`
- `entregaTrineoSanta`
- `confites`
- `bolsaNavideña`
- `envoltorios`
- `llamadaNavideña`
- `regaloAgregado`
- `regaloMultiplicado`
- `regaloCompartido`
- `regaloVolador`
- `confite`
- `personaAdornada`
- `regaloComprado`
- `regalos`
- `mezcla`
- `regresaFiesta`
- `terminaFiesta`
- `narraCuento`
- `escuchaCuento`
- `galletaControl`
- `chocolate`
- `leche`
- `galletaRegalo`
- `galletaNavidad`
- `galletaChocolate`
- `regaloAbierto`
- `bolsaNavideñaAux`
- `navidad`

## Símbolo inicial

- `navidad`

## Listado de producciones

- _`rutaNavideña` = bloque de código_    
_(`rutaNavideñaAux` permite un bloque vacío)_

```
rutaNavideña ::= ABREREGALO gengibre CIERRAREGALO ;

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
creaRegalo :: = CHIMENEA tSantaClaus PERSONA ;
```

- _`creaEntregaRegalo` = asignar variable (d)_

```
creaEntregaRegalo :: = CHIMENEA tSantaClaus PERSONA ENTREGA regaloPrin ;
creaEntregaRegalo :: = CHIMENEA tSantaClaus PERSONA ENTREGA regaloManual ;

entregaRegalo ::= PERSONA ENTREGA regaloPrin ;
entregaRegalo ::= PERSONA ENTREGA regaloManual ;
```

> Expresiones sueltas

```
nueces ::= regaloPrin | regaloManual ;
```

- _`trineoSanta` = arreglo estático (c)_

```
trineoSanta ::= CHIMENEA SANNICOLAS PERSONA ABREEMPAQUE l_SANNICOLAS CIERRAEMPAQUE FINREGALO |
                CHIMENEA PAPANOEL PERSONA ABREEMPAQUE l_SANNICOLAS CIERRAEMPAQUE FINREGALO ;
```

- _`paqueteTrineoSanta` = lee un elemento del arreglo_

```
paqueteTrineoSanta ::= PERSONA ABREEMPAQUE l_SANNICOLAS CIERRAEMPAQUE ;
```

- _`entregaTrineoSanta`: `AAA[0] <= 1 |` → asignar valor al arreglo estático_

```
entregaTrineoSanta ::= paqueteTrineoSanta ENTREGA tlSantaClaus FINREGALO ;
```

- _(a) funciones  -> function int persona (parametros){bloque de código}_

```
confites ::= confites ADORNO tSantaClaus PERSONA |
             tSantaClaus PERSONA ;

bolsaNavideña ::= BOLSA tSantaClaus PERSONA ABRECUENTO confites CIERRACUENTO rutaNavideña |
                  BOLSA tSantaClaus PERSONA ABRECUENTO CIERRACUENTO rutaNavideña ;
```

```
envoltorios ::= envoltorios ADORNO PERSONA | PERSONA ;

llamadaNavideña ::= PERSONA ABRECUENTO envoltorios CIERRACUENTO |
                    PERSONA ABRECUENTO CIERRACUENTO ;
```

- _(e, f, g) expresiones y combinación de ellas, respetando precedencia_
    - _Se crean cuatro niveles, tal que no se pueda volver de una operación de mayor precedencia a una de menor precedencia: 1: `**`, 2: `~`, 3: `*` o `/`, 4: `+` o `-`_

```
regaloPrin ::= regaloAgregado ;

regaloAgregado ::= regaloAgregado RODOLFO regaloMultiplicado |
                   regaloAgregado BRIOSO regaloMultiplicado  |
                   regaloMultiplicado ;

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
            tlSantaClaus | llamadaNavideña | paqueteTrineoSanta ;
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

> `gengibre` son las líneas de código

```
gengibre ::= gengibre regalos |
             regalos ;
```

> `regalos` es una sola línea de código (o un bloque `{...}` con `rutaNavideñaAux`)

```
regalos ::= creaRegalo FINREGALO | creaEntregaRegalo FINREGALO | entregaRegalo FINREGALO | mezcla |
            nueces FINREGALO | regresaFiesta | terminaFiesta | narraCuento | escuchaCuento | rutaNavideñaAux |
            FINREGALO ;
```

- _(m) Estructuras de control (`if`-[`elif`]-[`else`]) -> `if(a > b){print(a)|}`_

> - `galletaControl` son los `if`, `elif` y `else`
> - `galletaRegalo` = `if`, `galletaNavidad` = `elif` y `galletaChocolate` = `else`
> - `if` es obligatorio; `elif` y `else` son opcionales, así que se incluyen las combinaciones

```
mezcla ::= galletaControl |
           chocolate |
           leche ;
```

```
galletaControl ::= galletaRegalo galletaNavidad galletaChocolate |
                   galletaRegalo galletaNavidad |
                   galletaRegalo galletaChocolate |
                   galletaRegalo ;

galletaRegalo ::= ELFO ABRECUENTO regaloManual CIERRACUENTO rutaNavideñaAux ;

galletaNavidad ::= HADA ABRECUENTO regaloManual CIERRACUENTO rutaNavideñaAux ;

galletaChocolate ::= DUENDE rutaNavideñaAux ;
```

- _(m) `do-until` y `for`. `return`, `break`_

> `chocolate` es el `for` 

```
chocolate ::= ENVUELVE ABRECUENTO regaloAbierto FINREGALO regaloManual FINREGALO regaloAbierto CIERRACUENTO rutaNavideñaAux ;

regaloAbierto ::= creaRegalo | creaEntregaRegalo | entregaRegalo | mezcla | nueces | narraCuento | escuchaCuento | rutaNavideñaAux ;
```

> `regresaFiesta` es `return`

```
regresaFiesta ::= ENVIA FINREGALO |
                  ENVIA ADORNO regalos FINREGALO ;
```

> `terminaFiesta` es `break`

```
terminaFiesta ::= CORTA FINREGALO ;
```

> leche es el `do until` (lo asumí como `do while`):  
> `do {i * 2} until (i < 10)|`

```
leche ::= HACE rutaNavideñaAux REVISA ABRECUENTO regaloManual CIERRACUENTO ;
```

- _(n) Entrada y salida: `print` y `read` -> `print("hola")` o `print("adios")`_

```
narraCuento ::= NARRA ABRECUENTO l_DEDMOROZ CIERRACUENTO FINREGALO |
                NARRA ABRECUENTO l_PAPANOEL CIERRACUENTO FINREGALO |
                NARRA ABRECUENTO l_SANNICOLAS CIERRACUENTO FINREGALO |
                NARRA ABRECUENTO l_SINTERKLAAS CIERRACUENTO FINREGALO |
                NARRA ABRECUENTO PERSONA CIERRACUENTO FINREGALO ;

escuchaCuento ::= ESCUCHA ABRECUENTO l_SANNICOLAS CIERRACUENTO FINREGALO |
                  ESCUCHA ABRECUENTO l_SINTERKLAAS CIERRACUENTO FINREGALO ;
```

- _Producción inicial_

```
bolsaNavideñaAux ::= bolsaNavideñaAux bolsaNavideña |
                     bolsaNavideña ;

navidad ::= bolsaNavideñaAux ;
```