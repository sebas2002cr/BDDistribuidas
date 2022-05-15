CREATE TABLE AreaPuesto(
	idAreaPuesto int identity,
	nombre varchar(20),
	descripcion varchar(150)
	PRIMARY KEY (idAreaPuesto)
);


CREATE TABLE Contrato (
	idContrato int identity, 
	fecha date,
	salario money,
	horasTrabajo tinyint
	PRIMARY KEY (idContrato)

)

CREATE TABLE Sede(
	idSede int identity,
	nombre varchar(20)
	PRIMARY KEY (idSede)
);



CREATE TABLE Empleado (
	idEmpleado int identity,
	nombre	varchar(20),
	apellidos varchar(45),
	direccion varchar(120),
	telefono varchar(15),
	email varchar(30),
	foto image,
	idAreaPuesto int,
	idSede int,
	idContrato int
	PRIMARY KEY(idEmpleado),

	CONSTRAINT FK_EmpleadoIdAreaPuesto
	FOREIGN KEY (idAreaPuesto)
	REFERENCES AreaPuesto(idAreaPuesto),

	CONSTRAINT FK_EmpleadoIdSede
	FOREIGN KEY (idSede)
	REFERENCES Sede(idSede),


	CONSTRAINT FK_EmpleadoIdContrato
	FOREIGN KEY (idContrato)
	REFERENCES Contrato(idContrato),

);

