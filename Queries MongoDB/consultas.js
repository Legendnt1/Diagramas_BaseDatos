// Consultas Elizabeth

db.estudiante.find({
  "carrera_universitaria.nombre": "Psicología"
}, {
  nombre: 1,
  apellido_paterno: 1,
  apellido_materno: 1,
  universidad: 1,
  _id: 0
}).sort({
  apellido_paterno: 1
})


db.empresa.find({
  "puestos.modalidad.remuneracion": { $gt: 1000 }
}, {
  razon_social: 1,
  "puestos.nombre": 1,
  "puestos.modalidad.remuneracion": 1,
  _id: 0
})

// Consultas Andree

db.estudiante.find({
  "universidad.nombre": "UPC",
  "carrera_universitaria.nombre": "Ingeniería de Software"
}, {
  nombre: 1,
  apellido_paterno: 1,
  apellido_materno: 1,
  universidad: 1,
  carrera_universitaria: 1,
  _id: 0
})

db.empresa.find({
  "puestos.modalidad.tipo": "Part-time",
  "puestos.lugar_practicas": "Remoto"
}, {
  razon_social: 1,
  "puestos.nombre": 1,
  "puestos.lugar_practicas": 1,
  _id: 0
})

// Consultas Gianmarco

db.estudiante.aggregate([
  {
    $match: {
      "carrera_universitaria.nombre": "Derecho"
    }
  },
  {
    $group: {
      _id: "$carrera_universitaria.nombre",
      total_estudiantes: { $count: {} }
    }
  }
])

db.empresa.aggregate([
  {
    $match: {
      "puestos.modalidad.tipo": "Part-time"
    }
  },
  {
    $group: {
      _id: "$razon_social"
    }
  },
  {
    $count: "total_empresas_part_time"
  }
])


// Consultas César

db.empresa.aggregate([
  {
    $project: {
      razon_social: 1,
      totalPuestos: { $size: { $ifNull: ["$puestos", []] } }
    }
  },
  {
    $sort: { totalPuestos: -1 }
  }
]);


db.empresa.aggregate([
  { $unwind: "$aplicaciones" },
  {
    $match: {
      "aplicaciones.postulacion.estado": "Aceptado"
    }
  },
  {
    $count: "totalPostulantesAceptados"
  }
]);

// Consultas Flor

db.estudiante.find({
  $and: [
    { "universidad.tipo": "Privada" },
    {
      $or: [
        { "carrera_universitaria.nombre": /Ingeniería/i },
        { "carrera_universitaria.descripcion": /Ingeniería/i }
      ]
    }
  ]
});

db.estudiante.find({
  $and: [
    {
      "carrera_universitaria.nombre": {
        $in: ["Ingeniería de Software", "Ingeniería Informática"]
      }
    },
    {
      url_curriculum: {
        $regex: /^http:\/\/mi-cv\.com\//,
        $exists: true
      }
    },
    {
      $expr: {
        $lt: [
          {
            $dateDiff: {
              startDate: "$fecha_nacimiento",
              endDate: "$$NOW",
              unit: "year"
            }
          },
          26
        ]
      }
    }
  ]
});





