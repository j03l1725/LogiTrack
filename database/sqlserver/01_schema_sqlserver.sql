-- =================================================================
-- SCRIPT DE CREACIÓN DE ESQUEMA PARA SQL SERVER (NODO QUITO)
-- =================================================================

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AndesExpress')
BEGIN
    CREATE DATABASE AndesExpress;
END
GO

USE AndesExpress;
GO

-- Eliminar objetos en orden inverso para evitar errores de claves foráneas
IF OBJECT_ID('Entrega_QTO', 'V') IS NOT NULL DROP VIEW Entrega_QTO;
IF OBJECT_ID('Entrega', 'U') IS NOT NULL DROP TABLE Entrega;
IF OBJECT_ID('Ruta', 'U') IS NOT NULL DROP TABLE Ruta;
IF OBJECT_ID('Mantenimiento', 'U') IS NOT NULL DROP TABLE Mantenimiento;
IF OBJECT_ID('Vehiculo_Mantenimiento', 'U') IS NOT NULL DROP TABLE Vehiculo_Mantenimiento;
IF OBJECT_ID('Vehiculo_Operativo', 'U') IS NOT NULL DROP TABLE Vehiculo_Operativo;
IF OBJECT_ID('Conductor', 'U') IS NOT NULL DROP TABLE Conductor;
IF OBJECT_ID('Centro_Operacion', 'U') IS NOT NULL DROP TABLE Centro_Operacion;
GO

-- Crear las tablas
CREATE TABLE Centro_Operacion (
    id_centro_op INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre_centro VARCHAR(100) NOT NULL UNIQUE,
    ciudad VARCHAR(50) NOT NULL,
    direccion VARCHAR(255) NULL,
    telefono_contacto VARCHAR(15) NULL
);
GO

CREATE TABLE Conductor (
    id_conductor INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    cedula VARCHAR(10) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    tipo_licencia VARCHAR(1) NOT NULL CHECK (tipo_licencia IN ('C', 'E')),
    fecha_contratacion DATE NOT NULL,
    Conductor_id_centro_op INT NOT NULL,
    FOREIGN KEY (Conductor_id_centro_op) REFERENCES Centro_Operacion(id_centro_op)
);
GO

CREATE TABLE Vehiculo_Operativo (
    id_vehiculo INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    placa VARCHAR(8) NOT NULL UNIQUE,
    Vehiculo_id_centro_op INT NOT NULL,
    FOREIGN KEY (Vehiculo_id_centro_op) REFERENCES Centro_Operacion(id_centro_op)
);
GO

CREATE TABLE Vehiculo_Mantenimiento (
    id_vehiculo INT PRIMARY KEY NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    ano_fabricacion INT NOT NULL,
    capacidad_carga_kg DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculo_Operativo(id_vehiculo)
);
GO

CREATE TABLE Mantenimiento (
    id_mantenimiento INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Mantenimiento_id_vehiculo INT NOT NULL,
    fecha_mantenimiento DATE NOT NULL,
    kilometraje INT NOT NULL,
    tipo_mantenimiento VARCHAR(20) NOT NULL CHECK (tipo_mantenimiento IN ('Preventivo','Correctivo')),
    descripcion TEXT NOT NULL,
    costo DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Mantenimiento_id_vehiculo) REFERENCES Vehiculo_Operativo(id_vehiculo)
);
GO

CREATE TABLE Ruta (
    id_ruta INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Ruta_id_vehiculo_asignado INT NOT NULL,
    Ruta_id_conductor_asignado INT NOT NULL,
    fecha_ruta DATE NOT NULL,
    estado_ruta VARCHAR(20) NOT NULL CHECK (estado_ruta IN ('Programada','En curso','Completada')),
    kilometros_estimados INT NULL,
    FOREIGN KEY (Ruta_id_vehiculo_asignado) REFERENCES Vehiculo_Operativo(id_vehiculo),
    FOREIGN KEY (Ruta_id_conductor_asignado) REFERENCES Conductor(id_conductor)
);
GO

CREATE TABLE Entrega (
    id_entrega INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Entrega_id_ruta_asignada INT NOT NULL,
    descripcion_paquete TEXT NULL,
    peso_kg DECIMAL(10,2) NOT NULL,
    ciudad_origen VARCHAR(50) NOT NULL,
    ciudad_destino VARCHAR(50) NOT NULL,
    direccion_destino VARCHAR(255) NOT NULL,
    estado_entrega VARCHAR(20) NOT NULL CHECK (estado_entrega IN ('En bodega','En tránsito','Entregado','Cancelado')),
    fecha_creacion DATETIME2 NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (Entrega_id_ruta_asignada) REFERENCES Ruta(id_ruta)
);
GO

-- Crear la VISTA para el fragmento horizontal de Quito
CREATE VIEW Entrega_QTO AS
SELECT * FROM Entrega WHERE ciudad_destino = 'Quito';
GO
