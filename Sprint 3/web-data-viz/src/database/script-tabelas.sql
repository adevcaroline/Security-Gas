-- drop database securitygas3;

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

select * from local_instalacao;

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
data_hora datetime not null DEFAULT CURRENT_TIMESTAMP,
foreign key (fkAlerta) references alerta(idAlerta),
foreign key (fkSensor) references sensor(idSensor),
primary key (idLeitura, fkAlerta, fkSensor)
);

select * from leitura_sensor;

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


-- Inserindo usuário
INSERT INTO usuario (nome, email, senha, fkRestaurante) VALUES 
('Gerente MC', 'gerente@mc.com', 'senha123', 1);

-- Inserindo endereço
INSERT INTO endereco (cep, cidade, estado, logradouro, numero, fkRestaurante) VALUES 
('01311-000', 'São Paulo', 'SP', 'Av. Paulista', '1000', 1);

-- Inserindo locais de instalação (3 locais)
INSERT INTO local_instalacao (nome_local, fkRestaurante) VALUES 
('Cozinha Principal', 1),
('Área de Estocagem', 1),
('Refeitório', 1);

select * from local_instalacao;

-- Inserindo alertas
INSERT INTO alerta (nivel_alerta, mensagem) VALUES 
('Normal', 'Níveis seguros'),
('Alerta', 'Atenção: gás detectado'),
('Crítico', 'EVACUAR: risco de explosão');

-- Inserindo sensores (2 por local = total 6 sensores)
INSERT INTO sensor (nome_sensor, statusAtivacao, fkLocal_instalacao) VALUES 
-- Cozinha Principal (2 sensores)
('Sensor COZ-01', true, 1),
('Sensor COZ-02', true, 1),
-- Área de Estocagem (2 sensores)
('Sensor EST-01', true, 2),
('Sensor EST-02', true, 2),
-- Refeitório (2 sensores)
('Sensor REF-01', true, 3),
('Sensor REF-02', true, 3);

-- Leituras para todos os 6 sensores (90 leituras no total)
INSERT INTO leitura_sensor (fkAlerta, fkSensor, porcentagem_captada, data_hora) VALUES
-- Sensor 1 (Cozinha)
(1, 1, 0.25, '2025-05-15 08:00:00'),
(1, 1, 0.80, '2025-05-15 10:00:00'),
(2, 1, 1.25, '2025-05-15 12:00:00'),
(1, 1, 0.45, '2025-05-15 14:00:00'),
(1, 1, 0.60, '2025-05-15 16:00:00'),
(2, 1, 1.75, '2025-05-16 08:00:00'),
(3, 1, 1.9, '2025-05-16 10:00:00'),
(2, 1, 1.95, '2025-05-16 12:00:00'),
(1, 1, 0.30, '2025-05-16 14:00:00'),
(1, 1, 0.70, '2025-05-16 16:00:00'),
(3, 1, 2.0, '2025-05-17 08:00:00'),
(2, 1, 1.55, '2025-05-17 10:00:00'),
(1, 1, 0.90, '2025-05-17 12:00:00'),
(1, 1, 0.85, '2025-05-17 14:00:00'),
(2, 1, 1.45, '2025-05-17 16:00:00'),

-- Sensor 2 (Cozinha)
(1, 2, 0.15, '2025-05-15 08:15:00'),
(1, 2, 0.65, '2025-05-15 10:15:00'),
(1, 2, 0.40, '2025-05-15 12:15:00'),
(2, 2, 1.30, '2025-05-15 14:15:00'),
(1, 2, 0.75, '2025-05-15 16:15:00'),
(3, 2, 1.5, '2025-05-16 08:15:00'),
(2, 2, 1.85, '2025-05-16 10:15:00'),
(1, 2, 0.55, '2025-05-16 12:15:00'),
(1, 2, 0.35, '2025-05-16 14:15:00'),
(2, 2, 1.65, '2025-05-16 16:15:00'),
(1, 2, 0.95, '2025-05-17 08:15:00'),
(3, 2, 2.0, '2025-05-17 10:15:00'),
(2, 2, 1.75, '2025-05-17 12:15:00'),
(1, 2, 0.50, '2025-05-17 14:15:00'),
(1, 2, 0.65, '2025-05-17 16:15:00'),

-- Sensor 3 (Estocagem)
(1, 3, 0.20, '2025-05-15 08:30:00'),
(1, 3, 0.45, '2025-05-15 10:30:00'),
(2, 3, 1.15, '2025-05-15 12:30:00'),
(1, 3, 0.30, '2025-05-15 14:30:00'),
(1, 3, 0.25, '2025-05-15 16:30:00'),
(3, 3, 2.25, '2025-05-16 08:30:00'),
(2, 3, 1.35, '2025-05-16 10:30:00'),
(1, 3, 0.80, '2025-05-16 12:30:00'),
(1, 3, 0.60, '2025-05-16 14:30:00'),
(2, 3, 1.95, '2025-05-16 16:30:00'),
(1, 3, 0.40, '2025-05-17 08:30:00'),
(2, 3, 1.05, '2025-05-17 10:30:00'),
(3, 3, 2.75, '2025-05-17 12:30:00'),
(2, 3, 1.65, '2025-05-17 14:30:00'),
(1, 3, 0.55, '2025-05-17 16:30:00'),

-- Sensor 4 (Estocagem)
(1, 4, 0.10, '2025-05-15 08:45:00'),
(2, 4, 1.50, '2025-05-15 10:45:00'),
(1, 4, 0.75, '2025-05-15 12:45:00'),
(1, 4, 0.65, '2025-05-15 14:45:00'),
(3, 4, 2.85, '2025-05-15 16:45:00'),
(1, 4, 0.95, '2025-05-16 08:45:00'),
(2, 4, 1.25, '2025-05-16 10:45:00'),
(3, 4, 2.15, '2025-05-16 12:45:00'),
(2, 4, 1.45, '2025-05-16 14:45:00'),
(1, 4, 0.35, '2025-05-16 16:45:00'),
(1, 4, 0.25, '2025-05-17 08:45:00'),
(1, 4, 0.15, '2025-05-17 10:45:00'),
(2, 4, 1.35, '2025-05-17 12:45:00'),
(3, 4, 2.95, '2025-05-17 14:45:00'),
(2, 4, 1.55, '2025-05-17 16:45:00'),

-- Sensor 5 (Refeitório)
(1, 5, 0.05, '2025-05-15 09:00:00'),
(1, 5, 0.35, '2025-05-15 11:00:00'),
(2, 5, 1.20, '2025-05-15 13:00:00'),
(1, 5, 0.65, '2025-05-15 15:00:00'),
(3, 5, 3.10, '2025-05-15 17:00:00'),
(1, 5, 0.85, '2025-05-16 09:00:00'),
(2, 5, 1.15, '2025-05-16 11:00:00'),
(1, 5, 0.40, '2025-05-16 13:00:00'),
(2, 5, 1.80, '2025-05-16 15:00:00'),
(3, 5, 2.45, '2025-05-16 17:00:00'),
(1, 5, 0.55, '2025-05-17 09:00:00'),
(1, 5, 0.45, '2025-05-17 11:00:00'),
(2, 5, 1.25, '2025-05-17 13:00:00'),
(1, 5, 0.70, '2025-05-17 15:00:00'),
(2, 5, 1.35, '2025-05-17 17:00:00'),

-- Sensor 6 (Refeitório)
(1, 6, 0.15, '2025-05-15 09:15:00'),
(2, 6, 1.05, '2025-05-15 11:15:00'),
(1, 6, 0.45, '2025-05-15 13:15:00'),
(3, 6, 2.75, '2025-05-15 15:15:00'),
(2, 6, 1.65, '2025-05-15 17:15:00'),
(1, 6, 0.95, '2025-05-16 09:15:00'),
(1, 6, 0.25, '2025-05-16 11:15:00'),
(2, 6, 1.45, '2025-05-16 13:15:00'),
(1, 6, 0.60, '2025-05-16 15:15:00'),
(3, 6, 2.35, '2025-05-16 17:15:00'),
(2, 6, 1.25, '2025-05-17 09:15:00'),
(1, 6, 0.75, '2025-05-17 11:15:00'),
(1, 6, 0.65, '2025-05-17 13:15:00'),
(2, 6, 1.55, '2025-05-17 15:15:00'),
(3, 6, 2.95, '2025-05-17 17:15:00');


