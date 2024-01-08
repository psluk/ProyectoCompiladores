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

- `abrirRuta`
- `rutaNavideña`
- `gengibre`
- `rutaNavideñaAux`
- `tSantaClaus`
- `tlSantaClaus`
- `creaRegalo`
- `creaEntregaRegalo`
- `regalo`
- `regaloManual`
- `entregaRegalo`
- `regaloEnvuelto`
- `trineoSanta`
- `paqueteTrineoSanta`
- `entregaTrineoSanta`
- `confites`
- `bolsaNavideña`
- `envoltorios`
- `llamadaNavideña`
- `regaloPrin`
- `regaloAgregado`
- `regaloMultiplicado`
- `regaloCompartido`
- `regaloVolador`
- `confiteAdornado`
- `regaloComprado`
- `regaloConfirmado`
- `confite`
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
abrirRuta ::= ABREREGALO {:newScope();:} rutaNavideñaAux {:scope.pop();:} ;

rutaNavideña ::= ABREREGALO gengibre CIERRAREGALO |
                 abrirRuta CIERRAREGALO |
                 abrirRuta gengibre CIERRAREGALO ;

rutaNavideña ::= ABREREGALO gengibre CIERRAREGALO |
                 abrirRuta gengibre CIERRAREGALO |
                 abrirRuta CIERRAREGALO ;

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
creaRegalo ::= CHIMENEA tSantaClaus PERSONA ;
```

- _`creaEntregaRegalo` = asignar variable (d)_

```
creaEntregaRegalo ::= creaRegalo ENTREGA regalo ;

entregaRegalo ::= PERSONA ENTREGA regalo ;
```

> Expresiones sueltas:

```
regalo ::= regaloManual ;
```

- _`trineoSanta` = arreglo estático (c)_

```
trineoSanta ::= CHIMENEA tSantaClaus PERSONA ABREEMPAQUE l_SANNICOLAS CIERRAEMPAQUE ;
```

- _`paqueteTrineoSanta` = lee un elemento del arreglo_

```
paqueteTrineoSanta ::= PERSONA ABREEMPAQUE l_SANNICOLAS CIERRAEMPAQUE ;
```

- _`entregaTrineoSanta`: `AAA[0] <= 1 |` → asignar valor al arreglo estático_

```
entregaTrineoSanta ::= paqueteTrineoSanta ENTREGA tlSantaClaus ;
```

- _(a) funciones  -> function int persona (parametros){bloque de código}_

```
confites ::= confites ADORNO tSantaClaus PERSONA |
             tSantaClaus PERSONA ;


abrirBolsaNavideña ::= BOLSA tSantaClaus:tsc PERSONA:per ;

bolsaNavideña ::= abrirBolsaNavideña ABRECUENTO confites CIERRACUENTO rutaNavideña |
                  abrirBolsaNavideña ABRECUENTO CIERRACUENTO rutaNavideña ;
```

```
envoltorios ::= envoltorios ADORNO PERSONA | PERSONA ;

llamadaNavideña ::= PERSONA ABRECUENTO envoltorios CIERRACUENTO |
                    PERSONA ABRECUENTO CIERRACUENTO ;
```

- _(e, f, g) expresiones y combinación de ellas, respetando precedencia_
    - _Se crean cuatro niveles, tal que no se pueda volver de una operación de mayor precedencia a una de menor precedencia: 1: `**`, 2: `~`, 3: `*` o `/`, 4: `+` o `-`_

> Se unificarán las expresiones aritméticas, relacionales y lógicas, con la siguiente precedencia:
> - `!` (negación)
> - `++`, `--`, `-` (el `-` unario)
> - `**`
> - `*`, `/`
> - `~`
> - `+`, `-`
> - `<`, `<==`, `>`, `>=`, `==`, `!=`
> - `^` (`AND`)
> - `#` (`OR`)
>
> Por lo tanto, `++3 - 2 <== !2 ^ true` equivaldría a `(((++3) - 2) <== (!2)) ^ true`.

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

regaloVolador ::= regaloVolador DANZARIN regaloEnvuelto |
                  regaloEnvuelto ;
```

- _(h) Operaciones unarias_

```
confiteAdornado ::= GRINCH PERSONA |
                    QUIEN PERSONA |
                    BRIOSO tlSantaClaus ;
```

- _(i) Expresiones relacionales (sobre enteros y flotantes)_

```
regaloComprado ::= regaloComprado CANALLA regaloPrin |
                   regaloComprado CHISPA regaloPrin |
                   regaloComprado BUFON regaloPrin |
                   regaloComprado ASTUTO regaloPrin |
                   regaloComprado COPODENIEVE regaloPrin |
                   regaloComprado FELICIDAD regaloPrin |
                   regaloPrin ;
```

- _(j) Expresiones lógicas_

> Se necesita una regla adicional (`regaloEnvuelto`) para establecer la prioridad: primero la negación, luego el `AND` y luego el `OR`.

```
regaloManual ::= regaloManual GASPAR regaloConfirmado |
                 regaloConfirmado ;

regaloConfirmado ::= regaloConfirmado MELCHOR regaloComprado |
                    regaloComprado ;

regaloEnvuelto ::= BALTASAR confite |
                   confite ;

confite ::= ABRECUENTO regalo CIERRACUENTO |
            PERSONA |
            confiteAdornado |
            tlSantaClaus |
            paqueteTrineoSanta |
            llamadaNavideña ;
```

> `gengibre` son las líneas de código (o un bloque `{...}` con `rutaNavideñaAux`)

```
gengibre ::= gengibre regalos |
             gengibre rutaNavideñaAux |
             regalos ;
```

> `regalos` es una sola línea de código

```
regalos ::= creaRegalo FINREGALO | creaEntregaRegalo FINREGALO | entregaRegalo FINREGALO | mezcla |
            regalo FINREGALO | regresaFiesta | terminaFiesta | narraCuento | escuchaCuento |
            trineoSanta FINREGALO | entregaTrineoSanta FINREGALO | FINREGALO ;
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

galletaRegalo ::= ELFO ABRECUENTO regalo CIERRACUENTO rutaNavideñaAux ;

galletaNavidad ::= galletaNavidad HADA ABRECUENTO regalo CIERRACUENTO rutaNavideñaAux |
                   HADA ABRECUENTO regalo CIERRACUENTO rutaNavideñaAux ;

galletaChocolate ::= DUENDE rutaNavideñaAux ;
```

- _(m) `do-until` y `for`. `return`, `break`_

> `chocolate` es el `for` 

```
chocolate ::= ENVUELVE ABRECUENTO regaloAbierto FINREGALO regalo FINREGALO regaloAbierto CIERRACUENTO rutaNavideñaAux ;

regaloAbierto ::= creaRegalo | creaEntregaRegalo | entregaRegalo | mezcla | regalo | narraCuento | escuchaCuento |
                  rutaNavideñaAux | trineoSanta | entregaTrineoSanta ;
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

> leche es el `do until` (se asumió como `do while`):  
> `do {i * 2} until (i < 10)|`

```
leche ::= HACE rutaNavideñaAux REVISA ABRECUENTO regalo CIERRACUENTO ;
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