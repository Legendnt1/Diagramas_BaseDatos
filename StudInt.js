
// Creación de colección estudiante

db.createCollection("estudiante", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["nombre", "apellido_paterno", "apellido_materno", "fecha_nacimiento", "universidad", "carrera_universitaria"],
      properties: {
        nombre: { bsonType: "string" },
        apellido_paterno: { bsonType: "string" },
        apellido_materno: { bsonType: "string" },
        fecha_nacimiento: { bsonType: "date" },
        telefono: { bsonType: "string" },
        url_curriculum: { bsonType: "string" },
        descripcion: { bsonType: "string" },
        universidad: {
          bsonType: "object",
          required: ["nombre", "abreviatura", "tipo", "url_sitio_web", "telefono"],
          properties: {
            nombre: { bsonType: "string" },
            abreviatura: { bsonType: "string" },
            tipo: { bsonType: "string" },
            url_sitio_web: { bsonType: "string" },
            telefono: { bsonType: "string" },
            descripcion: { bsonType: "string" }
          }
        },
        carrera_universitaria: {
          bsonType: "object",
          required: ["nombre", "descripcion"],
          properties: {
            nombre: { bsonType: "string" },
            descripcion: { bsonType: "string" }
          }
        }
      }
    }
  }
});


// Creación de colección empresa

db.createCollection("empresa", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["ruc", "razon_social", "sector", "direccion", "telefono", "descripcion", "puestos"],
      properties: {
        ruc: { bsonType: "string" },
        razon_social: { bsonType: "string" },
        sector: {
          bsonType: "array",
          items: {
            bsonType: "string"
          }
        },
        direccion: { bsonType: "string" },
        telefono: { bsonType: "string" },
        descripcion: { bsonType: "string" },
        puestos: {
          bsonType: "array",
          items: {
            bsonType: "object",
            required: ["nombre", "lugar_practicas", "modalidad"],
            properties: {
              nombre: { bsonType: "string" },
              lugar_practicas: { bsonType: "string" },
              modalidad: {
                bsonType: "array",
                items: {
                  bsonType: "object",
                  required: ["tipo", "fecha_publicacion", "fecha_limite", "descripcion", "remuneracion"],
                  properties: {
                    tipo: { bsonType: "string" },
                    fecha_publicacion: { bsonType: "date" },
                    fecha_limite: { bsonType: "date" },
                    descripcion: { bsonType: "string" },
                    remuneracion: { bsonType: "number" }
                  }
                }
              }
            }
          }
        },
        aplicaciones: {
          bsonType: "array",
          items: {
            bsonType: "object",
            required: ["postulacion"],
            properties: {
              postulacion: {
                bsonType: "object",
                required: ["estudiante", "fecha_registro", "estado"],
                properties: {
                  estudiante: { bsonType: "objectId" },
                  fecha_registro: { bsonType: "date" },
                  estado: { bsonType: "string" }
                }
              }
            }
          }
        }
      }
    }
  }
});


// Inserción de 12 estudiantes:

db.estudiante.insertMany([
  {
    _id: ObjectId("64a000000000000000000001"),
    nombre: "Ana",
    apellido_paterno: "López",
    apellido_materno: "García",
    fecha_nacimiento: new Date("2000-01-01"),
    telefono: "999111222",
    url_curriculum: "http://mi-cv.com/ana",
    descripcion: "Estudiante de ingeniería",
    universidad: {
      nombre: "UPC",
      abreviatura: "UPC",
      tipo: "Privada",
      url_sitio_web: "http://www.upc.edu.pe",
      telefono: "911234567",
      descripcion: "Universidad privada en Lima"
    },
    carrera_universitaria: {
      nombre: "Ingeniería de Software",
      descripcion: "Carrera enfocada en desarrollo de software"
    }
  },
  {
    _id: ObjectId("64a000000000000000000002"),
    nombre: "Luis",
    apellido_paterno: "Martínez",
    apellido_materno: "Vega",
    fecha_nacimiento: new Date("1999-05-15"),
    telefono: "988777666",
    url_curriculum: "http://mi-cv.com/luis",
    descripcion: "Estudiante de ingeniería",
    universidad: {
      nombre: "PUCP",
      abreviatura: "PUCP",
      tipo: "Privada",
      url_sitio_web: "http://www.pucp.edu.pe",
      telefono: "914567890",
      descripcion: "Universidad privada en Lima"
    },
    carrera_universitaria: {
      nombre: "Ingeniería Informática",
      descripcion: "Carrera de tecnología"
    }
  },
  {
    _id: ObjectId("64a000000000000000000003"),
    nombre: "María",
    apellido_paterno: "Ramos",
    apellido_materno: "Silva",
    fecha_nacimiento: new Date("2001-02-10"),
    telefono: "987654321",
    url_curriculum: "http://mi-cv.com/maria",
    descripcion: "Estudiante de economía",
    universidad: {
      nombre: "San Marcos",
      abreviatura: "UNMSM",
      tipo: "Pública",
      url_sitio_web: "http://www.unmsm.edu.pe",
      telefono: "913456789",
      descripcion: "Universidad pública en Lima"
    },
    carrera_universitaria: {
      nombre: "Economía",
      descripcion: "Carrera de Economía"
    }
  },
  {
    _id: ObjectId("64a000000000000000000004"),
    nombre: "Carlos",
    apellido_paterno: "Fernández",
    apellido_materno: "Ruiz",
    fecha_nacimiento: new Date("1998-11-20"),
    telefono: "966555444",
    url_curriculum: "http://mi-cv.com/carlos",
    descripcion: "Estudiante de psicología",
    universidad: {
      nombre: "Ricardo Palma",
      abreviatura: "URP",
      tipo: "Privada",
      url_sitio_web: "http://www.urp.edu.pe",
      telefono: "912345678",
      descripcion: "Universidad privada en Lima"
    },
    carrera_universitaria: {
      nombre: "Psicología",
      descripcion: "Carrera de Psicología"
    }
  },
  {
    _id: ObjectId("64a000000000000000000005"),
    nombre: "Paula",
    apellido_paterno: "Salazar",
    apellido_materno: "Mendoza",
    fecha_nacimiento: new Date("2002-03-08"),
    telefono: "955333222",
    url_curriculum: "http://mi-cv.com/paula",
    descripcion: "Estudiante de psicología",
    universidad: {
      nombre: "Cayetano Heredia",
      abreviatura: "UPCH",
      tipo: "Privada",
      url_sitio_web: "http://www.upch.edu.pe",
      telefono: "5145678",
      descripcion: "Universidad privada en Lima"
    },
    carrera_universitaria: {
      nombre: "Psicología",
      descripcion: "Carrera de Psicología"
    }
  },
  {
    _id: ObjectId("64a000000000000000000006"),
    nombre: "Jorge",
    apellido_paterno: "Castillo",
    apellido_materno: "Ortiz",
    fecha_nacimiento: new Date("2001-07-25"),
    telefono: "944222111",
    url_curriculum: "http://mi-cv.com/jorge",
    descripcion: "Estudiante de administración",
    universidad: {
      nombre: "ESAN",
      abreviatura: "ESAN",
      tipo: "Privada",
      url_sitio_web: "http://www.esan.edu.pe",
      telefono: "915678901",
      descripcion: "Universidad privada en Lima"
    },
    carrera_universitaria: {
      nombre: "Administración",
      descripcion: "Carrera de Administración"
    }
  },
  {
    _id: ObjectId("64a000000000000000000007"),
    nombre: "Andrea",
    apellido_paterno: "Torres",
    apellido_materno: "Ramírez",
    fecha_nacimiento: new Date("2000-10-12"),
    telefono: "933444555",
    url_curriculum: "http://mi-cv.com/andrea",
    descripcion: "Estudiante de contabilidad",
    universidad: {
      nombre: "U de Lima",
      abreviatura: "UL",
      tipo: "Privada",
      url_sitio_web: "http://www.ulima.edu.pe",
      telefono: "916789012",
      descripcion: "Universidad privada en Lima"
    },
    carrera_universitaria: {
      nombre: "Contabilidad",
      descripcion: "Carrera de Contabilidad"
    }
  },
  {
    _id: ObjectId("64a000000000000000000008"),
    nombre: "Diego",
    apellido_paterno: "Reyes",
    apellido_materno: "Flores",
    fecha_nacimiento: new Date("1999-12-30"),
    telefono: "922555666",
    url_curriculum: "http://mi-cv.com/diego",
    descripcion: "Estudiante de economía",
    universidad: {
      nombre: "Pacífico",
      abreviatura: "UP",
      tipo: "Privada",
      url_sitio_web: "http://www.up.edu.pe",
      telefono: "917890123",
      descripcion: "Universidad privada en Lima"
    },
    carrera_universitaria: {
      nombre: "Economía",
      descripcion: "Carrera de Economía"
    }
  },
  {
    _id: ObjectId("64a000000000000000000009"),
    nombre: "Valeria",
    apellido_paterno: "Chávez",
    apellido_materno: "Paredes",
    fecha_nacimiento: new Date("2002-06-18"),
    telefono: "911666777",
    url_curriculum: "http://mi-cv.com/valeria",
    descripcion: "Estudiante de Ingeniería de Sistemas",
    universidad: {
      nombre: "San Ignacio de Loyola",
      abreviatura: "USIL",
      tipo: "Privada",
      url_sitio_web: "http://www.usil.edu.pe",
      telefono: "018901234",
      descripcion: "Universidad privada en Lima"
    },
    carrera_universitaria: {
      nombre: "Ingeniería de Sistemas",
      descripcion: "Carrera de Ingeniería de Sistemas"
    }
  },
  {
    _id: ObjectId("64a00000000000000000000a"),
    nombre: "Sebastián",
    apellido_paterno: "Vargas",
    apellido_materno: "Morales",
    fecha_nacimiento: new Date("1998-04-03"),
    telefono: "999000111",
    url_curriculum: "http://mi-cv.com/sebastian",
    descripcion: "Estudiante de derecho",
    universidad: {
      nombre: "U Las Américas",
      abreviatura: "ULA",
      tipo: "Privada",
      url_sitio_web: "http://www.ula.edu.pe",
      telefono: "019012345",
      descripcion: "Universidad privada en Lima"
    },
    carrera_universitaria: {
      nombre: "Derecho",
      descripcion: "Carrera de Derecho"
    }
  },
  {
    _id: ObjectId("64a00000000000000000000b"),
    nombre: "Sofía",
    apellido_paterno: "Guerrero",
    apellido_materno: "Rojas",
    fecha_nacimiento: new Date("2001-09-14"),
    telefono: "977888999",
    url_curriculum: "http://mi-cv.com/sofia",
    descripcion: "Estudiante de biología",
    universidad: {
      nombre: "Agraria La Molina",
      abreviatura: "UNALM",
      tipo: "Pública",
      url_sitio_web: "http://www.lamolina.edu.pe",
      telefono: "012345678",
      descripcion: "Universidad pública en Lima"
    },
    carrera_universitaria: {
      nombre: "Biología",
      descripcion: "Carrera de Biología"
    }
  },
  {
    _id: ObjectId("64a00000000000000000000c"),
    nombre: "Fernando",
    apellido_paterno: "Ponce",
    apellido_materno: "Cruz",
    fecha_nacimiento: new Date("2000-05-05"),
    telefono: "966777888",
    url_curriculum: "http://mi-cv.com/fernando",
    descripcion: "Estudiante de derecho",
    universidad: {
      nombre: "USMP",
      abreviatura: "USMP",
      tipo: "Privada",
      url_sitio_web: "http://www.usmp.edu.pe",
      telefono: "013456789",
      descripcion: "Universidad privada en Lima"
    },
    carrera_universitaria: {
      nombre: "Derecho",
      descripcion: "Carrera de Derecho"
    }
  }
]);


// Inserción de 12 empresas

db.empresa.insertMany([
  {
    ruc: "20100010001",
    razon_social: "SoftTech SAC",
    sector: ["Tecnología", "Software"],
    direccion: "Av. Innovación 123",
    telefono: "900111222",
    descripcion: "Empresa de desarrollo de software",
    puestos: [
      {
        nombre: "Practicante de Desarrollo",
        lugar_practicas: "Remoto",
        modalidad: [
          {
            tipo: "Part-time",
            fecha_publicacion: new Date("2025-07-01"),
            fecha_limite: new Date("2025-07-31"),
            descripcion: "Desarrollo de aplicaciones web",
            remuneracion: 1200
          }
        ]
      }
    ],
    aplicaciones: [
      {
        postulacion: {
          estudiante: ObjectId("64a000000000000000000001"),
          fecha_registro: new Date("2025-07-02"),
          estado: "Pendiente"
        }
      },
      {
        postulacion: {
          estudiante: ObjectId("64a000000000000000000009"),
          fecha_registro: new Date("2025-07-03"),
          estado: "Aceptado"
        }
      }
    ]
  },
  {
    ruc: "20100010002",
    razon_social: "EcoFinanzas SAC",
    sector: ["Finanzas", "Economía"],
    direccion: "Jr. Economía 456",
    telefono: "900222333",
    descripcion: "Consultora económica",
    puestos: [
      {
        nombre: "Asistente de Análisis Económico",
        lugar_practicas: "Presencial",
        modalidad: [
          {
            tipo: "Full-time",
            fecha_publicacion: new Date("2025-07-05"),
            fecha_limite: new Date("2025-08-05"),
            descripcion: "Apoyo en análisis de datos económicos",
            remuneracion: 1500
          }
        ]
      }
    ],
    aplicaciones: [
      {
        postulacion: {
          estudiante: ObjectId("64a000000000000000000003"),
          fecha_registro: new Date("2025-07-06"),
          estado: "Pendiente"
        }
      },
      {
        postulacion: {
          estudiante: ObjectId("64a000000000000000000008"),
          fecha_registro: new Date("2025-07-06"),
          estado: "Pendiente"
        }
      }
    ]
  },
  {
    ruc: "20100010003",
    razon_social: "PsicoBienestar SAC",
    sector: ["Salud", "Psicología"],
    direccion: "Calle Salud Mental 789",
    telefono: "900333444",
    descripcion: "Centro de salud mental",
    puestos: [
      {
        nombre: "Practicante de Psicología Clínica",
        lugar_practicas: "Presencial",
        modalidad: [
          {
            tipo: "Part-time",
            fecha_publicacion: new Date("2025-07-10"),
            fecha_limite: new Date("2025-08-10"),
            descripcion: "Apoyo en sesiones terapéuticas",
            remuneracion: 1000
          }
        ]
      }
    ],
    aplicaciones: [
      {
        postulacion: {
          estudiante: ObjectId("64a000000000000000000004"),
          fecha_registro: new Date("2025-07-11"),
          estado: "Pendiente"
        }
      },
      {
        postulacion: {
          estudiante: ObjectId("64a000000000000000000005"),
          fecha_registro: new Date("2025-07-11"),
          estado: "Pendiente"
        }
      }
    ]
  },
  {
    ruc: "20100010004",
    razon_social: "LegalPeru SAC",
    sector: ["Legal", "Consultoría"],
    direccion: "Av. Justicia 321",
    telefono: "900444555",
    descripcion: "Estudio de abogados",
    puestos: [
      {
        nombre: "Asistente Legal",
        lugar_practicas: "Presencial",
        modalidad: [
          {
            tipo: "Full-time",
            fecha_publicacion: new Date("2025-07-15"),
            fecha_limite: new Date("2025-08-15"),
            descripcion: "Apoyo en procesos legales",
            remuneracion: 1300
          }
        ]
      }
    ],
    aplicaciones: [
      {
        postulacion: {
          estudiante: ObjectId("64a00000000000000000000a") ,
          fecha_registro: new Date("2025-07-16"),
          estado: "Pendiente"
        }
      },
      {
        postulacion: {
          estudiante: ObjectId("64a00000000000000000000c"),
          fecha_registro: new Date("2025-07-16"),
          estado: "Pendiente"
        }
      }
    ]
  },
  {
    ruc: "20100010005",
    razon_social: "Artes y Creatividad SAC",
    sector: ["Diseño", "Creatividad"],
    direccion: "Av. Arte 123",
    telefono: "900555666",
    descripcion: "Agencia de diseño gráfico",
    puestos: [
      {
        nombre: "Practicante de Diseño Gráfico",
        lugar_practicas: "Remoto",
        modalidad: [
          {
            tipo: "Part-time",
            fecha_publicacion: new Date("2025-07-20"),
            fecha_limite: new Date("2025-08-20"),
            descripcion: "Diseño de material publicitario",
            remuneracion: 1100
          }
        ]
      }
    ]
  },
  {
    ruc: "20100010006",
    razon_social: "Contafin SAC",
    sector: ["Finanzas", "Contabilidad"],
    direccion: "Jr. Cuentas 456",
    telefono: "900666777",
    descripcion: "Empresa de servicios contables y financieros",
    puestos: [
      {
        nombre: "Practicante Contable",
        lugar_practicas: "Presencial",
        modalidad: [
          {
            tipo: "Part-time",
            fecha_publicacion: new Date("2025-07-25"),
            fecha_limite: new Date("2025-08-25"),
            descripcion: "Apoyo en registros contables y balances",
            remuneracion: 1200
          }
        ]
      }
    ],
    aplicaciones: [
      {
        postulacion: {
          estudiante: ObjectId("64a000000000000000000007"),
          fecha_registro: new Date("2025-07-06"),
          estado: "Pendiente"
        }
      }
    ]
  },
  {
    ruc: "20100010007",
    razon_social: "BioHealth SAC",
    sector: ["Salud", "Biología"],
    direccion: "Av. Ciencias 890",
    telefono: "900777888",
    descripcion: "Laboratorio de biotecnología",
    puestos: [
      {
        nombre: "Practicante de Biología Molecular",
        lugar_practicas: "Presencial",
        modalidad: [
          {
            tipo: "Full-time",
            fecha_publicacion: new Date("2025-07-27"),
            fecha_limite: new Date("2025-08-27"),
            descripcion: "Apoyo en proyectos de investigación biológica",
            remuneracion: 1400
          }
        ]
      }
    ],
    aplicaciones: [
      {
        postulacion: {
          estudiante: ObjectId("64a00000000000000000000b"),
          fecha_registro: new Date("2025-07-06"),
          estado: "Pendiente"
        }
      }
    ]
  },
  {
    ruc: "20100010008",
    razon_social: "AdminGlobal SAC",
    sector: ["Administración", "Negocios"],
    direccion: "Calle Gestión 234",
    telefono: "900888999",
    descripcion: "Consultora en gestión empresarial",
    puestos: [
      {
        nombre: "Practicante de Administración",
        lugar_practicas: "Remoto",
        modalidad: [
          {
            tipo: "Part-time",
            fecha_publicacion: new Date("2025-07-28"),
            fecha_limite: new Date("2025-08-28"),
            descripcion: "Apoyo en tareas administrativas y logísticas",
            remuneracion: 1100
          }
        ]
      }
    ]
  },
  {
    ruc: "20100010009",
    razon_social: "InnovaSoft SAC",
    sector: ["Tecnología", "Desarrollo"],
    direccion: "Av. Digital 321",
    telefono: "900999000",
    descripcion: "Start-up de desarrollo de software",
    puestos: [
      {
        nombre: "Practicante Front-End",
        lugar_practicas: "Remoto",
        modalidad: [
          {
            tipo: "Full-time",
            fecha_publicacion: new Date("2025-07-29"),
            fecha_limite: new Date("2025-08-29"),
            descripcion: "Diseño e implementación de interfaces web",
            remuneracion: 1500
          }
        ]
      }
    ]
  },
  {
    ruc: "20100010010",
    razon_social: "JurisConsult SAC",
    sector: ["Legal"],
    direccion: "Jr. Derecho 654",
    telefono: "900000111",
    descripcion: "Estudio jurídico especializado en derecho corporativo",
    puestos: [
      {
        nombre: "Practicante Jurídico",
        lugar_practicas: "Presencial",
        modalidad: [
          {
            tipo: "Part-time",
            fecha_publicacion: new Date("2025-07-30"),
            fecha_limite: new Date("2025-08-30"),
            descripcion: "Apoyo en procesos legales y documentación",
            remuneracion: 1300
          }
        ]
      }
    ]
  },
  {
    ruc: "20100010011",
    razon_social: "HotelSol SAC",
    sector: ["Turismo", "Hotelería"],
    direccion: "Av. Turismo 777",
    telefono: "901111222",
    descripcion: "Cadena hotelera de lujo",
    puestos: [
      {
        nombre: "Practicante de Turismo",
        lugar_practicas: "Presencial",
        modalidad: [
          {
            tipo: "Full-time",
            fecha_publicacion: new Date("2025-08-01"),
            fecha_limite: new Date("2025-09-01"),
            descripcion: "Apoyo en atención al cliente y gestión de reservas",
            remuneracion: 1200
          }
        ]
      }
    ]
  },
  {
    ruc: "20100010012",
    razon_social: "DeportesFit SAC",
    sector: ["Deportes", "Salud"],
    direccion: "Av. Fitness 888",
    telefono: "901222333",
    descripcion: "Centro deportivo integral",
    puestos: [
      {
        nombre: "Practicante de Entrenamiento Personal",
        lugar_practicas: "Presencial",
        modalidad: [
          {
            tipo: "Part-time",
            fecha_publicacion: new Date("2025-08-02"),
            fecha_limite: new Date("2025-09-02"),
            descripcion: "Apoyo en rutinas de entrenamiento y asesoría",
            remuneracion: 1000
          }
        ]
      }
    ]
  }
]);

