use lettuce;

create table Sensor(
idSensor int primary key not null,
tipo varchar(5) not null, constraint chkSensor check(tipo IN("DHT11", "LM35")),
fkEmpresa INT, constraint FkEmpSen foreign key (fkEmpresa) references Empresa(idEmpresa));

create table Leitura (
idLeitura int primary key auto_increment,
temperatura decimal (4,2),
umidade decimal (4,2),
dtHora datetime default current_timestamp,
fkSensor INT, constraint fkSenLei foreign key (fkSensor) references Sensor(idSensor));
