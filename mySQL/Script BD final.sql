create database lettuce;

use lettuce;

create table Empresa (
-- idEmpresa int primary key auto_increment,
nome varchar(45) not null,
cnpj char(14) primary key unique not null,
telefone char(14)) auto_increment = 100;


create table Funcionario(
-- idFuncionario int auto_increment,
nome varchar(30) not null,
sobrenome varchar(40) not null,
cpf char(11) unique,
cargo varchar(30) not null,
email varchar(45) unique not null,  constraint ckhEmailfunc check(Email like '%@%'),
senha char(14) not null,
-- dtNasc date not null,
fkEmpresa char(14), constraint frkEmpresa foreign key(fkEmpresa) 
references Empresa(cnpj),
constraint pkFuncEmp primary key (cpf, fkEmpresa), -- fk dependente
fkChefe char(11), constraint FrkChefe foreign key (fkChefe)
references Funcionario(cpf) -- fk self related

) auto_increment = 1000;

select * from Funcionario;

create table Caminhao(
-- idCaminhao int primary key auto_increment,
placa char(7) primary key unique not null,
fkEmpresa char(14), constraint fkEmpTrans foreign key(fkEmpresa) references Empresa(cnpj) -- ex
) auto_increment = 10;

create table Carga(
idCarga int auto_increment,
produto varchar(45),
temperaturaMin decimal(4,2),
temperaturaMax decimal(4,2),
UmidadeMin varchar (5),
UmidadeMax varchar (5),
fkCaminhao char(7), 
constraint fkCaminhao foreign key(fkCaminhao) 
references Caminhao(placa),
constraint pkCargaCam primary key (idCarga, fkCaminhao) -- fk dependente de caminhao
);

create table Sensor(
idSensor int primary key not null auto_increment,
tipo varchar(5) not null, constraint chkSensor check(tipo IN("DHT11", "LM35")),
fkCaminhao char(7),
 constraint FkSensorCaminhao foreign key (fkCaminhao)
 references Caminhao(placa));

create table Leitura (
idLeitura int auto_increment,
temperatura decimal (4,2),
umidade decimal (4,2),
dtHora datetime default current_timestamp,
fkSensor INT, constraint fkSensor foreign key (fkSensor) 
references Sensor(idSensor),
 constraint pksenlei primary key (idLeitura, fkSensor));

 
 select * from empresa join funcionario on fkempresa and cpf  = cnpj; -- select empresa e funcionario
 
 select * from caminhao join sensor on fkcaminhao = idsensor
 join leitura on fksensor and idLeitura = idsensor; -- select caminhao sensor e leitura	
 

select concat(nome,sobrenome)as nome_completo from funcionario; -- concat do nome completo
