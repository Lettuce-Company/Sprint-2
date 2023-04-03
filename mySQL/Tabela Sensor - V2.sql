create database lettuce;
use lettuce;
drop table Sensor;
create table Sensor(
idSensor int primary key not null,
tipoSensor varchar(5) not null, 
Setor char(1) not null,
Produto varchar(6) not null constraint chkProduto check(Produto IN("Alface", "Rúcula")),
Divisao char(1) not null,
frkCadastro INT,
constraint FkCa foreign key (frkCadastro)
references Cadastro(idCadastro)     
);


insert into Sensor values
(1, "LM35",3, "Alface", "A",1),
(2, "DHT11",3, "Alface", "A",1),
(3, "LM35",3, "Rúcula", "A",2),
(4, "DHT11",3, "Rúcula", "A",3),
(5, "LM35",3, "Alface", "B",2),
(6, "DHT11",3, "Alface", "B",3);

SELECT 
Sensor.*,
Cadastro.nome
FROM Sensor JOIN Cadastro
ON idCadastro = frkCadastro;

-- Divisão B do Sensor 5 parou de funcionar, enquanto não for consertado, ele ficará inativo
delete from Sensor
	where idSensor = 5;

-- O sensor 6 teve que ser mudado para Divisão C do Mercado
update Sensor set Divisão = "C"
	where idSensor = 6;
select*from Sensor;

