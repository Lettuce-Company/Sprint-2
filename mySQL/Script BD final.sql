create database lettuce;

use lettuce;

create table Empresa (
idEmpresa int primary key auto_increment,
nome varchar(45) not null,
cnpj char(18) unique not null,
telefone char(14)) auto_increment = 100;


create table Funcionario(
idFuncionario int auto_increment,
nome varchar(30) not null,
sobrenome varchar(40) not null,
cpf char(14) unique,
cargo varchar(30) not null,
email varchar(45) unique not null,  constraint ckhEmailfunc check(Email like '%@%'),
senha char(14) not null,
dtNasc date not null,

fkEmpresa int, constraint fkEmpresa foreign key(fkEmpresa) 
references Empresa(idEmpresa),
constraint pkFuncEmp primary key (idFuncionario, fkEmpresa), -- fk dependente

fkChefe int, constraint FkChefe foreign key (fkChefe)
references Funcionario(idFuncionario) -- fk self related

) auto_increment = 1000;

select * from Funcionario;

create table Caminhao(
idCaminhao int primary key auto_increment,
placa char(7) unique not null,
fkEmpresa int, constraint fkEmpTrans foreign key(fkEmpresa) references Empresa(idEmpresa) -- ex
) auto_increment = 10;

create table Carga(
idCarga int auto_increment,
tipo varchar(45),
temperaturaMin decimal(4,2),
temperaturaMax decimal(4,2),
UmidadeMin varchar (5),
UmidadeMax varchar (5),
fkCaminhao int, 
constraint fkCaminhao foreign key(fkCaminhao) 
references Caminhao(idCaminhao),
constraint pkCargaCam primary key (idCarga, fkCaminhao) -- fk dependente de caminhao
);

create table Sensor(
idSensor int primary key not null auto_increment,
tipo varchar(5) not null, constraint chkSensor check(tipo IN("DHT11", "LM35")),
fkCaminhao INT,
 constraint FkSensorCaminhao foreign key (fkCaminhao)
 references Caminhao(idCaminhao));

create table Leitura (
idLeitura int auto_increment,
temperatura decimal (4,2),
umidade decimal (4,2),
dtHora datetime default current_timestamp,
fkSensor INT, constraint fkSensor foreign key (fkSensor) 
references Sensor(idSensor),
 constraint pksenlei primary key (idLeitura, fkSensor));

 
 
