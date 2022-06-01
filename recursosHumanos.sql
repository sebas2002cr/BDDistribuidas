-- CARTAGO
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
  IdProfesor int,
  IdSede int,
  IdPuesto int,
  IdUsuario int,
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

-- datos
insert into dbo.Departamento(nombre)
values('Escuela Computacion')

insert into Puesto(IdDepartamento,nombre)
values(1,'Profesor')

insert into Sede(nombre)
values ('Cartago'),('Alajuela'),('San Jose')

insert into Profesor(IdProfesor,IdSede,IdPuesto,IdUsuario,cedula,nombre,fechaNacimiento,activo)
values (1,1,1,1,'12345','Ernesto','12/02/1987','TRUE'),
       (2,1,1,2,'23456','Pancho','12/02/1985','TRUE')


-- SAN JOSE
CREATE TABLE Profesor (
  IdProfesor int,
  IdSede int,
  IdPuesto int,
  IdUsuario int,
  cedula varchar(32),
  nombre varchar(32),
  fechaNacimiento date,
  activo bit,
  PRIMARY KEY (IdProfesor)
);

-- datos
insert into Profesor( IdProfesor,IdSede,IdPuesto,IdUsuario,cedula,nombre,fechaNacimiento,activo)
values (3,3,1,3,'123456','Roberto','12/02/1987','TRUE'),
       (4,3,1,4,'234567','Francisco','12/02/1985','TRUE')


-- ALAJUELA
CREATE TABLE Profesor (
  IdProfesor int,
  IdSede int,
  IdPuesto int,
  IdUsuario int,
  cedula varchar(32),
  nombre varchar(32),
  fechaNacimiento date,
  activo bit,
  PRIMARY KEY (IdProfesor)
);

-- datos
insert into Profesor( IdProfesor,IdSede,IdPuesto,IdUsuario,cedula,nombre,fechaNacimiento,activo)
values (5,2,1,5,'1234567','Jesus','12/02/1987','TRUE'),
       (6,2,1,6,'2345678','Mariana','12/02/2000','TRUE')



--PROCEDIMEINTO
DECLARE @active BIT
EXEC  ValidarProfesorConID @IdProfesor = 6,  @flat = @active OUTPUT
SELECT @active
	
AS
BEGIN
  BEGIN TRY   -- statements that may cause exceptions

   SET @flat = 'FALSE'
    
   IF EXISTS (SELECT Todos.IdProfesor,Todos.activo FROM(SELECT activo,IdProfesor FROM [dbo].[Profesor]
              UNION 
              SELECT activo,IdProfesor FROM [DESKTOP-4QADVM8\SQLRH_SJO].[recursosHumanossSJO].[dbo].[Profesor]
              UNION
              SELECT activo,IdProfesor FROM [DESKTOP-4QADVM8\SQLRH_ALJ].[recursosHumanosALJ].[dbo].[Profesor] )Todos
              WHERE Todos.IdProfesor = @IdProfesor AND Todos.activo = 'TRUE')
      BEGIN
        SET @flat = 'TRUE'
      END

    
END TRY  

BEGIN CATCH  -- statements that handle exception
			 SELECT  
            ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

END CATCH
END

DECLARE @active BIT
EXEC  ValidarProfesor @IdProfesor = 6,  @flat = @active OUTPUT
SELECT @active


CREATE PROCEDURE [dbo].[ValidarProfesorConUsuario]
	@IdUsuario INT,
	@flat BIT OUTPUT 
	
AS
BEGIN
  BEGIN TRY   -- statements that may cause exceptions

   SET @flat = 'FALSE'
    
   IF EXISTS (SELECT Todos.IdUsuario,Todos.activo FROM(SELECT activo,IdUsuario FROM [dbo].[Profesor]
              UNION 
              SELECT activo,IdUsuario FROM [DESKTOP-4QADVM8\SQLRH_SJO].[recursosHumanossSJO].[dbo].[Profesor]
              UNION
              SELECT activo,IdUsuario FROM [DESKTOP-4QADVM8\SQLRH_ALJ].[recursosHumanosALJ].[dbo].[Profesor] )Todos
              WHERE Todos.IdUsuario = @IdUsuarioAND Todos.activo = 'TRUE')
      BEGIN
        SET @flat = 'TRUE'
      END

    
END TRY  

BEGIN CATCH  -- statements that handle exception
			 SELECT  
            ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

END CATCH
END

DECLARE @active BIT
EXEC  ValidarProfesorConUsuario @IdUsuario = 1,  @flat = @active OUTPUT
SELECT @active