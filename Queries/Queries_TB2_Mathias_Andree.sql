-- 1. Universidades con más postulaciones activas y
-- detalle de carreras más postuladas
-- Muestra la cantidad de postulaciones por universidad. 
-- También indica cuál es la carrera que más estudiantes ha tenido (en la misma universidad).

USE Studint

SELECT 
    u.nombre AS universidad,
    COUNT(p.id_estudiante) AS total_postulaciones,
    cu.nombre AS carrera
FROM postulacion p
JOIN estudiante e ON p.id_estudiante = e.id_estudiante
JOIN universidad u ON e.id_universidad = u.id_universidad
JOIN carrera_universitaria cu ON cu.id_carrera = e.id_carrera
WHERE p.estado = 'Aceptado'
GROUP BY u.nombre, cu.nombre
ORDER BY total_postulaciones DESC;


-- 2. Ranking de estudiantes con mayor puntaje promedio en evaluaciones de 
-- carrera (solo aprobados)
-- Calcula el promedio de puntaje de evaluaciones para cada estudiante y lo ordena 
-- por mayor rendimiento, mostrando además su universidad y carrera.

SELECT 
    e.id_estudiante,
    e.nombre + ' ' + e.apellido_paterno + ' ' + e.apellido_materno AS estudiante,
    u.nombre AS universidad,
    cu.nombre AS carrera,
    ROUND(AVG(c.puntaje), 2) AS promedio_puntaje
FROM calificacion c
JOIN estudiante e ON e.id_estudiante = c.id_estudiante
JOIN universidad u ON u.id_universidad = e.id_universidad
JOIN carrera_universitaria cu ON cu.id_carrera = e.id_carrera
WHERE c.estado_aprobatorio = 1
GROUP BY e.id_estudiante, e.nombre, e.apellido_paterno, e.apellido_materno, u.nombre, cu.nombre
ORDER BY promedio_puntaje DESC;


-- 3. Puestos con más postulaciones, incluyendo detalles de la empresa y remuneración
-- Lista los puestos más populares con información detallada sobre la empresa, el puesto y el monto ofrecido.

SELECT 
    emp.razon_social AS empresa,
    pt.nombre AS puesto,
    pt.lugar_practicas,
    pt.modalidad,
    r.monto AS remuneracion,
    COUNT(p.id_estudiante) AS total_postulaciones,
    pt.fecha_publicacion,
    pt.fecha_limite
FROM puesto pt
JOIN empresa emp ON emp.id_empresa = pt.id_empresa
JOIN remuneracion r ON r.id_remuneracion = pt.id_remuneracion
LEFT JOIN postulacion p ON p.id_puesto = pt.id_puesto
GROUP BY emp.razon_social, pt.nombre, pt.lugar_practicas, pt.modalidad, r.monto, pt.fecha_publicacion, pt.fecha_limite
ORDER BY total_postulaciones DESC;


-- Procedure
-- Recibe una modalidad como parámetro (por ejemplo: 'Remoto', 'Presencial', 'Híbrido') 
-- y muestra un resumen de los puestos que se publicaron con esa modalidad.
-- modalidad: El tipo de modalidad que se filtra.
-- total_puestos: Cuántos puestos existen con esa modalidad.
-- fecha_mas_reciente: Cuál fue la última fecha en que se publicó un puesto con esa modalidad.
-- promedio_remuneracion: Cuánto se paga, en promedio, en los puestos de esa modalidad.

CREATE PROCEDURE usp_resumen_modalidad_filtrada
    @modalidad_filtrada VARCHAR(50)
AS
BEGIN
    SELECT 
        p.modalidad,
        COUNT(p.id_puesto) AS total_puestos,
        MAX(p.fecha_publicacion) AS fecha_mas_reciente,
        AVG(r.monto) AS promedio_remuneracion
    FROM puesto p
    JOIN remuneracion r ON r.id_remuneracion = p.id_remuneracion
    WHERE p.modalidad = @modalidad_filtrada
    GROUP BY p.modalidad;
END;
GO

EXEC usp_resumen_modalidad_filtrada @modalidad_filtrada = 'Remoto';
EXEC usp_resumen_modalidad_filtrada 'Presencial';
EXEC usp_resumen_modalidad_filtrada 'Híbrido';
