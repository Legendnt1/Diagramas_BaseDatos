-- CREATE DATABASE Studintv2

-- USE Studintv2

-- TABLAS

CREATE TABLE usuario (
  id_usuario     INT          NOT NULL,
  email          VARCHAR(255) NOT NULL,
  password       VARCHAR(255) NOT NULL,
  fecha_registro DATE         NOT NULL,
  PRIMARY KEY (id_usuario)
);

CREATE TABLE universidad (
  id_universidad INT          NOT NULL,
  nombre         VARCHAR(150) NOT NULL,
  abreviatura    CHAR(10)     NOT NULL,
  tipo           VARCHAR(25)  NOT NULL,
  url_sitio_web  VARCHAR(255) NOT NULL,
  telefono       VARCHAR(50)  NOT NULL,
  descripcion    VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_universidad)
);

CREATE TABLE carrera_universitaria (
  id_carrera  INT          NOT NULL,
  nombre      VARCHAR(100) NOT NULL,
  descripcion VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_carrera)
);

CREATE TABLE universidad_carrera_universitaria (
  idUniversidad INT NOT NULL,
  idCarrera     INT NOT NULL,
  PRIMARY KEY (idUniversidad, idCarrera)
);

CREATE TABLE estudiante (
  id_estudiante    INT          NOT NULL,
  id_usuario       INT          NOT NULL,
  id_universidad   INT          NOT NULL,
  id_carrera       INT          NOT NULL,
  nombre           VARCHAR(150) NOT NULL,
  apellido_paterno VARCHAR(150) NOT NULL,
  apellido_materno VARCHAR(150) NOT NULL,
  fecha_nacimiento DATE         NOT NULL,
  telefono         VARCHAR(50)  NOT NULL,
  url_curriculum   VARCHAR(255),
  descripcion      VARCHAR(255),
  PRIMARY KEY (id_estudiante)
);

CREATE TABLE empresa (
  id_empresa    INT          NOT NULL,
  id_usuario    INT          NOT NULL,
  ruc           VARCHAR(100) NOT NULL,
  razon_social  VARCHAR(250) NOT NULL,
  sector        VARCHAR(150) NOT NULL,
  direccion     VARCHAR(255) NOT NULL,
  telefono      VARCHAR(100) NOT NULL,
  url_sitio_web VARCHAR(255),
  descripcion   VARCHAR(255),
  PRIMARY KEY (id_empresa)
);

CREATE TABLE remuneracion (
  id_remuneracion INT     NOT NULL,
  monto           DECIMAL NOT NULL,
  PRIMARY KEY (id_remuneracion)
);

CREATE TABLE puesto (
  id_puesto        INT          NOT NULL,
  id_empresa       INT          NOT NULL,
  nombre           VARCHAR(150) NOT NULL,
  lugar_practicas  VARCHAR(250) NOT NULL,
  modalidad        VARCHAR(150) NOT NULL,
  fecha_publicacion DATE         NOT NULL,
  fecha_limite     DATE         NOT NULL,
  descripcion      VARCHAR(255) NOT NULL,
  id_remuneracion  INT          NOT NULL,
  PRIMARY KEY (id_puesto)
);

CREATE TABLE evaluacion (
  id_evaluacion INT NOT NULL,
  PRIMARY KEY (id_evaluacion)
);

CREATE TABLE evaluacion_carrera (
  id_evaluacion           INT          NOT NULL,
  id_carrera              INT          NOT NULL,
  comentario              VARCHAR(255) NOT NULL,
  calificacion_estudiante DECIMAL      NOT NULL,
  PRIMARY KEY (id_evaluacion)
);

CREATE TABLE evaluacion_psicotecnica (
  id_evaluacion INT NOT NULL,
  id_empresa    INT NOT NULL,
  PRIMARY KEY (id_evaluacion)
);

CREATE TABLE calificacion (
  id_evaluacion      INT          NOT NULL,
  id_estudiante      INT          NOT NULL,
  puntaje            DECIMAL      NOT NULL,
  comentario         VARCHAR(255) NOT NULL,
  estado_aprobatorio BIT          NOT NULL,
  PRIMARY KEY (id_evaluacion, id_estudiante)
);

CREATE TABLE calificacion_desempenio (
  id_calificacion    INT          NOT NULL,
  id_estudiante      INT          NOT NULL,
  id_puesto          INT          NOT NULL,
  puntaje            DECIMAL      NOT NULL,
  comentario         VARCHAR(255) NOT NULL,
  cumplimiento       VARCHAR(25)  NOT NULL,
  estado_aprobatorio BIT          NOT NULL,
  PRIMARY KEY (id_calificacion)
);

CREATE TABLE postulacion (
  id_puesto      INT         NOT NULL,
  id_estudiante  INT         NOT NULL,
  estado         VARCHAR(50) NOT NULL,
  fecha_registro DATE        NOT NULL,
  PRIMARY KEY (id_puesto, id_estudiante)
);

CREATE TABLE pregunta (
  id_pregunta INT          NOT NULL,
  contenido   VARCHAR(255) NOT NULL,
  puntaje     DECIMAL      NOT NULL,
  PRIMARY KEY (id_pregunta)
);

CREATE TABLE pregunta_carrera (
  id_pregunta_carrera   INT NOT NULL,
  id_pregunta           INT NOT NULL,
  id_evaluacion_carrera INT NOT NULL,
  PRIMARY KEY (id_pregunta_carrera)
);

CREATE TABLE pregunta_psicotecnica (
  id_pregunta_psicotecnica INT NOT NULL,
  id_pregunta              INT NOT NULL,
  id_evaluacion_psicotecnica INT NOT NULL,
  PRIMARY KEY (id_pregunta_psicotecnica)
);

CREATE TABLE respuesta_correcta (
  id_respuesta INT          NOT NULL,
  id_pregunta  INT          NOT NULL,
  contenido    VARCHAR(255) NOT NULL,
  explicacion  VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_respuesta)
);

CREATE TABLE respuesta_estudiante (
  id_respuesta       INT  NOT NULL,
  id_pregunta        INT  NOT NULL,
  id_estudiante         INT  NOT NULL,
  contenido_respuesta VARCHAR(25) NOT NULL,
  estado_aprobatorio BIT  NOT NULL,
  PRIMARY KEY (id_respuesta)
);

-- RELACIONES (FOREIGN KEYS)

ALTER TABLE estudiante
  ADD CONSTRAINT FK_usuario_TO_estudiante
    FOREIGN KEY (id_usuario)
    REFERENCES usuario (id_usuario);

ALTER TABLE estudiante
  ADD CONSTRAINT FK_universidad_TO_estudiante
    FOREIGN KEY (id_universidad)
    REFERENCES universidad (id_universidad);

ALTER TABLE estudiante
  ADD CONSTRAINT FK_carrera_TO_estudiante
    FOREIGN KEY (id_carrera)
    REFERENCES carrera_universitaria (id_carrera);

ALTER TABLE universidad_carrera_universitaria
  ADD CONSTRAINT FK_universidad_TO_ucarrera
    FOREIGN KEY (idUniversidad)
    REFERENCES universidad (id_universidad);

ALTER TABLE universidad_carrera_universitaria
  ADD CONSTRAINT FK_carrera_TO_ucarrera
    FOREIGN KEY (idCarrera)
    REFERENCES carrera_universitaria (id_carrera);

ALTER TABLE empresa
  ADD CONSTRAINT FK_usuario_TO_empresa
    FOREIGN KEY (id_usuario)
    REFERENCES usuario (id_usuario);

ALTER TABLE puesto
  ADD CONSTRAINT FK_empresa_TO_puesto
    FOREIGN KEY (id_empresa)
    REFERENCES empresa (id_empresa);

ALTER TABLE puesto
  ADD CONSTRAINT FK_remuneracion_TO_puesto
    FOREIGN KEY (id_remuneracion)
    REFERENCES remuneracion (id_remuneracion);

ALTER TABLE evaluacion_carrera
  ADD CONSTRAINT FK_evaluacion_TO_eval_carrera
    FOREIGN KEY (id_evaluacion)
    REFERENCES evaluacion (id_evaluacion);

ALTER TABLE evaluacion_carrera
  ADD CONSTRAINT FK_carrera_TO_eval_carrera
    FOREIGN KEY (id_carrera)
    REFERENCES carrera_universitaria (id_carrera);

ALTER TABLE evaluacion_psicotecnica
  ADD CONSTRAINT FK_evaluacion_TO_eval_psico
    FOREIGN KEY (id_evaluacion)
    REFERENCES evaluacion (id_evaluacion);

ALTER TABLE evaluacion_psicotecnica
  ADD CONSTRAINT FK_empresa_TO_eval_psico
    FOREIGN KEY (id_empresa)
    REFERENCES empresa (id_empresa);

ALTER TABLE calificacion
  ADD CONSTRAINT FK_eval_carrera_TO_calificacion
    FOREIGN KEY (id_evaluacion)
    REFERENCES evaluacion_carrera (id_evaluacion);

ALTER TABLE calificacion
  ADD CONSTRAINT FK_estudiante_TO_calificacion
    FOREIGN KEY (id_estudiante)
    REFERENCES estudiante (id_estudiante);

ALTER TABLE calificacion_desempenio
  ADD CONSTRAINT FK_puesto_TO_calificacion_desempenio
    FOREIGN KEY (id_puesto)
    REFERENCES puesto (id_puesto);

ALTER TABLE calificacion_desempenio
  ADD CONSTRAINT FK_estudiante_TO_calificacion_desempenio
    FOREIGN KEY (id_estudiante)
    REFERENCES estudiante (id_estudiante);

ALTER TABLE postulacion
  ADD CONSTRAINT FK_puesto_TO_postulacion
    FOREIGN KEY (id_puesto)
    REFERENCES puesto (id_puesto);

ALTER TABLE postulacion
  ADD CONSTRAINT FK_estudiante_TO_postulacion
    FOREIGN KEY (id_estudiante)
    REFERENCES estudiante (id_estudiante);

ALTER TABLE respuesta_correcta
  ADD CONSTRAINT FK_pregunta_TO_respuesta_correcta
    FOREIGN KEY (id_pregunta)
    REFERENCES pregunta (id_pregunta);

ALTER TABLE respuesta_estudiante
  ADD CONSTRAINT FK_pregunta_TO_respuesta_estudiante
    FOREIGN KEY (id_pregunta)
    REFERENCES pregunta (id_pregunta);

ALTER TABLE respuesta_estudiante
  ADD CONSTRAINT FK_usuario_TO_respuesta_estudiante
    FOREIGN KEY (id_estudiante)
    REFERENCES estudiante (id_estudiante);

ALTER TABLE pregunta_carrera
  ADD CONSTRAINT FK_pregunta_TO_pregunta_carrera
    FOREIGN KEY (id_pregunta)
    REFERENCES pregunta (id_pregunta);

ALTER TABLE pregunta_carrera
  ADD CONSTRAINT FK_eval_carrera_TO_pregunta_carrera
    FOREIGN KEY (id_evaluacion_carrera)
    REFERENCES evaluacion_carrera (id_evaluacion);

ALTER TABLE pregunta_psicotecnica
  ADD CONSTRAINT FK_pregunta_TO_pregunta_psico
    FOREIGN KEY (id_pregunta)
    REFERENCES pregunta (id_pregunta);

ALTER TABLE pregunta_psicotecnica
  ADD CONSTRAINT FK_eval_psico_TO_pregunta_psico
    FOREIGN KEY (id_evaluacion_psicotecnica)
    REFERENCES evaluacion_psicotecnica (id_evaluacion);
