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
(1,'Profesor1', 'Perrito2002'),
(1,'Profesor2', 'Carro2022'),
(1,'Profesor3', 'Carro2022');
(1,'Profesor4', 'Carro2022');
(1,'Profesor5', 'Carro2022');
(1,'Profesor6', 'Carro2022');
(2,'Estudiante1', 'Carro2022');
(2,'Estudiante2', 'Carro2022');
(2,'Estudiante3', 'Carro2022');



INSERT INTO DBO.Prestamo( idUsuario, idLibro,fechaPrestamo, fechaDevolucion, devuelto)
VALUES
(1,1, '2022-02-19', null, 0),
(2,2, '2022-02-14', '2022-05-12', 1);


-- CONSULTA DE PRESTAMOS ACTIVOS


CREATE PROCEDURE ConsultarPrestamosActivos
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

execute ConsultarPrestamosActivos

--Consulta de Prestamos devueltos

CREATE PROCEDURE ConsultarPrestamosDevueltos
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

execute ConsultarPrestamosDevueltos


CREATE PROCEDURE realizarPrestamo
	@IdLibroParam int,
	@IdUsuarioParam int
AS
BEGIN	
	BEGIN TRY 
		---- consultar si el libro existe

		CREATE TABLE #TMPLibro
		(
		  idLibros int, autor varchar(20), titulo varchar(25), fechaLanzamiento date, descripcion varchar(300)
		)

		INSERT INTO #TMPLibro EXEC [libro].[dbo].[ConsultarLibro] @IdLibro = @IdLibroParam

		IF NOT EXISTS (SELECT * FROM #TMPLibro WHERE idLibros = @IdLibroParam)
		BEGIN
			SELECT 'Libro no existe'
			RETURN;
		END
			

		---- consultar si hay prestamo activo que contenga el libro que se quiere prestar
		CREATE TABLE #TMPPrestamoActivo
		(
		  idPrestamo int, idLibros int, titulo varchar(25), fechaPrestamo date, fechaDevolucion date, devuelto bit
		)

		INSERT INTO #TMPPrestamoActivo EXEC ConsultarPrestamosActivos

		IF EXISTS (SELECT pa.idLibros FROM #TMPPrestamoActivo as pa INNER JOIN #TMPLibro as l on pa.idLibros = l.idLibros WHERE pa.idLibros = @IdLibroParam)
		BEGIN
			SELECT 'Libro esta actualmente en otro prestamo activo'
			RETURN;
		END

		--- ver si es un estudiante el usuario
			
		DECLARE @esEstudiante BIT
		EXEC [DESKTOP-4QADVM8\SQLFINANCIERO].[sisFinanciero].[dbo].[ValidarEstudiante] @IdUsuario = @IdUsuarioParam,  @flat = @esEstudiante OUTPUT


		--- ver si es un profesor el usuario
			
		DECLARE @esProfesor BIT
		EXEC [DESKTOP-4QADVM8\SQLRH_CTG].[recursosHumanosCTG].[dbo].[ValidarProfesorConUsuario] @IdUsuario = @IdUsuarioParam,  @flat = @esProfesor OUTPUT

		--- si no es profesor ni estudiante es porque esta inactivo o no existe estudiante/profesor registrado al usuario
		IF @esEstudiante = 0 AND @esProfesor = 0
		BEGIN
			SELECT 'Estudiante/Profesor no activo o no existe'
			RETURN;
		END

		--- revisar que no tenga una deuda

		DECLARE @tieneDeuda BIT
		EXEC [DESKTOP-4QADVM8\SQLFINANCIERO].[sisFinanciero].[dbo].[ValidarDeudas] @IdUsuario = @IdUsuarioParam,  @flat = @tieneDeuda OUTPUT

		IF @tieneDeuda = 1
		BEGIN
			SELECT 'Usuario cuenta con deudas activas'
			RETURN;
		END

		INSERT INTO DBO.Prestamo(idUsuario, idLibro,fechaPrestamo, fechaDevolucion, devuelto)
		VALUES(@IdUsuarioParam, @IdLibroParam, CAST(GETDATE() AS DATE), null, 0);

		SELECT 'Prestamo realizado correctamente';

		DROP TABLE #TMPLibro
		DROP TABLE #TMPPrestamoActivo

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

EXEC realizarPrestamo @IdLibroParam = 1, @IdUsuarioParam = 7 -- libro en prestamo
EXEC realizarPrestamo @IdLibroParam = 2, @IdUsuarioParam = 10 -- usuario no existe
EXEC realizarPrestamo @IdLibroParam = 2, @IdUsuarioParam = 8 -- usuario con deudas activas
EXEC realizarPrestamo @IdLibroParam = 2, @IdUsuarioParam = 7 -- se realiza prestamo

select * from dbo.prestamo
delete from dbo.prestamo where idUsuario = 7