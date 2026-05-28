# Bot Generador de Entornos Docker

**Asistente Virtual específico para proyecto personal**  
DAM · Sistemas Informáticos · Proyecto integrador — Tercera evaluación  
**Autor:** Jose Espinoza

---

## ¿Qué es esto?

Un bot de Telegram con IA que, a partir de una descripción en lenguaje natural, genera y despliega automáticamente un entorno Docker personalizado. El usuario describe lo que necesita y el sistema lo levanta.

```
Usuario: "Quiero un Nginx con PHP"
Bot: ✅ Entorno generado y desplegado
     services:
       nginx:
         image: nginx:latest
         ...
```

---

## Arquitectura

```
Telegram → n8n (webhook) → Groq IA → Execute Command → Docker
                ↑
            ngrok tunnel
```

| Componente | Función | Puerto |
|---|---|---|
| **n8n** | Orquestador de flujos | 5678 |
| **OpenHands** | Agente de ejecución | 3000 |
| **Groq (llama-3.1-8b-instant)** | Genera los docker-compose.yml | API |
| **Telegram Bot** | Interfaz de usuario | — |
| **ngrok** | Túnel HTTPS gratuito | — |

---

## Comandos del bot

| Comando | Descripción |
|---|---|
| Texto libre | Genera y despliega un entorno Docker |
| `/listar` | Muestra los contenedores activos |
| `/parar nombre` | Para un contenedor |
| `/eliminar nombre` | Elimina un contenedor |
| Cualquier otra cosa | Responde de forma conversacional |

---

## Requisitos

- Docker Desktop para Mac (Apple Silicon / M1/M2/M3/M4)
- Cuenta en [Groq](https://console.groq.com) (gratuita)
- Cuenta en [ngrok](https://ngrok.com) (gratuita)
- Bot de Telegram creado con [@BotFather](https://t.me/botfather)

---

## Cómo arrancar

### 1. Clona el repositorio

```bash
git clone https://github.com/Jin-maker-bit/docker-bot-dam.git
cd docker-bot-dam
```

### 2. Configura las variables de entorno

Edita el `docker-compose.yml` y añade tus claves:

```yaml
# En el servicio openhands:
- LLM_API_KEY=TU_API_KEY_DE_GROQ

# En el servicio n8n:
- WEBHOOK_URL=https://TU_URL_DE_NGROK/
```

### 3. Arranca el stack

```bash
docker compose up -d
```

Verifica que todo está corriendo:

```bash
docker compose ps
```

### 4. Arranca ngrok

```bash
ngrok http 5678 --request-header-add "ngrok-skip-browser-warning: true"
```

### 5. Importa el workflow en n8n

- Accede a n8n: [http://localhost:5678](http://localhost:5678)
- Ve a **Workflows → Import**
- Importa el fichero `exports/workflow-n8n.json`
- Configura las credenciales de Telegram y Groq en los nodos
- Activa el workflow con el toggle

### 6. Registra el webhook de Telegram

```bash
curl "https://api.telegram.org/botTU_TOKEN/setWebhook?url=https://TU_URL_NGROK/webhook/TU_WEBHOOK_ID/webhook"
```

---

## Estructura del proyecto

```
docker-bot-dam/
├── docker-compose.yml          # Stack principal (n8n + OpenHands)
├── Dockerfile                  # n8n con docker-cli y docker-compose
├── README.md                   # Este archivo
├── exports/
│   └── workflow-n8n.json       # Flujo exportado de n8n
├── docs/
│   └── documento-capturas.pdf  # Documento de entrega con capturas
└── capturas/
    └── ...                     # Capturas de pantalla del proyecto
```

---

## Flujo del sistema

```
1. Usuario escribe en Telegram
2. Telegram envía el mensaje al webhook de n8n (via ngrok)
3. n8n evalúa si es un comando (/listar, /parar, /eliminar) o texto libre
4. Si es texto libre → Groq genera un docker-compose.yml
5. Execute Command Plus despliega el compose con docker compose up -d
6. n8n responde al usuario por Telegram con el resultado
```

---

## Niveles completados

- ✅ **Nivel 1** — Infraestructura base: n8n + OpenHands en red bridge, conexión con Groq, system prompt configurado, README
- ✅ **Nivel 2** — Despliegue real: volúmenes de persistencia, despliegue automático de contenedores
- ✅ **Nivel 3** — Integración completa: bot de Telegram, túnel ngrok, gestión de contenedores (/listar, /parar, /eliminar)

---

## Notas técnicas

- La imagen de n8n usa un Dockerfile personalizado para instalar `docker-cli` y el plugin `docker compose`
- El bot usa `llama-3.1-8b-instant` de Groq por su velocidad y compatibilidad con ARM64
- Los volúmenes nombrados garantizan persistencia de datos entre reinicios
- ngrok con dominio estático gratuito evita cambios de URL

---

*Proyecto desarrollado para DAM · Sistemas Informáticos · 2025-2026*
