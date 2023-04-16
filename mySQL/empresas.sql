create database lettuce;

use lettuce;

create table Empresa (
idEmpresa int primary key auto_increment,
nome varchar(45) not null,
Segmento char(20) not null, -- constraint chkHortalica check(hortalicas in('alface', 'rucula','alface e rucula')),
nomeResponsavel varchar (45),
cnpj char(18) unique not null,
dtCadastro DATETIME default current_timestamp,
email varchar(45) unique not null,  constraint ckhEmail check(Email like '%@%'),
senha char(16) not null,
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
constraint pkFuncEmp primary key (idFuncionario, fkEmpresa)) auto_increment = 1000;


create table transporte(
idTransporte int primary key auto_increment,
placa char(7) unique not null,
temperaturaMax decimal(4,2),
temperaturaMin decimal(4,2),
umidadeIdeal int,
fkEmpresa int, constraint fkEmpTrans foreign key(fkEmpresa) references Empresa(idEmpresa)
) auto_increment = 10;


create table Sensor(
idSensor int primary key not null auto_increment,
tipo varchar(5) not null, constraint chkSensor check(tipo IN("DHT11", "LM35")),
fkTransporte INT, constraint FkTransporte foreign key (fkTransporte) references Transporte(idTransporte));

create table Leitura (
idLeitura int auto_increment,
temperatura decimal (4,2),
umidade decimal (4,2),
dtHora datetime default current_timestamp,
fkSensor INT, constraint fkSenLei foreign key (fkSensor) 
references Sensor(idSensor),
 constraint pksenlei primary key (idLeitura, fkSensor));
