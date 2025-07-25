-- =================================================================
-- SCRIPT DE INSERCIÓN DE DATOS PARA MYSQL (NODOS GYE/CUE)
-- =================================================================

USE AndesExpress;

-- Limpiar tablas antes de insertar para evitar duplicados
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Entrega;
TRUNCATE TABLE Ruta;
TRUNCATE TABLE Mantenimiento;
TRUNCATE TABLE Vehiculo_Mantenimiento;
TRUNCATE TABLE Vehiculo_Operativo;
TRUNCATE TABLE Conductor;
TRUNCATE TABLE Centro_Operacion;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. Insertar Centros de Operación
INSERT INTO Centro_Operacion (nombre_centro, ciudad, direccion) VALUES 
('AndesExpress - Hub Quito', 'Quito', 'Av. de los Shyris N35-174'),
('AndesExpress - Puerto GYE', 'Guayaquil', 'Av. 9 de Octubre 510'),
('AndesExpress - Austro CUE', 'Cuenca', 'Calle Larga 8-27');

-- 2. Insertar Conductores
INSERT INTO Conductor (cedula, nombre, apellido, tipo_licencia, fecha_contratacion, Conductor_id_centro_op) VALUES
('1712345678', 'Juan', 'Perez', 'E', '2022-01-15', 1),
('0987654321', 'Carlos', 'Gomez', 'C', '2023-05-20', 2),
('0102030405', 'Ana', 'Martinez', 'E', '2021-11-10', 3);

-- 3. Insertar Vehículos
INSERT INTO Vehiculo_Operativo (placa, Vehiculo_id_centro_op) VALUES
('PBA-1111', 1),
('GBA-2222', 2),
('ABC-3333', 3);
INSERT INTO Vehiculo_Mantenimiento (id_vehiculo, marca, modelo, ano_fabricacion, capacidad_carga_kg) VALUES
(1, 'Hino', '500 Series', 2021, 5000.00),
(2, 'Chevrolet', 'N-Series', 2023, 2500.00),
(3, 'Mercedes-Benz', 'Actros', 2022, 7000.00);

-- 4. Insertar Rutas
INSERT INTO Ruta (Ruta_id_vehiculo_asignado, Ruta_id_conductor_asignado, fecha_ruta, estado_ruta) VALUES
(1, 1, '2025-07-13', 'Programada'),
(2, 2, '2025-07-13', 'Programada'),
(3, 3, '2025-07-14', 'Programada'),
(1, 1, '2025-07-15', 'Programada'); -- Ruta para la entrega adicional

-- 5. Insertar Entregas
INSERT INTO Entrega (Entrega_id_ruta_asignada, descripcion_paquete, peso_kg, ciudad_origen, ciudad_destino, direccion_destino, estado_entrega) VALUES
(2, 'Repuestos Electrónicos', 150.5, 'Guayaquil', 'Quito', 'Eloy Alfaro y República', 'En tránsito'),
(3, 'Artesanías', 80.0, 'Cuenca', 'Quito', 'Amazonas y Patria', 'En bodega'),
(1, 'Suministros Médicos', 300.0, 'Quito', 'Guayaquil', 'Malecón 2000, Local 5', 'En tránsito'),
(3, 'Textiles', 250.75, 'Cuenca', 'Guayaquil', 'Urdesa Central, Calle Principal', 'En bodega'),
(1, 'Libros y Papelería', 120.0, 'Quito', 'Cuenca', 'Av. Remigio Crespo Toral', 'En tránsito'),
(4, 'Equipos de Sonido', 450.0, 'Quito', 'Guayaquil', 'Av. Victor Emilio Estrada 712', 'En bodega');
