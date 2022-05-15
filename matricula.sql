CREATE TABLE jornada (
    idTurno int PRIMARY KEY NOT null,
    turno varchar(32)
);

CREATE TABLE materia (
    idMateria int PRIMARY KEY NOT null,
    idProfesor int,
    idTurno int,
    materia varchar(100),
    creditos int,

    FOREIGN KEY (idTurno)
    REFERENCES jornada(idTurno)
);

CREATE TABLE alumno (
    carnet int PRIMARY KEY NOT null,
    idUsuario int,
    nombre varchar(55),
    apellido varchar(55),
    fechaNacimiento date,
    correo varchar(35),
    telefono varchar(35),
    activo int
);

CREATE TABLE matricula (
    idMatricula int PRIMARY KEY NOT null,
    tipoMatricula int,
    carnet int,
    fechaMatricula date,
    idMateria int,

    FOREIGN KEY (carnet)
    REFERENCES alumno(carnet),

    FOREIGN KEY (idMateria)
    REFERENCES materia(idMateria)
);

CREATE TABLE nota (
    idNota int PRIMARY KEY NOT null,
    idMateria int,
    carnet int,

    FOREIGN KEY (carnet)
    REFERENCES alumno(carnet),

    FOREIGN KEY (idMateria)
    REFERENCES materia(idMateria)
);

-- datos
insert into jornada(idTurno, turno)
values (1, 'Dia'),
       (2, 'Noche');

insert into materia(idMateria, idProfesor, idTurno, materia, creditos)
values (1, 1, 1, 'Matematica', 3),
       (2, 2, 2, 'SO', 4),
       (3, 3, 1, 'Redes', 4),
       (4, 4, 1, 'Bases II', 3);

insert into alumno(carnet, idUsuario, nombre, apellido, fechaNacimiento, correo, telefono, activo)
values (2018026623, 7, 'Esteban', 'Mena', '12/02/1999', '@estudiantec.com', '12345678', 1),
       (2018026624, 8, 'Keylor', 'Velasquez', '12/02/2000', '@estudiantec.com', '12345678', 1),
       (2018026625, 9, 'Sebastian', 'Obando', '12/02/2000', '@estudiantec.com', '12345678', 1);

insert into matricula(idMatricula, tipoMatricula, fechaMatricula, idMateria)
values (1, 1, '12/02/2022', 1 ),
       (2, 2, '12/02/2022', 2),
       (3, 3, '12/02/2022', 3);