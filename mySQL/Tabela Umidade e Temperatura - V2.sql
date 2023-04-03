create database lettuce;
use lettuce;
create table umidade_temperatura (
idUmidade_temperatura int primary key auto_increment,
temperatura decimal (4,2),
umidade decimal (4,2),
dtHora datetime default current_timestamp,
frkSensor INT,
constraint frkSe foreign key (frkSensor)
references Sensor(idSensor)
);

Insert into umidade_temperatura(idUmidade_temperatura, temperatura, umidade, frkSensor) values 
(1, 25.4, 20, 4);

Select * From umidade_temperatura;

insert into umidade_temperatura(idUmidade_temperatura, temperatura, umidade, frkSensor) values
(2, 24.1, 22, 2),
(3, 26.3, null, 1),
(4, 23.6, null, 1),
(5, 25.2, 30.00, 2),
(6, 27.4, null, 3),
(7, 29.0, 22.23, 4),
(8, 32.0, 20.12, 4),
(9, 25.2, null, 5);

SELECT 
Umidade_temperatura.*,
Sensor.idSensor,
Sensor.tipoSensor
FROM Umidade_temperatura JOIN Sensor
ON idSensor = frkSensor;

-- Kennedy queria remover um de seus sensores,
-- devido a uma mudança em seu lote e pediu para remover os dados de seu sensor.
DELETE FROM Umidade_temperatura
 WHERE idUmidade_temperatura in(1,7,8);