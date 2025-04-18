# cl-autoapi-demo 🚀

**Proyecto de demostración** de automatización de pruebas de API con Postman, Newman y Bash.  
*Finalidad:* Mostrar un flujo de trabajo fácil y escalable para integración en pipelines CI/CD.

---

## 📌 Objetivo de esta DEMO

Este proyecto es una **muestra técnica** que ilustra cómo:

- Implementar ejecución selectiva mediante tags
- Inyectar variables dinámicas en entornos de prueba
- Estructurar un proyecto escalable para testing

*Incluye colecciones de ejemplo (`LoginTest` y `UserTest`) con fines demostrativos.*

---

## 🔧 Funcionalidades técnicas

### 🎯 Ejecución selectiva por tags
#### Solo ejecuta tests con tag "login"
```bash
sh testrunner.sh -t "login"
```


El script solo ejecutará aquellas colecciones cuyo archivo de environment contenga el tag indicado, permitiendo una ejecución dirigida y eficiente.

---

### 🔁 Inyección dinámica de variables
Los archivos de entorno (.postman_environment.json) pueden tener variables vacías como protocol, host o tag, que se completan en tiempo de ejecución mediante:
```bash
sh testrunner.sh -h "reqres.in" -t "login" -p "https"
```

---
### 📈 Escalabilidad

Puedes agregar nuevas colecciones y entornos sin modificar el código. El script detecta automáticamente los archivos dentro de las carpetas correspondientes.


---
### 🐳 Cómo ejecutar (DEMO)

1. Construye la imagen:
   ```sh
   docker build -t cl-autoapi-demostration .
   ```
2. Ejecuta el contenedor:
   ```sh
   docker run --rm -it cl-autoapi-demostration -h "reqres.in" -t "login" -p "https"
   ```

---

### 🛠️ Stack tecnológico
  &emsp;
  <img src="https://www.vectorlogo.zone/logos/getpostman/getpostman-icon.svg" alt="postman" width="40" height="40" title="Postman"/>
  &emsp;
  <img src="https://github.com/user-attachments/assets/5aee0b39-cd80-48c9-bbd6-c1e778e70c3d" width="40" height="40" title="NPM">
  &emsp;
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/bash/bash-original.svg" alt="bash" width="40" height="40" title="Bash"/>
  &emsp;
