create database securitygas3;
use securitygas3;
create table restaurante(
idRestaurante int primary key auto_increment,
nome_restaurante varchar(45) not null,
codigo_ativacao char(6)
);

select * from restaurante;

insert into restaurante (nome_restaurante, codigo_ativacao) values 
('MC', 'ABC123');

create table usuario(
idUsuario int primary key auto_increment,
nome varchar(45)not null,
email varchar(50)not null,
senha varchar(45)not null,
fkRestaurante int,
foreign key (fkRestaurante) references restaurante(idRestaurante)
);

select * from usuario;

create table endereco(
idEndereco int auto_increment,
cep char(9) not null,
cidade varchar(45) not null,
estado varchar(45) not null,
logradouro varchar(45) not null,
numero varchar(10) not null,
fkRestaurante int,
constraint pkCompostaEndereco primary key (idEndereco,fkRestaurante),
foreign key (fkRestaurante) references restaurante(idRestaurante)
);

create table local_instalacao(
idLocal_instalacao int primary key auto_increment,
nome_local varchar(45) not null,
fkRestaurante int,
foreign key (fkRestaurante) references restaurante(idRestaurante)
);

create table sensor(
idSensor int primary key auto_increment,
nome_sensor varchar(45) not null,
statusAtivacao boolean not null,
fkLocal_instalacao int,
foreign key (fkLocal_instalacao) references local_instalacao(idLocal_instalacao)
);

create table alerta(
idAlerta int primary key auto_increment,
nivel_alerta VARCHAR(45) not null,
mensagem varchar(45) 
);

create table leitura_sensor(
fkAlerta int,
fkSensor int,
porcentagem_captada int not null,
data_hora datetime not null,
foreign key (fkAlerta) references alerta(idAlerta),
foreign key (fkSensor) references sensor(idSensor)
);

-- Para cada ambiente, pegar a última leitura registrada.

-- Mostrar o nível de gás dessa leitura.

-- Mostrar o status atual do sensor daquele ambiente.

-- Mostrar o nome do ambiente.

CREATE VIEW vw_painelgeral AS
SELECT
    r.nome_restaurante AS Restaurante,
    u.nome AS Nome_Usuario,
    l.nome_local AS Nome_Local,
    s.nome_sensor AS Nome_Sensor,
    s.statusAtivacao AS Status_Sensor,
    ls.data_hora AS Data_Hora,
    ls.porcentagem_captada AS Porcentagem_Gas,
    a.nivel_alerta AS Nivel_Alerta
FROM restaurante r
JOIN usuario u ON u.fkRestaurante = r.idRestaurante
JOIN local_instalacao l ON l.fkRestaurante = r.idRestaurante
JOIN sensor s ON s.fkLocal_instalacao = l.idLocal_instalacao
JOIN leitura_sensor ls ON ls.fkSensor = s.idSensor
LEFT JOIN alerta a ON a.idAlerta = ls.fkAlerta
WHERE ls.data_hora = (
    SELECT MAX(ls2.data_hora)
    FROM leitura_sensor ls2
    WHERE ls2.fkSensor = s.idSensor
);

select * from vw_painelgeral;