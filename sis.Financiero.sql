CREATE TABLE tipoPago (
    idTipoPago int identity,
    tipo varchar(55),
    precio money
    PRIMARY KEY (idTipoPago)
);

CREATE TABLE pago (
    idPago int identity,
    idUsuario int,
    idTipoPago int,
    precio money,
    descripcion varchar(max),
    pendiente bit
    PRIMARY KEY (idPago),

    CONSTRAINT FK_MateriaIdTurno
    FOREIGN KEY (idTurno)
    REFERENCES jornada(idTurno),
);