# cl-autoapi-demostration

Automatización de pruebas de API con Postman, Newman y Bash.

## 🚀 Descripción
Este proyecto permite ejecutar colecciones de Postman de forma automatizada usando un script Bash (`testrunner.sh`). Puedes ejecutarlo localmente o dentro de un contenedor Docker para máxima portabilidad.

---

## 📦 Requisitos

### Ejecución local
- Bash (Linux, MacOS o Git Bash en Windows)
- [jq](https://stedolan.github.io/jq/) (para parsear JSON)
- [Node.js y npm](https://nodejs.org/) (para instalar newman)
- [newman](https://www.npmjs.com/package/newman)

### Ejecución en contenedor (recomendado)
- Docker

---

## 🛠️ Instalación y uso local

1. Clona el repositorio:
   ```sh
   git clone https://github.com/FelipeCastilloPavez/cl-autoapi-demostration.git
   cd cl-autoapi-demostration
   ```
2. Instala las dependencias:
   ```sh
   npm install -g newman
   # En Linux/MacOS:
   sudo apt-get install jq
   # En Windows (Git Bash):
   # Descarga jq.exe y colócalo en tu PATH
   ```
3. Ejecuta el script:
   ```sh
   sh testrunner.sh -h "reqres.in" -t "login" -p "https"
   ```

---

## 🐳 Ejecución con Docker

1. Construye la imagen:
   ```sh
   docker build -t cl-autoapi-demostration .
   ```
2. Ejecuta el contenedor:
   ```sh
   docker run --rm -it cl-autoapi-demostration -h "reqres.in" -t "login" -p "https"
   ```
   Si quieres montar tus propias colecciones/environments:
   ```sh
   docker run --rm -it \
     -v "$PWD/collections:/app/collections" \
     -v "$PWD/environments:/app/environments" \
     cl-autoapi-demostration -h "reqres.in" -t "login" -p "https"
   ```

---

## 📂 Estructura del proyecto

- `collections/` : Colecciones Postman
- `environments/` : Archivos de entorno Postman
- `testrunner.sh` : Script principal de ejecución
- `Dockerfile` : Para empaquetar todo el entorno

---

## 📝 Ejemplo de uso

```sh
sh testrunner.sh -h "reqres.in" -t "login" -p "https"
```

---

## 📄 Notas
- Puedes agregar más colecciones y environments en sus carpetas respectivas.
- El script soporta filtrado por tag, host y protocolo.
- Si tienes dudas o quieres contribuir, ¡abre un issue o PR!
