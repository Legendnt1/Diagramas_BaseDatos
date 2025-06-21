USE Studintv2

-- Function para registrar las últimas postulaciones registradas

ALTER FUNCTION obtener_ultimas_postulaciones()
RETURNS TABLE
AS
RETURN
    SELECT
        e.id_estudiante,
        CONCAT(e.nombre, ' ', e.apellido_paterno, ' ', e.apellido_materno) AS 'Nombre Completo',
        uni.nombre as 'Universidad',
        emp.razon_social AS 'Empresa de Postulación',
        p.fecha_registro
    FROM postulacion p
    INNER JOIN estudiante e ON p.id_estudiante = e.id_estudiante
    INNER JOIN universidad uni ON uni.id_universidad = e.id_universidad
    INNER JOIN puesto pu ON p.id_puesto = pu.id_puesto
    INNER JOIN empresa emp ON pu.id_empresa = emp.id_empresa;


SELECT * FROM obtener_ultimas_postulaciones()
ORDER BY fecha_registro DESC;



-- Query de estudiantes que aprobaron todas sus evaluaciones (académicas y psicotécnicas)

SELECT 
    e.id_estudiante,
    CONCAT(e.nombre, ' ', e.apellido_paterno, ' ', e.apellido_materno) AS 'Nombre completo'
FROM estudiante e
WHERE NOT EXISTS (
    SELECT 1
    FROM calificacion c
    WHERE c.id_estudiante = e.id_estudiante
    AND c.estado_aprobatorio = 0
)
AND NOT EXISTS (
    SELECT 1
    FROM calificacion_desempenio cd
    WHERE cd.id_estudiante = e.id_estudiante
    AND cd.estado_aprobatorio = 0
);

-- Query para listar las empresas que más utilizan evaluaciones psicotécnicas

SELECT 
    emp.razon_social AS empresa,
    COUNT(DISTINCT ep.id_evaluacion) AS total_evaluaciones_psicotecnicas,
    COUNT(DISTINCT pp.id_pregunta) AS total_preguntas,
    ROUND(AVG(r.puntaje), 2) AS promedio_puntaje_respuestas
FROM evaluacion_psicotecnica ep
JOIN empresa emp ON ep.id_empresa = emp.id_empresa
JOIN pregunta_psicotecnica pp ON ep.id_evaluacion = pp.id_evaluacion_psicotecnica
JOIN respuesta_estudiante re ON pp.id_pregunta = re.id_pregunta
JOIN (
    SELECT 
        id_estudiante, id_pregunta,
        CASE WHEN estado_aprobatorio = 1 THEN 1.0 ELSE 0.0 END AS puntaje
    FROM respuesta_estudiante
) r ON r.id_estudiante = re.id_estudiante AND r.id_pregunta = re.id_pregunta
GROUP BY emp.razon_social
ORDER BY total_evaluaciones_psicotecnicas DESC, promedio_puntaje_respuestas DESC;

-- Query de ranking de empresas con tasa de conversión de postulantes aceptados

SELECT 
    emp.razon_social AS empresa,
    COUNT(p.id_estudiante) AS total_postulaciones,
    COUNT(CASE WHEN p.estado = 'Aceptado' THEN 1 END) AS total_aceptados,
    ROUND(
        CAST(COUNT(CASE WHEN p.estado = 'Aceptado' THEN 1 END) AS FLOAT) 
        / NULLIF(COUNT(p.id_estudiante), 0) * 100, 2
    ) AS porcentaje_aceptacion
FROM empresa emp
JOIN puesto pu ON emp.id_empresa = pu.id_empresa
JOIN postulacion p ON pu.id_puesto = p.id_puesto
GROUP BY emp.razon_social
ORDER BY porcentaje_aceptacion DESC, total_aceptados DESC;

