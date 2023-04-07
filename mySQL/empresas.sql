create database lettuce;

use lettuce;

create table Empresa (
idEmpresa int primary key auto_increment,
nome varchar(45) not null,
Segmento char(20) not null, -- constraint chkHortalica check(hortalicas in('alface', 'rucula','alface e rucula')),
nomeReponsavel varchar (45),
cpnj char(18) unique not null,
dtCadastro DATETIME default current_timestamp,
email varchar(20) not null,  constraint ckhEmail check(Email like '%@%'),
senha char(16) not null,
telefone char(14)) auto_increment = 99;

create table Funcionario(
idFuncionario int primary key auto_increment,
nome varchar(30) not null,
sobrenome varchar(30) not null,
cpf char(14) unique,
cargo varchar(30) not null,
email varchar(30) not null,
senha char(14) not null,
dtNasc date not null,
fkEmpresa int, constraint fkEmpresa foreign key(fkEmpresa) references Empresa(idEmpresa)) auto_increment = 1001;

create table transporte(
idTransporte int primary key auto_increment,
placa char(7) unique not null,
temperaturaMax decimal(4,2),
temperaturaMin decimal(4,2),
umidadeIdeal int,
fkEmpresa int, constraint fkEmpTrans foreign key(fkEmpresa) references Empresa(idEmpresa),
fkSensor int, constraint fkSenTrans foreign key(fkSensor) references Sensor(idSensor)
) auto_increment = 10;
