CREATE DATABASE lettuce;
USE lettuce;
DROP TABLE Cadastro;
CREATE TABLE cadastro(
idCadastro INT PRIMARY KEY not null auto_increment,
mercado VARCHAR (20) not null,
hortalica VARCHAR(15) not null constraint chkHortalica check (hortalica in('alface','rucula','alface e rucula')),
cargo CHAR(7) not null constraint chkCargo check(cargo in('gerente')),
nome VARCHAR(45) not null,
email VARCHAR(45) not null,
telefone CHAR(12)  not null,
dtCadastro DATETIME default current_timestamp
);
DESC cadastro;
SELECT * FROM cadastro;

INSERT INTO cadastro(idCadastro, mercado, hortalica, cargo, nome, email, telefone) VALUES
(null, 'Kennedy','alface','gerente','Augusto','kennedy@gmail.com','1198275412');
INSERT INTO cadastro(idCadastro, mercado, hortalica, cargo, nome, email, telefone)  VALUES
(null,'Vila da Folha','rucula','gerente','Jose','vidadafolha@gmail.com','1198766542'),
(null,'Mercado do Doc','alface e rucula','gerente','Doc','docmercado@gmail.com','1196444946'),
(null,'Cool plant','alface e rucula','gerente','Carla','coolplant@gmail.com','1196444946'),
(null,'Arvore da vida','alface','gerente','Marcos','arvoredavida@gmail.com','1194915665'),
(null,'O hortifruti','alface e rucula','gerente','Gerivaldo','ohortifruti@gmail.com','1194915665'),
(null,'bertonili','rucula','gerente','alberto','bertonili@gmail.com','1192675926');

SELECT * FROM cadastro;

-- A Gerente carla teve uma promoção e entrou como supervisora, tendo seu irmão gêmeo,
-- Carlos substituindo seu lugar como gerente, logo, atualizamos o nome da gerente da Cool Plant.
UPDATE cadastro SET nome = 'Carlos'
       WHERE idCadastro = 4;
       
SELECT * FROM cadastro;

-- A Vila da folha infelizmente cancelou nossos serviços, 
-- Então limpamos a tupla de seu cadastro.
DELETE FROM cadastro 
       WHERE idCadastro = 2;

