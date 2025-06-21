-- Queries
-- Gianmarco Fabian Jiménez Guerra - U202123843

USE Studint
-- 1.- Query para conocer la cantidad de ingenierías que ha registrado cada universidad

SELECT 
    u.nombre AS universidad,
    COUNT(cu.id_carrera) AS total_ingenierias
FROM universidad_carrera_universitaria uc
JOIN universidad u ON u.id_universidad = uc.idUniversidad
JOIN carrera_universitaria cu ON cu.id_carrera = uc.idCarrera
WHERE cu.nombre LIKE 'Inge%'
GROUP BY u.nombre
ORDER BY total_ingenierias DESC;


-- 2.- Query para conocer a la empresa o empresas (razón social, sector y puestos publicados) con mayor cantidad de postulaciones publicadas

SELECT empresa, sector, puestos_publicados
FROM 
	(SELECT e.razon_social AS empresa, e.sector AS sector, COUNT(p.nombre) AS puestos_publicados
	FROM empresa e
	JOIN puesto p ON p.id_empresa = e.id_empresa
	GROUP BY e.razon_social, e.sector) G
WHERE puestos_publicados = (SELECT MAX(puestos_publicados)
								FROM (
								SELECT e.razon_social AS empresa, e.sector AS sector, COUNT(p.nombre) AS puestos_publicados
								FROM empresa e
								JOIN puesto p ON p.id_empresa = e.id_empresa
								GROUP BY e.razon_social, e.sector
								)G)

-- 3.- Query para conocer el promedio de las remuneraciones de los puestos 
--     de modalidad Remota por cada sector empresarial.
--     Se consideran sectores con más de un puesto publicado

SELECT 
    e.sector,
    COUNT(*) AS total_puestos_remotos,
    CAST(AVG(r.monto) AS DECIMAL(10,2)) AS promedio_remuneracion_remota
FROM puesto p
JOIN empresa e ON p.id_empresa = e.id_empresa
JOIN remuneracion r ON p.id_remuneracion = r.id_remuneracion
WHERE p.modalidad LIKE 'Remoto'
GROUP BY e.sector
HAVING COUNT(*) > 1
ORDER BY promedio_remuneracion_remota DESC;


-- Store Procedure:
-- Store procedure para conocer la cantidad de estudiantes que han realizado una postulación por universidad

CREATE PROCEDURE usp_obtener_postulaciones_por_universidad
@universidad_abreviada CHAR(10)
AS
BEGIN
	SELECT 
		u.nombre AS universidad,
		COUNT(p.id_estudiante) AS total_postulaciones
	FROM postulacion p
	JOIN estudiante e ON p.id_estudiante = e.id_estudiante
	JOIN universidad u ON e.id_universidad = u.id_universidad
	JOIN carrera_universitaria c ON e.id_carrera = c.id_carrera
	WHERE u.abreviatura = @universidad_abreviada
	GROUP BY u.nombre
	ORDER BY total_postulaciones DESC;
END
GO

EXEC usp_obtener_postulaciones_por_universidad 'UPCH'

