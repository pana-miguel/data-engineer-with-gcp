# 📘 Guía completa de comandos `gcloud` (con explicación)

Autor: **Miguel Sierra**\
Rol objetivo: **Ingeniero de Datos 🚀**

------------------------------------------------------------------------

## 🔧 Configuración básica

`gcloud init`\
Inicializa gcloud, configura proyecto y autenticación.

`gcloud version`\
Muestra la versión instalada.

`gcloud info`\
Información del entorno y configuración.

`gcloud help`\
Ayuda general de comandos.

------------------------------------------------------------------------

## ⚙️ Proyecto y configuración

`gcloud config list`\
Muestra la configuración activa.

`gcloud config get-value project`\
Consulta el proyecto actual.

`gcloud config set project PROJECT_ID`\
Define el proyecto activo.

`gcloud config unset project`\
Quita el proyecto activo.

------------------------------------------------------------------------

## 🔐 Autenticación

`gcloud auth login`\
Login interactivo de usuario.

`gcloud auth application-default login`\
Credenciales para aplicaciones (ADC).

`gcloud auth list`\
Lista cuentas autenticadas.

`gcloud auth revoke`\
Revoca accesos.

------------------------------------------------------------------------

## 📁 Proyectos

`gcloud projects list`\
Lista proyectos accesibles.

`gcloud projects describe PROJECT_ID`\
Describe un proyecto.

`gcloud projects create PROJECT_ID`\
Crea un proyecto.

`gcloud projects delete PROJECT_ID`\
Elimina un proyecto.

------------------------------------------------------------------------

## ☁️ Compute Engine

`gcloud compute instances list`\
Lista VMs.

`gcloud compute instances create VM_NAME`\
Crea una VM.

`gcloud compute ssh VM_NAME`\
Conecta por SSH.

------------------------------------------------------------------------

## 📦 Cloud Storage

`gcloud storage buckets list`\
Lista buckets.

`gcloud storage buckets create gs://BUCKET`\
Crea un bucket.

`gcloud storage cp archivo gs://BUCKET`\
Sube archivos.

------------------------------------------------------------------------

## 📊 BigQuery

`bq ls`\
Lista datasets.

`bq query --use_legacy_sql=false`\
Ejecuta SQL estándar.

------------------------------------------------------------------------

## 🧠 Nota de Data Engineering

Buenas prácticas: - Buckets raw / processed / curated - Versionamiento +
lifecycle - IAM mínimo necesario
