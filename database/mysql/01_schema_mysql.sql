-- =================================================================
-- SCRIPT DE CREACIÓN DE ESQUEMA PARA MYSQL (NODOS GYE/CUE)
-- =================================================================

CREATE DATABASE IF NOT EXISTS AndesExpress;
USE AndesExpress;

-- Eliminar objetos en orden inverso para evitar errores de claves foráneas
DROP VIEW IF EXISTS Entrega_QTO, Entrega_GYE, Entrega_CUE;
DROP TABLE IF EXISTS Entrega, Ruta, Mantenimiento, Vehiculo_Mantenimiento, Vehiculo_Operativo, Conductor, Centro_Operacion;

-- Crear las tablas
CREATE TABLE Centro_Operacion (
    id_centro_op INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre_centro VARCHAR(100) NOT NULL UNIQUE,
    ciudad VARCHAR(50) NOT NULL,
    direccion VARCHAR(255) NULL,
    telefono_contacto VARCHAR(15) NULL
);

CREATE TABLE Conductor (
    id_conductor INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    cedula VARCHAR(10) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    tipo_licencia ENUM('C', 'E') NOT NULL,
    fecha_contratacion DATE NOT NULL,
    Conductor_id_centro_op INT NOT NULL,
    FOREIGN KEY (Conductor_id_centro_op) REFERENCES Centro_Operacion(id_centro_op)
);

CREATE TABLE Vehiculo_Operativo (
    id_vehiculo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    placa VARCHAR(8) NOT NULL UNIQUE,
    Vehiculo_id_centro_op INT NOT NULL,
    FOREIGN KEY (Vehiculo_id_centro_op) REFERENCES Centro_Operacion(id_centro_op)
);

CREATE TABLE Vehiculo_Mantenimiento (
    id_vehiculo INT PRIMARY KEY NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    ano_fabricacion INT NOT NULL,
    capacidad_carga_kg DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculo_Operativo(id_vehiculo)
);

CREATE TABLE Mantenimiento (
    id_mantenimiento INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Mantenimiento_id_vehiculo INT NOT NULL,
    fecha_mantenimiento DATE NOT NULL,
    kilometraje INT NOT NULL,
    tipo_mantenimiento ENUM('Preventivo','Correctivo') NOT NULL,
    descripcion TEXT NOT NULL,
    costo DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Mantenimiento_id_vehiculo) REFERENCES Vehiculo_Operativo(id_vehiculo)
);

CREATE TABLE Ruta (
    id_ruta INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Ruta_id_vehiculo_asignado INT NOT NULL,
    Ruta_id_conductor_asignado INT NOT NULL,
    fecha_ruta DATE NOT NULL,
    estado_ruta ENUM('Programada','En curso','Completada') NOT NULL,
    kilometros_estimados INT NULL,
    FOREIGN KEY (Ruta_id_vehiculo_asignado) REFERENCES Vehiculo_Operativo(id_vehiculo),
    FOREIGN KEY (Ruta_id_conductor_asignado) REFERENCES Conductor(id_conductor)
);

CREATE TABLE Entrega (
    id_entrega INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Entrega_id_ruta_asignada INT NOT NULL,
    descripcion_paquete TEXT NULL,
    peso_kg DECIMAL(10,2) NOT NULL,
    ciudad_origen VARCHAR(50) NOT NULL,
    ciudad_destino VARCHAR(50) NOT NULL,
    direccion_destino VARCHAR(255) NOT NULL,
    estado_entrega ENUM('En bodega','En tránsito','Entregado','Cancelado') NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Entrega_id_ruta_asignada) REFERENCES Ruta(id_ruta)
);

-- Crear VISTAS para los fragmentos horizontales
CREATE VIEW Entrega_QTO AS SELECT * FROM Entrega WHERE ciudad_destino = 'Quito';
CREATE VIEW Entrega_GYE AS SELECT * FROM Entrega WHERE ciudad_destino = 'Guayaquil';
CREATE VIEW Entrega_CUE AS SELECT * FROM Entrega WHERE ciudad_destino = 'Cuenca';
