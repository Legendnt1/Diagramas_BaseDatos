
 -- Proporciona un análisis completo del mercado laboral por sector:
-- - Puestos disponibles
-- - Remuneraciones
-- - Postulaciones

USE Studint

WITH resumen_sector AS (
    SELECT 
        e.sector,
        COUNT(DISTINCT p.id_puesto) AS total_puestos,
        COUNT(DISTINCT po.id_estudiante) AS total_postulantes,
        CAST(AVG(r.monto) AS DECIMAL(10,2)) AS salario_promedio,
        MIN(r.monto) AS salario_minimo,
        MAX(r.monto) AS salario_maximo
    FROM empresa e
    JOIN puesto p ON e.id_empresa = p.id_empresa
    JOIN remuneracion r ON p.id_remuneracion = r.id_remuneracion
    LEFT JOIN postulacion po ON p.id_puesto = po.id_puesto
    GROUP BY e.sector
),
carrera_top AS (
    SELECT 
        e.sector,
        c.nombre AS carrera,
        COUNT(*) AS total_postulantes,
        ROW_NUMBER() OVER (PARTITION BY e.sector ORDER BY COUNT(*) DESC) AS rn
    FROM empresa e
    JOIN puesto p ON e.id_empresa = p.id_empresa
    JOIN postulacion po ON p.id_puesto = po.id_puesto
    JOIN estudiante es ON po.id_estudiante = es.id_estudiante
    JOIN carrera_universitaria c ON es.id_carrera = c.id_carrera
    GROUP BY e.sector, c.nombre
)
SELECT 
    s.sector,
    s.total_puestos,
    s.total_postulantes,
    s.salario_promedio,
    s.salario_minimo,
    s.salario_maximo
FROM resumen_sector s
ORDER BY s.salario_promedio DESC, s.total_puestos DESC;

-- Query para identificar los 5 puestos mejor remunerados en cada sector empresarial,
-- considerando solo puestos con modalidad presencial o híbrida

SELECT *
FROM (
    SELECT 
        e.sector,
        p.nombre AS puesto,
        r.monto AS remuneracion,
        ROW_NUMBER() OVER (PARTITION BY e.sector ORDER BY r.monto DESC) AS fila
    FROM puesto p
    JOIN empresa e ON p.id_empresa = e.id_empresa
    JOIN remuneracion r ON p.id_remuneracion = r.id_remuneracion
    WHERE p.modalidad IN ('Presencial', 'Híbrido')
) AS puestos_filtrados
WHERE fila <= 5
ORDER BY sector, remuneracion DESC;




 -- Genera un dashboard completo del rendimiento estudiantil incluyendo:
-- - Postulaciones
-- - Desempeño en las prácticas ya finalizadas

SELECT 
    e.nombre + ' ' + e.apellido_paterno AS estudiante,
    c.nombre AS carrera,
    COUNT(DISTINCT p.id_puesto) AS puestos_postulados,
    CAST(AVG(cd.puntaje) AS DECIMAL(5,2)) AS promedio_desempeño
FROM estudiante e
JOIN carrera_universitaria c ON e.id_carrera = c.id_carrera
LEFT JOIN postulacion p ON e.id_estudiante = p.id_estudiante
LEFT JOIN calificacion_desempenio cd ON e.id_estudiante = cd.id_estudiante
GROUP BY e.nombre, e.apellido_paterno, c.nombre
ORDER BY promedio_desempeño DESC, puestos_postulados DESC;


-- Store procedure para obtener estudiantes dentro de un rango de edad específico
-- por universidad

CREATE PROCEDURE usp_estudiantes_por_rango_edad
    @universidad_id INT,
    @edad_minima INT,
    @edad_maxima INT
AS
BEGIN
    SELECT 
        e.nombre + ' ' + e.apellido_paterno AS estudiante,
        cu.nombre AS carrera,
        DATEDIFF(YEAR, e.fecha_nacimiento, GETDATE()) AS edad
    FROM estudiante e
    JOIN carrera_universitaria cu ON e.id_carrera = cu.id_carrera
    WHERE e.id_universidad = @universidad_id
    AND DATEDIFF(YEAR, e.fecha_nacimiento, GETDATE()) BETWEEN @edad_minima AND @edad_maxima
    ORDER BY edad, estudiante;
END
GO

EXEC usp_estudiantes_por_rango_edad 3,17,21
