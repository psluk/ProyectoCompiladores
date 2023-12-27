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
- `galletaControl`
- `galletaRegalo`
- `galletaNavidad`
- `galletaChocolate`
- `chocolate`
- `cacao`
- `narracuento`
- `escuchacuento`
- `gengibre`
- `regalos`
- `nueces`
- `mezcla`
- `nuezTostada`
- `regresaFiesta`
- `terminaFiesta`
- `leche`

## Símbolo inicial

- `navidad`

## Listado de producciones

// El día de la entrega no vi este bloque y lo volví a definir el la línea 207 como gengibre

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

// El REGALO que se usa aqui lo definí como regalos en la línea 211 
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
// gengibre sería bloque en el código del profe
gengibre ::= regalos |
             gengibre regalos ;

// Siguiendo la foto de ejemplo del profe esta linea es la de expr = expresion
regalos ::= creaRegalo | creaEntregaRegalo | entregaRegalo | mezcla | nueces | regresaFiesta

// mezcla es el equivalente a estructura
mezcla ::= galletaControl |
           chocolate |
           leche ;

// nueves equivale a exprUni
nueces ::= nuezMacadamia FINREGALO ;

// nuezMacadamia equivale a exprP
nuezMacadamia :: = regaloPrin | 
                   nuezTostada

// nuezTostada equivalente a exprRelLog del profe
nuezTostada ::= regaloComprado |
                regaloManual

// galletaControl son los if -> estrucutra de control
// galletaRegalo = if, galletaNavidad = elif y galletaChocolate = else
galletaControl ::= galletaRegalo |
                   galletaNavidad |
                   galletaChocolate ;

galletaRegalo ::= ELFO ABRECUENTO nuezTostada CIERRACUENTO ABREREGALO gengibre CIERRAREGALO ;

galletaNavidad ::= HADA ABRECUENTO nuezTostada CIERRACUENTO ABREREGALO gengibre CIERRAREGALO ;

galletaChocolate ::= DUENDE ABREREGALO gengibre CIERRAREGALO ;

```

_(m) do-until y for. retun, break -> do{algo}whhile(a != 0) o for(i+10,3*2,2+1){}_

```
// chocolate es el for 
chocolate ::= ENVUELVE ABRECUENTO cacao CIERRACUENTO ABREREGALO gengibre CIERRAREGALO

// cacao es el rango del for. (1) | (1,1) | (1,1,1) -> debería aceptar variables como i
cacao ::= l_SANNICOLAS |
          l_SANNICOLAS ADORNO l_SANNICOLAS |
          l_SANNICOLAS ADORNO l_SANNICOLAS ADORNO l_SANNICOLAS ; // a lo que entiendo del comentario del profe cacao solo necesita esta linea

// regresaFiesta es return
regresaFiesta ::= ENVIA FINREGALO |
                  ENVIA ADORNO regalos FINREGALO ;

// terminaFiesta es break
terminaFiesta ::= CORTA FINREGALO ;

// leche es el do until (lo asumí como do while)
// do {i*2} until (i < 10)|
leche ::= HACE ABREREGALO gengibre CIERRAREGALO REVISA ABRECUENTO nueces CIERRACUENTO ;

```

- _(n) Entrada y salida -> print y read -> print("hola" o print("adios"))_

```
narraCuento ::= NARRA ABRECUENTO l_DEDMOROZ CIERRACUENTO FINREGALO |
                NARRA ABRECUENTO l_PAPANOEL CIERRACUENTO FINREGALO |
                NARRA ABRECUENTO l_SANNICOLAS CIERRACUENTO FINREGALO |
                NARRA ABRECUENTO l_SINTERKLAAS CIERRACUENTO FINREGALO |
                NARRA ABRECUENTO PERSONA CIERRACUENTO FINREGALO ;

escuchaCuento ::= ESCUCHA ABRECUENTO l_SANNICOLAS CIERRACUENTO FINREGALO |
                  ESCUCHA ABRECUENTO l_SINTERKLAAS CIERRACUENTO FINREGALO ;

```