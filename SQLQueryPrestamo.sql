use Prestamos


CREATE TABLE TipoUsuario(
	idTipo int identity,
	tipo varchar(20)
	PRIMARY KEY (idTipo)
);


CREATE TABLE Usuario(
	idUsuario int identity,
	idtipo int,
	usuario varchar(120),
	contrasena varchar(20) 
	PRIMARY KEY (idUsuario)

	CONSTRAINT FK_UsuarioIdTipoUsuario
	FOREIGN KEY (idtipo)
	REFERENCES TipoUsuario(idtipo),
);

CREATE TABLE Prestamo(
	idPrestamo int identity,
	idUsuario int,
	idLibro int,
	idEmpleado int,
	fechaPrestamo date,
	fechaDevolucion date,
	devuelto bit
	PRIMARY KEY (idPrestamo),
	

	CONSTRAINT FK_PrestamoIdUsuario
	FOREIGN KEY (idUsuario)
	REFERENCES Usuario(idUsuario),
);




-- INSERT DE DATOS QUEMADOS EN BASE DE DATOS PRESTAMO



INSERT INTO DBO.TipoUsuario( tipo)
VALUES
('Profesor'),
( 'Estudiante');

INSERT INTO DBO.Usuario( idTipo, usuario, contrasena)
VALUES
(1,'Carlos Bogantes', 'Perrito2002'),
(2,'Sebastina Obando', 'Carro2022');



INSERT INTO DBO.Prestamo( idUsuario, idLibro,fechaPrestamo, fechaDevolucion, devuelto)
VALUES
(1,1, '2022-02-19', null, 0),
(2,2, '2022-02-14', '2022-05-12', 1);








-- CONSULTA DE PRESTAMOS ACTIVOS


CREATE PROCEDURE ConultarPrestamosActivos
AS
BEGIN
	BEGIN TRY 
		SELECT idPrestamo, libro.dbo.Libros.idLibros, libro.dbo.Libros.titulo  , fechaPrestamo, fechaDevolucion, devuelto FROM Prestamo
			INNER JOIN libro.dbo.Libros ON libro.dbo.Libros.idLibros = Prestamo.idLibro
				WHERE devuelto = 0
	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

execute ConultarPrestamosActivos



--Consulta de Prestamos devueltos



-- CONSULTA DE PRESTAMOS ACTIVOS


CREATE PROCEDURE ConultarPrestamosDevueltos
AS
BEGIN
	BEGIN TRY 
		SELECT idPrestamo, libro.dbo.Libros.idLibros, libro.dbo.Libros.titulo  , fechaPrestamo, fechaDevolucion, devuelto FROM Prestamo
			INNER JOIN libro.dbo.Libros ON libro.dbo.Libros.idLibros = Prestamo.idLibro
				WHERE devuelto = 1
	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

execute ConultarPrestamosDevueltos









