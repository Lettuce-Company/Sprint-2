create database lettuce;

drop database lettuce;

use lettuce;

create table Empresa (
idEmpresa int primary key auto_increment,
nome varchar(45) not null,
Segmento char(20) not null, -- constraint chkHortalica check(hortalicas in('alface', 'rucula','alface e rucula')),
nomeResponsavel varchar (45),
cnpj char(18) unique not null,
dtCadastro DATETIME default current_timestamp,
email varchar(20) not null,  constraint ckhEmail check(email like '%@%'),
senha char(16) not null,
telefone char(14)) auto_increment = 99;

alter table Empresa modify column email varchar(45);



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

create table Sensor(
idSensor int primary key not null auto_increment,
tipo varchar(5) not null, constraint chkSensor check(tipo IN("DHT11", "LM35")),
fkEmpresa INT, constraint FkEmpSen foreign key (fkEmpresa) references Empresa(idEmpresa));

create table Leitura (
idLeitura int primary key auto_increment,
temperatura decimal (4,2),
umidade decimal (4,2),
dtHora datetime default current_timestamp,
fkSensor INT, constraint fkSenLei foreign key (fkSensor) references Sensor(idSensor));



create table transporte(
idTransporte int primary key auto_increment,
placa char(7) unique not null,
temperaturaMax decimal(4,2),
temperaturaMin decimal(4,2),
umidadeIdeal int,
fkEmpresa int, constraint fkEmpTrans foreign key(fkEmpresa) references Empresa(idEmpresa),
fkSensor int, constraint fkSenTrans foreign key(fkSensor) references Sensor(idSensor)
) auto_increment = 10;

 insert into Empresa (nome,Segmento, nomeResponsavel, cnpj, email, senha, telefone) values
 ('alfacinha','repolho','bananinha','123456789019812','bananinha@hotmail.com','bananinha123','12311231');
 
 delete from Empresa where idEmpresa = 99; 
 
 select * from Empresa;
 
 describe funcionario;
 
 insert into Funcionario (nome,sobrenome,cpf,cargo,email,senha,dtNasc,fkEmpresa) values
 ('Rogério','rodrigues','34748587492','supervisor','rogeriogameplays@gmail.com','bananinha123','2002-05-01','99');
 
 select * from funcionario;
 
desc sensor;

insert into sensor (tipo,fkEmpresa) values
('DHT11','99');

desc leitura;

select * from sensor;

insert into leitura (temperatura, umidade, fkSensor) values 
('0.1','81.6','1'),
('0.1','88.4','1'),
('0.2','83.2','1'),
('0.5','83.2','1');