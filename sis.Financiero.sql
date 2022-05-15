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

    CONSTRAINT FK_PagoIdTipoPago
    FOREIGN KEY (idTipoPago)
    REFERENCES tipoPago(idTipoPago),
);

-- datos 

insert into tipoPago(tipo, precio)
values ('Morosidad', 10000),
       ('Creditos Universitarios', 20000),
       ('Cargos adminitrativos', 5000)


insert into pago(idUsuario, idTipoPago, precio, descripcion, pendiente)
values (1, 1, 10000, 'Pagos acumulados', 1),
       (2, 2, 20000, 'Pagos acumulados', 0),
       (3, 2, 10000, 'Pagos acumulados', 0),
       (3, 3, 30000, 'Pagos acumulados', 1),
       (4, 1, 10000, 'Pagos acumulados', 0),
       (4, 1, 10000, 'Pagos acumulados', 0)



--PROCEDIMEINTO
CREATE PROCEDURE [dbo].[ValidarDeudas]
	@IdUsuario INT
	
AS
BEGIN
    BEGIN TRY   -- statements that may cause exceptions

    IF EXISTS (SELECT idUsuario FROM pago WHERE idUsuario = @IdUsuario)
        BEGIN
            SELECT COUNT(pendiente) as pendiente
            FROM pago 
            WHERE idUsuario = @IdUsuario AND pendiente = 1
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

EXEC ValidarDeudas @IdUsuario = 1