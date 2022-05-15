CREATE TABLE Departamento (
  IdDepartamento int identity,
  nombre varchar,
  PRIMARY KEY (IdDepartamento)
);

CREATE TABLE Puesto (
  IdPuesto int identity,
  IdDepartamento int,
  nombre varchar,
  PRIMARY KEY (IdPuesto),
  CONSTRAINT FK_PuestoIdDepartamento
  FOREIGN KEY (IdDepartamento)
  REFERENCES Departamento(IdDepartamento)
);

CREATE TABLE Sede (
  IdSede int identity,
  nombre varchar,
  PRIMARY KEY (IdSede)
);

CREATE TABLE Profesor (
  IdProfesor int identity,
  IdSede int,
  IdPuesto int,
  IdUsusario int,
  cedula varchar,
  nombre varchar,
  fechaNacimiento date,
  activo bit,
  PRIMARY KEY (IdProfesor),
  CONSTRAINT FK_ProfesorIdPuesto
  FOREIGN KEY (IdPuesto)
  REFERENCES Puesto(IdPuesto),
  CONSTRAINT FK_ProfesorIdSede
  FOREIGN KEY (IdSede)
  REFERENCES Sede(IdSede)
);

