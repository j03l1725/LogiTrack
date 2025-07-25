select * from AndesExpress.Entrega_GYE; --No funcionará porque solo es UIO

SELECT * from AndesExpress.dbo.Entrega_QTO;

select 
    c.nombre AS NombreConductor,
    c.apellido as ApellidoConductor,
    vo.placa as PlacaVehiculo,
    r.fecha_ruta as FechaDeRuta
from 
    AndesExpress.dbo.Ruta as r
JOIN
    AndesExpress.dbo.Conductor as c On r.Ruta_id_conductor_asignado = c.id_conductor
join
    AndesExpress.dbo.Vehiculo_Operativo as vo on r.Ruta_id_vehiculo_asignado = vo.id_vehiculo;



SELECT e.* FROM AndesExpress.dbo.Entrega e
JOIN AndesExpress.dbo.Ruta r ON e.Entrega_id_ruta_asignada = r.id_ruta
JOIN AndesExpress.dbo.Vehiculo_Operativo vo ON r.Ruta_id_vehiculo_asignado = vo.id_vehiculo
WHERE vo.placa = 'PBA-1111';

SELECT * FROM AndesExpress.dbo.Entrega_QTO;





