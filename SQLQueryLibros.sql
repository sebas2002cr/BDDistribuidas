use Libros



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
	PRIMARY KEY (idAutor)



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

