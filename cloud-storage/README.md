# Guía GCP: Service Accounts, llaves y acceso a Cloud Storage desde VSCode

Esta guía explica **exactamente** los comandos que mencionaste y el
flujo completo:

-   Crear una cuenta de servicio
-   Probar acceso
-   Ejecutar código
-   Revocar credenciales y permisos

------------------------------------------------------------------------

## 1. Explicación de los comandos que usas

### Exportar la credencial

``` bash
export GOOGLE_APPLICATION_CREDENTIALS="/home/miguel/proyectos/Data-Engineer-with-GCP/keys/llave.json"
```

Define la ruta donde este la llave de la cuenta de servicio para usarla siempre y cuando esta cuenta de servicio sirva en el bucket que queremos usar.

⚠️ Debe apuntar a un **archivo**, no a un directorio.

------------------------------------------------------------------------

### Verificar que existe

``` bash
ls -l "$GOOGLE_APPLICATION_CREDENTIALS"
```

Comprueba que el archivo está presente y accesible.

------------------------------------------------------------------------

### Imprimir la variable

``` bash
echo $GOOGLE_APPLICATION_CREDENTIALS
```

Confirma cuál credencial está activa.

------------------------------------------------------------------------

### Fijar proyecto (su id no su nombre)

``` bash
gcloud config set project quick-magpie-483522-r1
```

Selecciona el proyecto contra el que se ejecutarán los comandos.

------------------------------------------------------------------------

### Revocar ADC

``` bash
gcloud auth application-default revoke
```

Borra Application Default Credentials locales.

------------------------------------------------------------------------

------------------------------------------------------------------------

## 2. Flujo completo desde cero

------------------------------------------------------------------------

## Paso 1 --- Crear cuenta de servicio

Consola web:

IAM & Admin → Service Accounts → Create Service Account

Ejemplo:

    storage-access-dev

------------------------------------------------------------------------

------------------------------------------------------------------------

## Paso 2 --- Dar permisos al bucket

En Cloud Storage → bucket → Permissions:

Roles recomendados:

-   Storage Object Viewer
-   Storage Object Creator
-   Storage Object Admin (solo si es necesario)

------------------------------------------------------------------------

------------------------------------------------------------------------

## Paso 3 --- Crear llave JSON

IAM → Service Accounts → Keys → Add key → JSON

Guárdala en:

    /home/miguel/proyectos/Data-Engineer-with-GCP/keys/storage.json

------------------------------------------------------------------------

------------------------------------------------------------------------

## Paso 4 --- Exportar la variable en WSL

``` bash
export GOOGLE_APPLICATION_CREDENTIALS="/home/miguel/proyectos/Data-Engineer-with-GCP/keys/storage.json"
```

Verifica:

``` bash
ls -l "$GOOGLE_APPLICATION_CREDENTIALS"
echo $GOOGLE_APPLICATION_CREDENTIALS
```

# una vez echo esto podemos ejecutar el codigo para subir o exportar archivos 
------------------------------------------------------------------------



## Paso 5 --- Cambiar credenciales

Limpiar:

``` bash
unset GOOGLE_APPLICATION_CREDENTIALS
gcloud auth application-default revoke
```

------------------------------------------------------------------------

------------------------------------------------------------------------

## Paso 9 --- Revocar permisos definitivamente

Opciones:

-   Borrar key en IAM
-   Quitar acceso al bucket
-   Borrar la service account

------------------------------------------------------------------------

------------------------------------------------------------------------

## Advertencias críticas ⚠️

SIEMPRE verifica:

``` bash
gcloud config get-value project
gcloud auth list
echo $GOOGLE_APPLICATION_CREDENTIALS
gsutil ls
```

Antes de subir algo:

``` bash
gsutil ls gs://bucket/path/
```

Errores comunes:

-   Usar proyecto equivocado
-   Bucket incorrecto
-   Reutilizar keys viejas
-   Subir datos sensibles a buckets públicos

------------------------------------------------------------------------
