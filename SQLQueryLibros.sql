CREATE TABLE Categorias(
	idCategoria int identity,
	nombre varchar(20)
	PRIMARY KEY (idCategoria)
);


CREATE TABLE Idioma(
	idIdioma int identity,
	nombre varchar(20)
	PRIMARY KEY (idIdioma)
);


CREATE TABLE Editoriales(
	idEditorial int identity,
	nombre varchar(20),
	direccion varchar(100),
	telefono varchar(15),
	email varchar(35)
	PRIMARY KEY (idEditorial)
);


CREATE TABLE Autor(
	idAutor int identity,
	nombre varchar(20),
	apellidos varchar(45),
	fechaNacimiento date,
	nacionalidad varchar(20)
	PRIMARY KEY (idAutor)
);


CREATE TABLE Libros(
	idLibros int identity,
	idAutor int,
	idCategoria int,
	idEditorial int,
	idIdioma int,
	titulo varchar(25),
	fechaLanzamiento date,
	cantPaginas int,
	descripcion varchar(300)
	PRIMARY KEY (idLibros)


	CONSTRAINT FK_LibrosIdIdioma
	FOREIGN KEY (idIdioma)
	REFERENCES Idioma(idIdioma),

	CONSTRAINT FK_LibrosIdEditoriales
	FOREIGN KEY (idEditorial)
	REFERENCES Editoriales(idEditorial),

	CONSTRAINT FK_LibrosIdCategorias
	FOREIGN KEY (idCategoria)
	REFERENCES Categorias(idCategoria),

	CONSTRAINT FK_LibrosIdAutor
	FOREIGN KEY (idAutor)
	REFERENCES Autor(idAutor),
);


-- DATOS QUEMADOS

			
INSERT INTO DBO.Categorias ( nombre)
VALUES
('CIENCIA FICCION'),
( 'AVENTURA'),
('ROMANCE');

INSERT INTO DBO.Autor( nombre, apellidos)
VALUES
('Juan','Perez'),
( 'Edgar','Allan Poe'),
('Gabriel','Garcia Marquez');

INSERT INTO DBO.Idioma( nombre)
VALUES
('ESPANOL'),
( 'INGLES');


INSERT INTO DBO.Editoriales(nombre, direccion )
VALUES
('Laravel', '22-c'),
('MadHouse', '22-b');


INSERT INTO DBO.Libros(idAutor, idCategoria, idEditorial, idIdioma, titulo)
VALUES
(3,3,1,1, 'Cien Anos de Soledad'),
(1,1,2,2, 'Maze Runner'),
(2,1,1,1, 'Libro3'),
(1,3,2,1, 'Libro4'),
(2,2,1,1, 'Libro5'),
(3,1,2,1, 'Libro6');


-- CONSULTA DE LIBROS--

CREATE PROCEDURE ConsultarLibro
	@IdLibro int
AS
BEGIN	
	BEGIN TRY 

	SELECT idLibros, Autor.nombre, titulo, fechaLanzamiento, descripcion FROM dbo.Libros
			INNER JOIN Autor ON Libros.idAutor = Autor.idAutor
			WHERE idLibros = @IdLibro

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


EXECUTE ConsultarLibro  @IdLibro =1



