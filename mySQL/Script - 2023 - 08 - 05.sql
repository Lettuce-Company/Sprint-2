DROP DATABASE lettuce;
CREATE DATABASE IF NOT EXISTS lettuce;
use lettuce;

create table if not exists Empresa (
-- idEmpresa int primary key auto_increment,
nomeEmpr varchar(45) not null,
cnpj char(14) primary key unique not null,
telefone char(14)
);

insert into Empresa values
('JuicyLettuce', '12345678965478', '11939249423');

select * from Empresa;

create table if not exists Funcionario(
idFuncionario int auto_increment,
nome varchar(30) not null,
sobrenome varchar(40) not null,
cpf char(11) unique,
cargo varchar(30) not null,
telefone char(11) not null,
email varchar(45) unique not null,  constraint ckhEmailfunc check(Email like '%@%'),
dtNasc date not null,
permissao boolean,
status boolean,
senha varchar(100) not null,

fkEmpresa char(14), constraint frkEmpresa foreign key(fkEmpresa) 
references Empresa(cnpj),
constraint pkFuncEmp primary key (idFuncionario, fkEmpresa), -- fk dependente
fkChefe int, constraint FrkChefe foreign key (fkChefe)
references Funcionario(idFuncionario) -- fk self related

) auto_increment = 1000;

INSERT INTO Funcionario VALUES
(NULL, 'Marcos', 'Telúrio', '12345678900', 'Gerente', '11913829401', 'marcos.telurio@gmail.com', '1980-02-15', true, true, sha2('yub56m8123459', 256), '12345678965478', null),
(NULL, 'Antônio', 'Figueredes', '29345678900', 'Funcionário', '11938291931', 'antonio@gmail.com', '1994-12-07', false, true, sha2('abcacsf28183', 256), '12345678965478', 1000);

select * from Funcionario;


create table if not exists Caminhao(
-- idCaminhao int primary key auto_increment,
placa char(7) primary key unique not null,
fkEmpresa char(14), constraint fkEmpTrans foreign key(fkEmpresa) references Empresa(cnpj) -- ex
);

insert into Caminhao values
('GDU2589', '12345678965478'),
('CTU1350', '12345678965478');

select * from Caminhao;


create table if not exists Carga(
idCarga int auto_increment,
produto varchar(45),
dthora datetime,
fkCaminhaoPlaca char(7), 
constraint fkCaminhao foreign key(fkCaminhaoPlaca) 
references Caminhao(placa),
constraint pkCargaCam primary key (idCarga, fkCaminhaoPlaca) -- fk dependente de caminhao
);

INSERT INTO Carga VALUES
(null, 'Alface Crespa', '2023-04-21 14:00:21', 'GDU2589'),
(null, 'Rúcula', '2023-04-13 16:18:55', 'CTU1350');

SELECT * FROM Carga;

create table if not exists Motorista(
idMotorista INT PRIMARY KEY auto_increment,
nome VARCHAR(45),
telefone CHAR(11),
CNPJ CHAR(14), constraint chkCNPJ check(CNPJ like '%0001%' OR CNPJ like '%0002%')
);

INSERT INTO Motorista VALUES
(null, 'Henrique', '11948294812', '23456789000112'),
(null, 'Victor', '11956278430', '83718495000242');

SELECT * FROM Motorista;

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
origem VARCHAR (45), -- Colocar CEP?
destino VARCHAR(45),
duracao INT
);

create table if not exists Sensor(
idSensor int primary key not null auto_increment,
tipo varchar(5) not null, constraint chkSensor check(tipo IN("DHT11", "LM35")),
fkCaminhao char(7),
 constraint FkSensorCaminhao foreign key (fkCaminhao)
 references Caminhao(placa));
 
insert into sensor values
(null, 'DHT11', 'GDU2589'),
(null, 'LM35', 'CTU1350');

SELECT * FROM sensor;

create table if not exists Leitura (
idLeitura int auto_increment,
temperatura decimal (4,2),
umidade decimal (4,2),
dtHora datetime default current_timestamp,
fkSensor INT, constraint fkSensor foreign key (fkSensor) 
references Sensor(idSensor),
fkCargaLeitura INT,
constraint fkCargaLeitura foreign key (fkCargaLeitura) 
references Carga(idCarga),
 constraint pkCompostaLeitura primary key (idLeitura, fkSensor, fkCargaLeitura));
 
 INSERT INTO Leitura VALUES
(null, 25.34, 98.23, default, 1, 1),
(null, 25.34, 98.23, default, 2, 2);

SELECT * FROM Leitura;

CREATE VIEW VW_Caminhao_leitura AS
select 
Caminhao.placa as 'Caminhão',
Carga.produto as 'Produto da Carga',
Leitura.temperatura as 'Temperatura',
Leitura.umidade as 'Umidade',
Leitura.dtHora as 'Data e hora da leitura'
FROM Leitura JOIN Sensor
ON fkSensor = idSensor
JOIN Caminhao
ON fkCaminhao = placa 
JOIN Carga
ON idCarga = fkCargaLeitura; 

-- View das Leituras dos Caminhões
SELECT * FROM VW_Caminhao_Leitura;

CREATE VIEW VW_Func AS
SELECT 
CONCAT(funcionario.nome, ' ', funcionario.sobrenome) AS 'Funcionário',
Funcionario.email as 'E-mail',
Funcionario.telefone as 'Telefone',
Funcionario.Cargo as 'Cargo',
Funcionario.permissao as 'Permissão do funcionário',
Funcionario.senha as 'Senha',
Chefe.nome as 'Chefe'
FROM Funcionario JOIN Funcionario AS Chefe
ON Funcionario.fkChefe = Chefe.idFuncionario
JOIN Empresa
ON cnpj = Funcionario.fkEmpresa;

-- View dos Dados dos Funcionários
SELECT * FROM VW_Func;

-- Procedimento, semelhante a uma função, Realiza as ações contidas nela.
DELIMITER $$
CREATE PROCEDURE Select_All()
BEGIN
SELECT * FROM Empresa;
SELECT * FROM Funcionario;
SELECT * FROM Caminhao;
SELECT * FROM Carga;
SELECT * FROM Motorista;
SELECT * FROM Viagem;
SELECT * FROM Sensor;
SELECT * FROM Leitura;
SELECT * FROM VW_Caminhao_Leitura;
SELECT * FROM VW_Func;
END$$
DELIMITER ;

-- Se quiser dar um select em tudo até agora, use a PROCEDURE abaixo:
-- CALL Select_All()

-- Operações matemáticas
-- Aviso!! As operações matemáticas foram comentadas para manter o SELECT'S simplistas, facilitando a visua-
-- lização dos dados presentes nas tabelas a partir do botão execute visto como um raio no topo da tela. 

-- select max(umidade) as 'umidade mais alta' from leitura; -- select temperatura mais alta 

-- select min(umidade) as 'umidade mais baixa' from leitura; -- select temperatura mais baixa 

-- select max(temperatura) as 'temp mais alta', min(temperatura) as 'temp mais baixa' from leitura;

-- select round (avg(temperatura), 2) as `media de temperatura` from leitura; -- select média (avg) arendando (round) com 2 casas após a virgula round(dado, casas apos vírgula)


-- SELECT * FROM leitura WHERE temperatura > (SELECT AVG(temperatura) FROM leitura); -- select onde a temperatura está acima da média

-- select upper(empresa.nomeEmpr) from empresa; -- selecionar tudo em maiusculo

-- select UCASE(empresa.nomeEmpr) from empresa; -- selecionar tudo em maiusculo, n sei a diferença entre eles

-- select lower(empresa.nomeEmpr) from empresa; -- selecionar tudo em minusculo

-- select leitura.temperatura, leitura.dtHora, sensor.tipo from leitura join sensor on fkSensor = idSensor where tipo = 'LM35';


 
