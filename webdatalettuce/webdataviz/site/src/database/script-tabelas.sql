DROP DATABASE lettuce;
CREATE DATABASE IF NOT EXISTS lettuce;
use lettuce;

create table if not exists Empresa (
-- idEmpresa int primary key auto_increment,
nomeEmpr varchar(45) not null,
cnpj char(14) primary key unique not null,
telefone char(11)
);

INSERT INTO Empresa VALUES
('JuicyLettuce', '12345678965478', '11913829401');


create table if not exists Funcionario(
idFuncionario int auto_increment,
nome varchar(30) not null,
sobrenome varchar(40) not null,
cpf char(11) unique,
cargo varchar(30) not null,
telefone char(11) not null,
email varchar(45) unique not null,  constraint ckhEmailfunc check(Email like '%@%'),
dtNasc date not null,
adm boolean,
senha varchar(100) not null,

fkEmpresa char(14), constraint frkEmpresa foreign key(fkEmpresa) 
references Empresa(cnpj),
constraint pkFuncEmp primary key (idFuncionario, fkEmpresa), -- fk dependente
fkChefe int, constraint FrkChefe foreign key (fkChefe)
references Funcionario(idFuncionario) -- fk self related

) auto_increment = 1000;

INSERT INTO Funcionario VALUES
(null, 'Marcos', 'Telúrio', '12345678900' ,'Gerente' ,'11913829401', 'marcos.telurio@gmail.com', '1980-04-12', true, sha2('XPTO123/', 256), '12345678965478', null );



create table if not exists Caminhao(
-- idCaminhao int primary key auto_increment,
placa char(7) primary key unique not null,
fkEmpresaVeiculo char(14), constraint fkEmpTrans foreign key(fkEmpresaVeiculo) references Empresa(cnpj) -- ex
);

insert into Caminhao values
('GDU2589', '12345678965478'),
('CBW6000', '12345678965478');

create table if not exists Carga(
idCarga int primary key auto_increment,
produto varchar(45),
qtdKg DECIMAL (7,2),
dtHr datetime
) auto_increment = 100;

INSERT INTO Carga VALUES
(null, 'alface', 10000, now()),
(null, 'rúcula', 5000, now());

create table if not exists Motorista(
idMotorista INT PRIMARY KEY auto_increment,
nome VARCHAR(45),
email VARCHAR(45),
telefone CHAR(11),
CNH CHAR(11)
);

INSERT INTO Motorista VALUES
(null, 'Eduardo', 'edu.@gmail.com', '11982810391', '00000000012'),
(null, 'Manuel', 'manuel@hotmail.com', '11928472847', '00000000013');

create table if not exists Viagem(
idViagem INT auto_increment,
fkCaminhao CHAR(7),
constraint fkCaminhaoViagem foreign key(fkCaminhao)
references Caminhao(placa),
fkCarga INT,
constraint fkCargaViagem foreign key (fkCarga)
references Carga(idCarga),
fkMotorista INT, 
constraint fkMotoristaViagem foreign key (fkMotorista)
references Motorista (idMotorista),
constraint pkCompostaViagem primary key (idViagem, fkCaminhao, fkCarga, fkMotorista),
cepOrigem CHAR (8), 
cepDestino CHAR (8)
);

INSERT INTO Viagem VALUES
(null, 'GDU2589', 100, 1, '58402650', '68746476'),
(null, 'CBW6000', 101, 2, '83918379', '92839102');

SELECT * FROM Viagem;


CREATE INDEX IDX_Viagem ON Viagem
(idViagem, fkCaminhao, fkCarga, fkMotorista);
SELECT * FROM Viagem;

create table if not exists Sensor(
idSensor int primary key not null auto_increment,
tipo varchar(5) not null, constraint chkSensor check(tipo IN("DHT11", "LM35")),
fkCaminhaoSensor char(7),
 constraint FkSensorCaminhao foreign key (fkCaminhaoSensor)
 references Caminhao(placa));
 
insert into sensor values
(null, 'DHT11', 'GDU2589'),
(null, 'DHT11', 'CBW6000');

DROP TABLE Leitura;
create table if not exists Leitura (
idLeitura int auto_increment,
temperatura decimal (4,2),
umidade decimal (5,2),
dtHora datetime default current_timestamp,
fkSensor INT, constraint fkSensor foreign key (fkSensor) 
references Sensor(idSensor),
 constraint pkCompostaLeitura primary key (idLeitura, fkSensor));
 
 INSERT INTO Leitura VALUES
(null, 2, 99.29, default, 1),
(null, 3, 99.50, default, 1),
(null, 0, 99.80, default, 1),
(null, -1, 99.90, default, 1), 
(null, 0, 98.73, default, 1),
(null, 1, 97.43, default, 1),
(null, 1.2, 97.23, default, 1),
(null, 1.5, 96.50, default, 1),
(null, 1.8, 96.23, default, 1),
(null, 2.0, 95.35, default, 1);

INSERT INTO Leitura VALUES
(null, 0, 95.42, default, 1),
(null, 1, 98.23, default, 1),
(null, 2, 95.24, default, 1),
(null, 3, 93.23, default, 1),
(null, 5, 82.23, default, 1),
(null, 6, 70.23, default, 1),
(null, 10, 0.23, default, 1);


CREATE VIEW VW_Caminhao_leitura AS
select 
Leitura.temperatura as 'Temperatura',
Leitura.umidade as 'Umidade',
Leitura.dtHora as 'Data e hora da leitura'
FROM Leitura 
JOIN Sensor
ON fkSensor = idSensor
JOIN Carga
JOIN Caminhao
ON fkCaminhaoSensor = placa 
ORDER BY temperatura desc limit 7;


 CREATE VIEW VW_KPI_Extremos AS
SELECT 
idLeitura,
temperatura,
umidade,
dtHora,
fkCaminhao,
fkSensor,
Viagem.fkCarga
FROM Leitura 
JOIN Sensor
ON fkSensor = idSensor
JOIN Carga
JOIN Caminhao
ON fkCaminhaoSensor = placa 
JOIN Empresa
ON fkEmpresaVeiculo = cnpj
JOIN Viagem
ON fkCarga = idCarga;


 CREATE VIEW VW_KPI_Atuais AS
SELECT 
idLeitura,
temperatura,
umidade,
dtHora,
fkCaminhao,
fkSensor,
Viagem.fkCarga
FROM Leitura 
JOIN Sensor
ON fkSensor = idSensor
JOIN Carga
JOIN Caminhao
ON fkCaminhaoSensor = placa 
JOIN Empresa
ON fkEmpresaVeiculo = cnpj
JOIN Viagem
ON fkCarga = idCarga;

create view VW_Grafico as select temperatura, umidade, date_format(dtHora,'%H:%i:%s %d/%m/%Y') as data_formatado, caminhao.placa, leitura.idLeitura from leitura join sensor on fkSensor = idSensor join caminhao on fkCaminhaoSensor = placa;


CREATE VIEW VW_Motorista AS
SELECT 
Motorista.nome,
Motorista.email,
Motorista.telefone,
Motorista.CNH 
FROM Motorista JOIN Viagem 
ON idMotorista = fkMotorista;


CREATE VIEW VW_Func AS
SELECT 
Funcionario.idFuncionario,
Funcionario.nome,
Funcionario.sobrenome,
Funcionario.email as 'E-mail',
Funcionario.telefone as 'Telefone',
Funcionario.Cargo as 'Cargo',
Funcionario.adm,
Funcionario.senha as 'Senha',
Chefe.nome as 'Chefe',
Funcionario.fkEmpresa
FROM Funcionario LEFT JOIN Funcionario AS Chefe
ON Funcionario.fkChefe = Chefe.idFuncionario
JOIN Empresa
ON cnpj = Funcionario.fkEmpresa;



CREATE VIEW VW_Carga AS 
SELECT 
Carga.produto as 'Produto',
Carga.qtdKg as 'Quantidade de quilos',
Carga.dtHr as 'Data da inserção da carga',
Viagem.cepOrigem as 'Endereço da Origem',
Viagem.cepDestino as 'Endereço do Destino'
FROM Carga
JOIN Viagem ON 
idCarga = Viagem.fkCarga;

SELECT * FROM Leitura ORDER BY idLeitura DESC;
TRUNCATE TABLE Leitura;

