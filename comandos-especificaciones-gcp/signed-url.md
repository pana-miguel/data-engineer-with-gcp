# 🔐 Guía de Signed URLs en Google Cloud Storage (GCP)

Autor: **Miguel Sierra**\
Rol objetivo: **Ingeniero de Datos 🚀**

------------------------------------------------------------------------

## 📌 ¿Qué es una Signed URL?

Una **Signed URL** permite otorgar acceso temporal y controlado a un
objeto en **Cloud Storage** sin necesidad de autenticación directa con
GCP.

📦 Casos de uso: - Compartir archivos privados temporalmente - Descargas
públicas con vencimiento - Subidas seguras desde frontend - Integración
con APIs y pipelines de datos

------------------------------------------------------------------------

## ⚙️ Requisitos previos

-   Bucket de Cloud Storage
-   Cuenta de servicio con permisos:
    -   `roles/storage.objectViewer` (GET)
    -   `roles/storage.objectCreator` (PUT)
-   Clave privada de la cuenta de servicio (`.json`)

------------------------------------------------------------------------

## 🔑 Crear Signed URL (GET -- descarga)

### Usando gcloud (cuenta de servicio)

``` bash
gcloud storage sign-url gs://MI_BUCKET/archivo.csv \
  --duration=1h \
  --private-key-file=key.json
```

👉 Genera una URL firmada válida por 1 hora para **descargar** el
archivo.

------------------------------------------------------------------------

## ⬆️ Signed URL para subida (PUT)

``` bash
gcloud storage sign-url gs://MI_BUCKET/archivo.csv \
  --duration=15m \
  --http-verb=PUT \
  --private-key-file=key.json
```

👉 Permite **subir** un archivo directamente al bucket.

------------------------------------------------------------------------

## ⬇️ Signed URL para eliminación (DELETE)

``` bash
gcloud storage sign-url gs://MI_BUCKET/archivo.csv \
  --duration=10m \
  --http-verb=DELETE \
  --private-key-file=key.json
```

👉 Permite eliminar un objeto usando una URL firmada.

------------------------------------------------------------------------

## 🔄 Signed URL para actualización (POST)

``` bash
gcloud storage sign-url gs://MI_BUCKET/archivo.csv \
  --duration=10m \
  --http-verb=POST \
  --private-key-file=key.json
```

👉 Permite operaciones avanzadas de carga multipart.

------------------------------------------------------------------------

## ⏱️ Control de expiración

``` bash
--duration=30m
--duration=1h
--duration=7d
```

📌 Recomendado: - Frontend: 5--15 minutos - Descargas externas: 1--24
horas

------------------------------------------------------------------------

## 🔐 Seguridad recomendada

-   Usa **Signed URLs cortas**
-   Nunca expongas la clave `.json`
-   Rota claves periódicamente
-   Usa buckets privados
-   Combina con **IAM mínimo necesario**

------------------------------------------------------------------------

## 🧪 Ejemplo de uso con curl

### Descargar archivo

``` bash
curl -X GET "SIGNED_URL"
```

### Subir archivo

``` bash
curl -X PUT -T archivo.csv "SIGNED_URL"
```

------------------------------------------------------------------------

## 🧠 En Data Engineering

Uso típico: - Frontend → GCS (raw) - API → Signed URL → procesamiento -
GCS → BigQuery → analytics

📂 Arquitectura recomendada: - raw/ - processed/ - curated/

------------------------------------------------------------------------

## ✅ Permisos mínimos recomendados

  Operación   Rol
  ----------- -----------------------
  Descargar   storage.objectViewer
  Subir       storage.objectCreator
  Borrar      storage.objectAdmin

------------------------------------------------------------------------

## 📘 Referencia útil

``` bash
gcloud storage sign-url --help
```

------------------------------------------------------------------------

🚀 **Conclusión**\
Las Signed URLs son clave para arquitecturas seguras, escalables y
desacopladas en GCP.
