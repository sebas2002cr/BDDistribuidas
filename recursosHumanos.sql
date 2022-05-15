CREATE TABLE Departamento (
  IdDepartamento int identity,
  nombre varchar(32),
  PRIMARY KEY (IdDepartamento)
);

CREATE TABLE Puesto (
  IdPuesto int identity,
  IdDepartamento int,
  nombre varchar(32),
  PRIMARY KEY (IdPuesto),
  CONSTRAINT FK_PuestoIdDepartamento
  FOREIGN KEY (IdDepartamento)
  REFERENCES Departamento(IdDepartamento)
);

CREATE TABLE Sede (
  IdSede int identity,
  nombre varchar(32),
  PRIMARY KEY (IdSede)
);

CREATE TABLE Profesor (
  IdProfesor int identity,
  IdSede int,
  IdPuesto int,
  IdUsusario int,
  cedula varchar(32),
  nombre varchar(32),
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

--CARTAGO
insert into dbo.Departamento(nombre)
values('Escuela Computacion')

insert into Puesto(IdDepartamento,nombre)
values(1,'Profesor')

insert into Sede(nombre)
values ('Cartago'),('Alajuela'),('San Jose')

insert into Profesor( IdProfesor,IdSede,IdPuesto,IdUsuario,cedula,nombre,fechaNacimiento,activo)
values (1,1,1,1,'12345','Ernesto','12/02/1987','TRUE'),
       (2,1,1,2,'23456','Pancho','12/02/1985','TRUE')
	     
--SAN JOSE
insert into Profesor( IdProfesor,IdSede,IdPuesto,IdUsuario,cedula,nombre,fechaNacimiento,activo)
values (3,3,1,3,'123456','Roberto','12/02/1987','TRUE'),
       (4,3,1,4,'234567','Francisco','12/02/1985','TRUE')

--ALAJUELA
insert into Profesor( IdProfesor,IdSede,IdPuesto,IdUsuario,cedula,nombre,fechaNacimiento,activo)
values (5,2,1,5,'1234567','Jesus','16/02/1987','TRUE'),
       (6,2,1,6,'2345678','Mariana','14/02/2000','TRUE')

