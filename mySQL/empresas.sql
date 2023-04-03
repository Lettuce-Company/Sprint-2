create database lettuce;

use lettuce;

create table cadastroEmpresa (
idEmpresa int primary key auto_increment,
nome varchar(45),
hortalicas char(20), constraint chkHortalica check(hortalicas in('alface', 'rucula','alface e rucula')),
nomeReponsavel varchar (45),
cpnj char(18),
dtCadastro DATETIME default current_timestamp,
email varchar(20), constraint ckhEmail check(Email like '%@%'),
senha char(16),
telefone char(14));

create table empresaFuncionario(
idFuncionario int primary key auto_increment,
nome varchar(30),
sobrenome varchar(30),
cpf char(14) unique,
cargo varchar(30),
-- fkEmail 
-- fkSenha
fkEmpresa int, constraint fkEmpresa foreign key(fkEmpresa) references cadastroEmpresa(idEmpresa));
