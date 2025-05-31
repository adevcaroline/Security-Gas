
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
idLeitura int auto_increment,
fkAlerta int,
fkSensor int,
porcentagem_captada DECIMAL(5,2) not null,
data_hora datetime not null,
foreign key (fkAlerta) references alerta(idAlerta),
foreign key (fkSensor) references sensor(idSensor),
primary key (idLeitura, fkAlerta, fkSensor)
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

select * from leitura_sensor
join sensor
on fkSensor = idSensor
where fkSensor = 1
order by idLeitura desc;

select * from vw_painelgeral;

-- Inserções na tabela restaurante
INSERT INTO restaurante (nome_restaurante, codigo_ativacao) VALUES 
('BK', 'XYZ789'),
('Giraffas', 'GIR456'),
('Habibs', 'HAB123');

-- Inserções na tabela usuario
INSERT INTO usuario (nome, email, senha, fkRestaurante) VALUES
('Carlos Silva', 'carlos@mc.com', 'mc@123', 1),
('Fernanda Souza', 'fernanda@bk.com', 'bk@456', 2),
('Roberto Almeida', 'roberto@giraffas.com', 'gir789', 3),
('Amanda Lima', 'amanda@habibs.com', 'hab123', 4);

-- Inserções na tabela endereco
INSERT INTO endereco (cep, cidade, estado, logradouro, numero, fkRestaurante) VALUES
('01001-000', 'São Paulo', 'SP', 'Rua Augusta', '1500', 1),
('20040-020', 'Rio de Janeiro', 'RJ', 'Av. Rio Branco', '100', 2),
('30130-010', 'Belo Horizonte', 'MG', 'Av. Afonso Pena', '2000', 3),
('05001-000', 'São Paulo', 'SP', 'Rua Francisco Cruz', '234', 4);

-- Inserções na tabela local_instalacao
INSERT INTO local_instalacao (nome_local, fkRestaurante) VALUES
('Cozinha Principal', 1),
('Área de Estoque', 1),
('Cozinha', 2),
('Depósito', 3),
('Sala do Gás', 4);

-- Inserções na tabela sensor
INSERT INTO sensor (nome_sensor, statusAtivacao, fkLocal_instalacao) VALUES
('Sensor Cozinha A', 1, 1),
('Sensor Estoque 1', 1, 2),
('Sensor Forno Principal', 1, 3),
('Sensor Depósito Frontal', 0, 4),
('Sala Gás 01', 1, 5);

select * from sensor;

-- Inserções na tabela alerta
INSERT INTO alerta (nivel_alerta, mensagem) VALUES
('Normal', 'Níveis dentro do esperado'),
('Alerta', 'Níveis acima da média'),
('Crítico', 'EVACUAR ÁREA IMEDIATAMENTE');


truncate table leitura_sensor;
-- Inserções na tabela leitura_sensor
INSERT INTO leitura_sensor (fkAlerta, fkSensor, porcentagem_captada, data_hora) VALUES
(1, 1, 1.12, '2023-11-15 10:00:00'),
(1, 1, 1.15, '2023-11-15 10:05:00'),
(1, 1, 0.18, '2023-11-15 10:10:00'),
(1, 1, 1.22, '2023-11-15 10:15:00'),
(2, 1, 1.55, '2023-11-15 10:20:00'),
(1, 1, 0.30, '2023-11-15 10:25:00'),
(1, 1, 0.25, '2023-11-15 10:30:00'),
(1, 1, 1.19, '2023-11-15 10:35:00'),
(1, 1, 0.21, '2023-11-15 10:40:00'),
(1, 1, 1.28, '2023-11-15 10:45:00'),
(2, 1, 0.65, '2023-11-15 10:50:00'),
(3, 1, 1.85, '2023-11-15 10:55:00'),
(3, 1, 1.95, '2023-11-15 11:00:00'),
(2, 1, 0.75, '2023-11-15 11:05:00'),
(1, 1, 0.35, '2023-11-15 11:10:00'),
(1, 1, 1.28, '2023-11-15 11:15:00'),
(1, 1, 0.22, '2023-11-15 11:20:00'),
(1, 1, 1.18, '2023-11-15 11:25:00'),
(1, 1, 1.15, '2023-11-15 11:30:00'),
(1, 1, 0.12, '2023-11-15 11:35:00'),
(1, 2, 2.12, "2023-11-15 10:00:00"),
(1, 2, 2.15, "2023-11-15 10:05:00"),
(1, 2, 1.18, "2023-11-15 10:10:00"),
(1, 2, 2.22, "2023-11-15 10:15:00"),
(2, 2, 1.55, "2023-11-15 10:20:00"),
(1, 2, 2.3, "2023-11-15 10:25:00"),
(1, 2, 1.25, "2023-11-15 10:30:00"),
(1, 2, 2.19, "2023-11-15 10:35:00"),
(1, 2, 2.21, "2023-11-15 10:40:00"),
(1, 2, 1.28, "2023-11-15 10:45:00"),
(2, 2, 1.65, "2023-11-15 10:50:00"),
(3, 2, 2.85, "2023-11-15 10:55:00"),
(3, 2, 1.95, "2023-11-15 11:00:00"),
(2, 2, 1.75, "2023-11-15 11:05:00"),
(1, 2, 1.35, "2023-11-15 11:10:00"),
(1, 2, 1.28, "2023-11-15 11:15:00"),
(1, 2, 0.22, "2023-11-15 11:20:00"),
(1, 2, 1.18, "2023-11-15 11:25:00"),
(1, 2, 1.15, "2023-11-15 11:30:00"),
(1, 2, 0.12, "2023-11-15 11:35:00");
