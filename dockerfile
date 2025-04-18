FROM node:18-slim

# Instala bash, jq y git
RUN apt-get update && \
    apt-get install -y bash jq git && \
    npm install -g newman && \
    apt-get clean

# Copia el proyecto al contenedor
WORKDIR /app
COPY . .

# Da permisos de ejecución al script
RUN chmod +x testrunner.sh

# Comando por defecto: muestra ayuda
ENTRYPOINT ["bash", "testrunner.sh"]

