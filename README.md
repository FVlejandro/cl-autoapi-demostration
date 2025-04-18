# cl-autoapi-demostration

Automatización de pruebas de API con Postman, Newman y Bash.

## 🚀 Descripción

Este proyecto permite ejecutar colecciones de Postman de forma automatizada y escalable usando un script Bash (`testrunner.sh`). Puedes ejecutarlo localmente o dentro de un contenedor Docker para máxima portabilidad. Además, este modelo de automatización está diseñado para una fácil integración con pipelines de CI/CD, permitiendo ejecutar pruebas automáticamente en cada despliegue o integración.

### Funcionalidades principales

- **Ejecución selectiva por tags:** Puedes filtrar qué colecciones o escenarios ejecutar utilizando el parámetro `-t` (tag). El script solo ejecutará aquellas colecciones cuyo archivo de environment contenga el tag indicado, permitiendo una ejecución dirigida y eficiente.
- **Inyección dinámica de variables:** Los archivos de environment (`.postman_environment.json`) pueden contener variables vacías, como `protocol`, `host` o `tag`. El script detecta estas variables y permite inyectar sus valores desde la línea de comandos usando los parámetros `-p`, `-h` y `-t`. Así, puedes reutilizar los mismos archivos de entorno en diferentes ejecuciones y ambientes.
- **Escalabilidad:** Puedes agregar fácilmente nuevas colecciones y environments al proyecto. El script detecta automáticamente todos los archivos en las carpetas correspondientes, facilitando la ampliación del set de pruebas sin modificar el código.

Esta demo incluye 2 colecciones de pruebas listas para usar: `LoginTest` y `UserTest`.

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

---

## 📂 Estructura del proyecto

- `collections/` : Colecciones Postman
- `environments/` : Archivos de entorno Postman
- `scripts/` : Scripts auxiliares en caso de ser necesario
- `testrunner.sh` : Script principal de ejecución
- `Dockerfile` : Para empaquetar todo el entorno

---

## 📝 Ejemplo de uso

```sh
sh testrunner.sh -h "reqres.in" -t "login" -p "https"
```

---

