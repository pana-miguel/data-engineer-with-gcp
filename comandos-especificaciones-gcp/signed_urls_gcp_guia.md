# 🔐 Signed URLs en Google Cloud Storage (GCS)

Guía práctica y corregida sobre el uso de **Signed URLs** en Google Cloud Storage, incluyendo los métodos recomendados por Google.

---

## 📌 ¿Qué son las Signed URLs?

Las **Signed URLs** permiten otorgar acceso **temporal y controlado** a objetos privados en un bucket de GCS sin necesidad de hacer el bucket público.

Sirven para:
- Descargar archivos privados (GET)
- Subir o modificar archivos (PUT)
- Mantener control de tiempo y permisos

---

## 🧩 Método 1: Activar una Service Account usando su llave (JSON)

### 1️⃣ Activar la cuenta de servicio
```bash
gcloud auth activate-service-account prueba-firmado@gcp-test-miguel.iam.gserviceaccount.com --key-file=firma.json
```

🔹 Con este comando:
- Se activa una **service account** usando su llave privada.
- `gcloud` comienza a operar como esa cuenta.

---

### 2️⃣ Permisos sobre el bucket u objeto
A la service account se le deben asignar permisos según la acción requerida:

- `roles/storage.objectViewer` → Solo lectura
- `roles/storage.objectAdmin` → Lectura y escritura

Ejemplo (solo lectura):
```bash
gcloud storage buckets add-iam-policy-binding test_miguel_gcp1919   --member="serviceAccount:prueba-firmado@gcp-test-miguel.iam.gserviceaccount.com"   --role="roles/storage.objectViewer"
```

---

### 3️⃣ Generar Signed URL (lectura)
```bash
gcloud storage sign-url "gs://test_miguel_gcp1919/CONTRATO DE ARRENDAMIENTO 201 Bellavista.pdf" --duration=55s
```

📌 Resultado:
- URL válida por 55 segundos
- Solo permite **visualizar o descargar**
- No permite modificar el archivo

---

### ⚠️ Consideraciones
- Este método **solo tiene sentido si el bucket NO es público**
- No es recomendado para producción por el uso de llaves JSON

---

## 🔐 Método 2 (RECOMENDADO): Impersonación de Service Account

Este es el método recomendado por Google Cloud.

### 1️⃣ Requisito de permisos
La cuenta que ejecuta el comando debe tener:
```text
roles/iam.serviceAccountTokenCreator
```
sobre la service account impersonada.

---

### 2️⃣ Signed URL usando impersonación (GET)
```bash
gcloud storage sign-url gs://retencio-por-objeto1818/solicitud.jpg --duration=20s --impersonate-service-account=prueba-firmado@gcp-test-miguel.iam.gserviceaccount.com
```

✅ Ventajas:
- No se usan llaves JSON
- Mayor seguridad
- Ideal para entornos productivos

---

## ✏️ Signed URL para modificar o subir archivos (PUT)

Este tipo de URL permite **subir o reemplazar un archivo existente**.

```bash
gcloud storage sign-url gs://test_miguel_gcp1919/firma.json --http-verb=PUT --duration=1h --impersonate-service-account=nueva-pruiebakdldfsdf@gcp-test-miguel.iam.gserviceaccount.com --region=us-east5
```

📌 Notas importantes:
- El objeto se crea o reemplaza completamente
- Requiere permisos de escritura (`storage.objectCreator` o `storage.objectAdmin`)
- La carga se realiza desde herramientas como **Postman**, **curl** o backend

---

## 🧪 Ejemplo de carga con curl
```bash
curl -X PUT   -H "Content-Type: application/json"   --upload-file firma.json   "SIGNED_URL_GENERADA"
```

---

## 📊 Resumen de métodos

| Método | Seguridad | Llaves JSON | Recomendado |
|------|----------|-------------|-------------|
| Activar SA con key | Media | Sí | ❌ |
| Impersonación | Alta | No | ✅ |

---

## 🎯 Buenas prácticas
- Nunca subas llaves JSON a repositorios
- Usa impersonación siempre que sea posible
- Mantén duraciones cortas en Signed URLs
- Limita permisos al mínimo necesario

---

📁 Autor: Miguel Sierra  
📅 Fecha: Enero 2026
