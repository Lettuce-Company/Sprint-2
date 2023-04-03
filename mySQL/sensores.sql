use lettuce;

create table Sensor(
idSensor int primary key not null,
tipoSensor varchar(5) not null, constraint chkSensor check(Produto IN("DHT11", "LM35")),
placaCarro char(7) not null,
-- placa do caminhão que fará o transporte do produto
Produto varchar(6) not null constraint chkProduto check(Produto IN('alface', 'rucula','alface e rucula')),
frkEmpresa INT, constraint FkEmp foreign key (frkEmpresa) references cadastroEmpresa(idEmpresa),
frkFuncionario INT, constraint FkFunc foreign key (frkFuncionario) references empresaFuncionario(idFuncionario));

create table dadosSesores (
idDados int primary key auto_increment,
temperatura decimal (4,2),
umidade decimal (4,2),
dtHora datetime default current_timestamp,
frkSensor INT, constraint frkSe foreign key (frkSensor) references Sensor(idSensor));