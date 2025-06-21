use Studint

-- Puesto con mayor remuneración de cada empresa
SELECT 
    e.id_empresa,
    e.razon_social AS nombre_empresa,
    p.nombre AS nombre_puesto,
    r.monto AS mayor_remuneracion
FROM 
    empresa e
JOIN 
    puesto p ON e.id_empresa = p.id_empresa
JOIN 
    remuneracion r ON p.id_remuneracion = r.id_remuneracion
WHERE 
    r.monto = (
        SELECT MAX(r2.monto)
        FROM puesto p2
        JOIN remuneracion r2 ON p2.id_remuneracion = r2.id_remuneracion
        WHERE p2.id_empresa = e.id_empresa
    )
ORDER BY 
    e.razon_social;

-- Puesto con el mejor promedio de desempenio

SELECT 
    p.id_puesto,
    p.nombre AS nombre_puesto,
    e.razon_social AS empresa,
    AVG(cd.puntaje) AS promedio_desempenio,
    COUNT(cd.id_calificacion) AS cantidad_evaluaciones
FROM 
    puesto p
JOIN 
    empresa e ON p.id_empresa = e.id_empresa
JOIN 
    calificacion_desempenio cd ON p.id_puesto = cd.id_puesto
GROUP BY 
    p.id_puesto, p.nombre, e.razon_social
HAVING 
    AVG(cd.puntaje) = (
        SELECT MAX(AVG_puntaje)
        FROM (
            SELECT AVG(cd2.puntaje) AS AVG_puntaje
            FROM calificacion_desempenio cd2
            GROUP BY cd2.id_puesto
        ) AS promedios
    );

-- Empresa con mayor promedio de remuneración 

SELECT 
    e.id_empresa,
    e.razon_social AS nombre_empresa,
    AVG(r.monto) AS promedio_remuneracion,
    COUNT(p.id_puesto) AS cantidad_puestos
FROM 
    empresa e
JOIN 
    puesto p ON e.id_empresa = p.id_empresa
JOIN 
    remuneracion r ON p.id_remuneracion = r.id_remuneracion
GROUP BY 
    e.id_empresa, e.razon_social
HAVING 
    COUNT(p.id_puesto) > 0  -- Solo empresAS con al menos un puesto
    AND AVG(r.monto) = (
        SELECT MAX(AVG_monto)
        FROM (
            SELECT AVG(r2.monto) AS AVG_monto
            FROM puesto p2
            JOIN remuneracion r2 ON p2.id_remuneracion = r2.id_remuneracion
            GROUP BY p2.id_empresa
        ) AS promedios_empresAS
    )
ORDER BY 
    e.razon_social;



-- Estudiantes con mejores calificaciones de cada universidad

CREATE FUNCTION MejorEstudiantesXUniv(@nu VARCHAR(150)) 
RETURNS TABLE
AS
RETURN (
    SELECT 
        e.id_estudiante AS 'Codigo',
        e.nombre + ' ' + e.apellido_paterno AS 'Estudiante',
        u.nombre AS 'Universidad',
        AVG(cal.puntaje) AS 'Promedio'
    FROM estudiante e
    JOIN universidad u ON e.id_universidad = u.id_universidad
    JOIN calificacion cal ON e.id_estudiante = cal.id_estudiante
    WHERE u.nombre = @nu
    GROUP BY e.id_estudiante, e.nombre, e.apellido_paterno, u.nombre
)
GO

SELECT * FROM dbo.MejorEstudiantesXUniv('Universidad Nacional Mayor de San Marcos')
