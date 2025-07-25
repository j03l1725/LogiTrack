<div align="center">
  <img src="https://i.imgur.com/s6f2B3j.png" alt="LogiTrack Banner" width="800"/>
  <br>
  <h1><strong>Sistema de Base de Datos Distribuida "LogiTrack"</strong></h1>
  <p>Un prototipo de SBDD heterogéneo para la gestión logística, desarrollado con MySQL, SQL Server y Docker.</p>
  
  <p>
    <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL">
    <img src="https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white" alt="SQL Server">
    <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker">
    <img src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white" alt="Ubuntu">
  </p>
</div>

---

## **Descripción del Proyecto**

**LogiTrack** simula un entorno empresarial de logística con tres centros de operación en Ecuador (Quito, Guayaquil, Cuenca). El sistema gestiona la flota de vehículos, conductores, rutas y entregas, utilizando una arquitectura distribuida y heterogénea para mejorar el rendimiento, la confiabilidad y la escalabilidad.

Este proyecto fue desarrollado como parte de la asignatura de **Bases de Datos Distribuidas**, aplicando conceptos teóricos en un caso práctico y funcional.

### **Características Principales**

- **Arquitectura Heterogénea:** Combina Microsoft SQL Server (nodo central) y MySQL Server (nodos distribuidos) para simular la integración de sistemas diversos.
- **Fragmentación Horizontal:** La tabla `Entrega` está fragmentada por `ciudad_destino` para optimizar la localización de los datos y acelerar las consultas locales.
- **Fragmentación Vertical:** La tabla `Vehiculo` está dividida en fragmentos (`_Operativo` y `_Mantenimiento`) para mejorar el rendimiento, separando datos de acceso frecuente de los de acceso esporádico.
- **Replicación de Datos:** Las tablas maestras (Conductores, Vehículos, etc.) están replicadas en todos los nodos para garantizar la alta disponibilidad y la transparencia en las consultas.

---

## **Arquitectura del Sistema**

El sistema se compone de tres nodos que trabajan de forma coordinada.

```
                  +-------------------------+
                  |  Nodo Central (Quito)   |
                  |  [SQL Server en Docker] |
                  +-------------------------+
                         |       |
         +---------------+       +---------------+
         |                                       |
+--------------------+                   +----------------------+
| Nodo GYE (MySQL)   |                   |  Nodo CUE (MySQL)    |
| [Fragmento GYE]    |                   |  [Fragmento CUE]     |
+--------------------+                   +----------------------+
```

---

## 🛠**Stack Tecnológico y Requisitos**

Para poder levantar y operar este proyecto, necesitarás el siguiente software instalado en tu sistema. Se recomienda un entorno basado en Ubuntu Linux para una compatibilidad total con la guía.

### **Requisitos Previos**
| Software | Propósito | Link de Descarga / Guía de Instalación |
| :--- | :--- | :--- |
| ![Git](https://img.icons8.com/color/32/000000/git.png) **Git** | Control de versiones para clonar el repositorio. | `sudo apt install git` |
| ![Docker](https://img.icons8.com/color/32/000000/docker.png) **Docker & Docker Compose** | Para correr el contenedor de SQL Server. | [Guía de Instalación Oficial](https://docs.docker.com/engine/install/ubuntu/) |
| ![MySQL](https://img.icons8.com/color/32/000000/mysql-logo.png) **MySQL Server** | Para los nodos distribuidos. | `sudo apt install mysql-server` |
| ![MySQL Workbench](https://i.imgur.com/4J28JdG.png) **MySQL Workbench** | Cliente gráfico para gestionar MySQL. | [Descarga Oficial](https://dev.mysql.com/downloads/workbench/) |
| ![Azure Data Studio](https://i.imgur.com/2nZ2gL4.png) **Azure Data Studio** | Cliente gráfico para gestionar SQL Server. | [Descarga Oficial](https://learn.microsoft.com/es-es/sql/azure-data-studio/download-azure-data-studio) |

---

## **Guía de Instalación y Puesta en Marcha**

Sigue estos pasos para tener el entorno completo funcionando.

### **1. Clonar el Repositorio**
Abre una terminal y clona este proyecto en tu máquina local.
```bash
git clone [https://github.com/TU_USUARIO/logitrack-distributed-db.git](https://github.com/TU_USUARIO/logitrack-distributed-db.git)
cd logitrack-distributed-db
```
*(Recuerda reemplazar `TU_USUARIO` con tu nombre de usuario de GitHub)*

### **2. Levantar los Servidores de Base de Datos**
- **MySQL Server:** Asegúrate de que tu servicio local de MySQL esté activo.
  ```bash
  sudo systemctl start mysql
  ```
- **SQL Server:** Navega a la carpeta `docker/` y levanta el contenedor con Docker Compose. Este comando leerá el archivo `docker-compose.yml` y creará el contenedor por ti.
  ```bash
  cd docker
  docker-compose up -d
  ```
  *Nota: La primera vez, Docker descargará la imagen de SQL Server, lo que puede tardar unos minutos.*

### **3. Crear y Poblar las Bases de Datos**
- **MySQL (Nodos Guayaquil/Cuenca):**
  - Conéctate a tu servidor MySQL (`localhost:3306`) usando MySQL Workbench.
  - Abre y ejecuta los scripts en el siguiente orden:
    1. `database/mysql/01_schema_mysql.sql`
    2. `database/mysql/02_data_mysql.sql`

- **SQL Server (Nodo Quito):**
  - Conéctate a tu servidor SQL Server (`localhost:1433`) usando Azure Data Studio.
  - Abre y ejecuta los scripts en el siguiente orden:
    1. `database/sqlserver/01_schema_sqlserver.sql`
    2. `database/sqlserver/02_data_sqlserver.sql`

### **4. ¡Entorno Listo!**
¡Felicidades! El sistema distribuido ya está operativo. Ahora puedes conectarte a ambos servidores y empezar a ejecutar consultas.

---

## **Estructura del Repositorio**

```
/
├── database/         # Contiene todos los scripts SQL
│   ├── mysql/        # Scripts para los nodos MySQL
│   └── sqlserver/    # Scripts para el nodo SQL Server
├── documentation/    # Documentos del proyecto (Informe, Diagrama, etc.)
├── docker/           # Archivos de configuración de Docker
└── README.md         # Este archivo
```
