# AsistenteVirtual
Asistente virtual especifico para proyecto personal.


# Bot Generador de Entornos Docker

## Arquitectura

[Diagrama: Telegram → n8n (webhook) → Groq (IA) → OpenHands → Docker]

- **n8n**: orquestador de flujos (puerto 5678)
- **OpenHands**: ejecutor de Docker
- **Groq (llama3-70b)**: genera los docker-compose.yml
- **Telegram Bot**: interfaz de usuario

## Cómo arrancar

### Requisitos
- Docker Desktop para Mac (Apple Silicon)
- Cuenta en Groq (gratuita)

### Pasos
1. Clona el repositorio
2. Copia tu API key de Groq
3. Ejecuta: docker compose up -d
4. Accede a n8n: http://localhost:5678
5. Importa el workflow desde exports/workflow-n8n.json

## Capturas de pantalla
[ver carpeta /capturas]