CREATE TABLE jornada (
    idTurno int identity,
    turno varchar(32)
    PRIMARY KEY (idTurno)
);

CREATE TABLE materia (
    idMateria int identity,
    idProfesor int,
    idTurno int,
    materia varchar(100),
    creditos int
    PRIMARY KEY (idMateria),

    CONSTRAINT FK_MateriaIdTurno
    FOREIGN KEY (idTurno)
    REFERENCES jornada(idTurno),
);

CREATE TABLE alumno (
    carnet int identity,
    idUsuario int,
    nombre varchar(55),
    apellido varchar(55),
    fechaNacimiento date,
    correo varchar(35),
    telefono varchar(35)
    PRIMARY KEY (carnet),
);

CREATE TABLE matricula (
    idMatricula int identity,
    tipoMatricula int,
    carnet int,
    fechaMatricula date,
    idMateria int,
    PRIMARY KEY (idMatricula),

    CONSTRAINT FK_MatriculaCarnet
    FOREIGN KEY (carnet)
    REFERENCES alumno(carnet),

    CONSTRAINT FK_MatriculaIdMateria
    FOREIGN KEY (idMateria)
    REFERENCES materia(idMateria)
);

CREATE TABLE nota (
    idNota int identity,
    idMateria int,
    carnet int,
    nota int,
    PRIMARY KEY (idNota),

    CONSTRAINT FK_NotaCarnet
    FOREIGN KEY (carnet)
    REFERENCES alumno(carnet),

    CONSTRAINT FK_NotaIdMateria
    FOREIGN KEY (idMateria)
    REFERENCES materia(idMateria)
);