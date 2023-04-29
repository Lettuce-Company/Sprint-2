create database lettuce;
use lettuce;

create table Empresa (
-- idEmpresa int primary key auto_increment,
nome varchar(45) not null,
cnpj char(14) primary key unique not null,
telefone char(14)) auto_increment = 100;


create table Funcionario(
idFuncionario int primary key auto_increment,
nome varchar(30) not null,
sobrenome varchar(40) not null,
adm boolean,
cpf char(11) unique,
cargo varchar(30) not null,
email varchar(45) unique not null,  constraint ckhEmailfunc check(Email like '%@%'),
senha char(14) not null,
-- dtNasc date not null,
fkEmpresa char(14), constraint frkEmpresa foreign key(fkEmpresa) 
references Empresa(cnpj),
constraint pkFuncEmp primary key (idFuncionario, fkEmpresa), -- fk dependente

fkChefe char(11), constraint FrkChefe foreign key (fkChefe)
references Funcionario(idFuncionario) -- fk self related

) auto_increment = 1000;

select * from Funcionario;
select * from empresa;

create table Caminhao(
-- idCaminhao int primary key auto_increment,
placa char(7) primary key unique not null,
fkEmpresa char(14), constraint fkEmpTrans foreign key(fkEmpresa) references Empresa(cnpj) -- ex
) auto_increment = 10;
insert into Caminhao values
('GDU2589', '12345678965478');

select * from caminhao;

create table Carga(
idCarga int auto_increment,
produto varchar(45),
dt date,
fkCaminhao char(7), 
constraint fkCaminhao foreign key(fkCaminhao) 
references Caminhao(placa),
constraint pkCargaCam primary key (idCarga, fkCaminhao) -- fk dependente de caminhao
);

create table viagem( 
idViagem int auto_increment,
fkCarga int,
 constraint fkCarga foreign key (fkCarga) 
references Carga(idCarga),
 constraint pkCargViagem primary key (idViagem, fkCarga, fkCaminhao),
fkCaminhao int,  constraint fkCaminhao foreign key (fkCaminhao) 
references Caminhao(placa),
origem varchar(45),
destino varchar(45),
duracao varchar(45) );

create table Sensor(
idSensor int primary key not null auto_increment,
tipo varchar(5) not null, constraint chkSensor check(tipo IN("DHT11", "LM35")),
fkCaminhao char(7),
 constraint FkSensorCaminhao foreign key (fkCaminhao)
 references Caminhao(placa));
insert into sensor values
(null, 'DHT11', 'GDU2589'),
(null, 'LM35', 'GDU2589');

create table Leitura (
idLeitura int auto_increment,
temperatura decimal (4,2),
umidade decimal (4,2),
dtHora datetime default current_timestamp,
fkSensor INT, constraint fkSensor foreign key (fkSensor) 
references Sensor(idSensor),
 constraint pksenlei primary key (idLeitura, fkSensor));
select * from leitura;
select max(umidade) as 'umidade mais alta' from leitura; -- select temperatura mais alta
select min(umidade) as 'umidade mais baixa' from leitura; -- select temperatura mais baixa 
select max(temperatura) as 'temp mais alta', min(temperatura) as 'temp mais baixa' from leitura;
select round (avg(temperatura), 2) as `media de temperatura` from leitura; -- select média (avg) arendando (round) com 2 casas após a virgula round(dado, casas apos vitgula)
SELECT * FROM leitura WHERE temperatura > (SELECT AVG(temperatura) FROM leitura); -- select onde a temperatura está acima da média
select upper(empresa.nomeEmpr) from empresa; -- selecionar tudo em maiusculo
select UCASE(empresa.nomeEmpr) from empresa; -- selecionar tudo em maiusculo, n sei a diferença entre eles
select lower(empresa.nomeEmpr) from empresa; -- selecionar tudo em minusculo
select leitura.temperatura, leitura.dtHora, sensor.tipo from leitura join sensor on fkSensor = idSensor where tipo = 'LM35';
select leitura.umidade, leitura.dtHora, sensor.tipo from leitura join sensor on fkSensor = idSensor where tipo = 'DHT11';
 select leitura.temperatura, leitura.umidade, leitura.dtHora as 'dia e hora da leitura', caminhao.placa as 'veiculo'
	from leitura join sensor on fkSensor = idSensor
    join caminhao on fkCaminhao = placa;
 
 select * from Funcionario;
 
 select * from empresa join funcionario on fkEmpresa = cnpj; -- select empresa e funcionario
 
 desc empresa;
 
 select * from caminhao join sensor on fkcaminhao = idsensor
 join leitura on fksensor and idLeitura = idsensor; -- select caminhao sensor e leitura	
 

select concat(nome, ' ',sobrenome)as nome_completo from funcionario; -- concat do nome completo