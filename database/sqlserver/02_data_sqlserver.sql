-- =================================================================
-- SCRIPT DE INSERCIÓN DE DATOS PARA SQL SERVER (NODO QUITO)
-- =================================================================

USE AndesExpress;
GO

-- Limpiar tablas antes de insertar para evitar duplicados
DELETE FROM Entrega;
DELETE FROM Ruta;
DELETE FROM Mantenimiento;
DELETE FROM Vehiculo_Mantenimiento;
DELETE FROM Vehiculo_Operativo;
DELETE FROM Conductor;
DELETE FROM Centro_Operacion;
-- Reseteamos los contadores de IDENTITY
DBCC CHECKIDENT ('Entrega', RESEED, 0);
DBCC CHECKIDENT ('Ruta', RESEED, 0);
DBCC CHECKIDENT ('Mantenimiento', RESEED, 0);
DBCC CHECKIDENT ('Vehiculo_Operativo', RESEED, 0);
DBCC CHECKIDENT ('Conductor', RESEED, 0);
DBCC CHECKIDENT ('Centro_Operacion', RESEED, 0);
GO

-- 1. Insertar Centros de Operación
SET IDENTITY_INSERT Centro_Operacion ON;
INSERT INTO Centro_Operacion (id_centro_op, nombre_centro, ciudad, direccion) VALUES 
(1, 'AndesExpress - Hub Quito', 'Quito', 'Av. de los Shyris N35-174'),
(2, 'AndesExpress - Puerto GYE', 'Guayaquil', 'Av. 9 de Octubre 510'),
(3, 'AndesExpress - Austro CUE', 'Cuenca', 'Calle Larga 8-27');
SET IDENTITY_INSERT Centro_Operacion OFF;
GO

-- 2. Insertar Conductores
SET IDENTITY_INSERT Conductor ON;
INSERT INTO Conductor (id_conductor, cedula, nombre, apellido, tipo_licencia, fecha_contratacion, Conductor_id_centro_op) VALUES
(1, '1712345678', 'Juan', 'Perez', 'E', '2022-01-15', 1),
(2, '0987654321', 'Carlos', 'Gomez', 'C', '2023-05-20', 2),
(3, '0102030405', 'Ana', 'Martinez', 'E', '2021-11-10', 3);
SET IDENTITY_INSERT Conductor OFF;
GO

-- 3. Insertar Vehículos
SET IDENTITY_INSERT Vehiculo_Operativo ON;
INSERT INTO Vehiculo_Operativo (id_vehiculo, placa, Vehiculo_id_centro_op) VALUES
(1, 'PBA-1111', 1),
(2, 'GBA-2222', 2),
(3, 'ABC-3333', 3);
SET IDENTITY_INSERT Vehiculo_Operativo OFF;
GO
INSERT INTO Vehiculo_Mantenimiento (id_vehiculo, marca, modelo, ano_fabricacion, capacidad_carga_kg) VALUES
(1, 'Hino', '500 Series', 2021, 5000.00),
(2, 'Chevrolet', 'N-Series', 2023, 2500.00),
(3, 'Mercedes-Benz', 'Actros', 2022, 7000.00);
GO

-- 4. Insertar Rutas
SET IDENTITY_INSERT Ruta ON;
INSERT INTO Ruta (id_ruta, Ruta_id_vehiculo_asignado, Ruta_id_conductor_asignado, fecha_ruta, estado_ruta) VALUES
(1, 1, 1, '2025-07-13', 'Programada'),
(2, 2, 2, '2025-07-13', 'Programada'),
(3, 3, 3, '2025-07-14', 'Programada'),
(4, 1, 1, '2025-07-15', 'Programada');
SET IDENTITY_INSERT Ruta OFF;
GO

-- 5. Insertar Entregas
INSERT INTO Entrega (Entrega_id_ruta_asignada, descripcion_paquete, peso_kg, ciudad_origen, ciudad_destino, direccion_destino, estado_entrega) VALUES
(2, 'Repuestos Electrónicos', 150.5, 'Guayaquil', 'Quito', 'Eloy Alfaro y República', 'En tránsito'),
(3, 'Artesanías', 80.0, 'Cuenca', 'Quito', 'Amazonas y Patria', 'En bodega'),
(1, 'Suministros Médicos', 300.0, 'Quito', 'Guayaquil', 'Malecón 2000, Local 5', 'En tránsito'),
(3, 'Textiles', 250.75, 'Cuenca', 'Guayaquil', 'Urdesa Central, Calle Principal', 'En bodega'),
(1, 'Libros y Papelería', 120.0, 'Quito', 'Cuenca', 'Av. Remigio Crespo Toral', 'En tránsito'),
(4, 'Equipos de Sonido', 450.0, 'Quito', 'Guayaquil', 'Av. Victor Emilio Estrada 712', 'En bodega');
GO
