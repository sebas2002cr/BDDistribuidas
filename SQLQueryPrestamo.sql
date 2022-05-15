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
	fechaPrestamo date,
	fechaDevolucion date,
	devuelto bit
	PRIMARY KEY (idPrestamo),
	

	CONSTRAINT FK_PrestamoIdUsuario
	FOREIGN KEY (idUsuario)
	REFERENCES Usuario(idUsuario),
);


