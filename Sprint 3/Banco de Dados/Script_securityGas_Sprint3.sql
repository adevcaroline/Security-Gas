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

insert into restaurante  (nome_restaurante, codigo_ativacao) values 
('Coco bambum', 'AWD123');

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
data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
foreign key (fkAlerta) references alerta(idAlerta),
foreign key (fkSensor) references sensor(idSensor)
);

ALTER TABLE leitura_sensor
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;

ALTER TABLE leitura_sensor
CHANGE COLUMN id idLeitura INT AUTO_INCREMENT;

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

select * from restaurante;

INSERT INTO endereco (cep, cidade, estado, logradouro, numero, fkRestaurante) VALUES 
('01311-000', 'São Paulo', 'SP', 'Av. Paulista', '1000', 1);

INSERT INTO alerta (nivel_alerta, mensagem) VALUES 
('Normal', 'Níveis seguros'),
('Alerta', 'Atenção: gás detectado'),
('Crítico', 'EVACUAR: risco de explosão');

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
(2, 1, 1.45, '2025-05-17 16:00:00');

-- MES 6
INSERT INTO leitura_sensor (fkAlerta, fkSensor, porcentagem_captada, data_hora) VALUES
-- Sensor 1 (Cozinha)
(1, 1, 0.25, '2025-06-06 08:00:00'),
(1, 1, 0.80, '2025-06-06 10:00:00'),
(2, 1, 1.25, '2025-06-06 12:00:00'),
(1, 1, 0.45, '2025-06-06 14:00:00'),
(1, 1, 0.60, '2025-06-06 16:00:00'),
(2, 1, 1.75, '2025-06-06 08:00:00'),
(3, 1, 1.9, '2025-06-07 10:00:00'),
(2, 1, 1.95, '2025-06-07 12:00:00'),
(1, 1, 0.30, '2025-06-08 14:00:00'),
(1, 1, 0.70, '2025-06-08 16:00:00'),
(3, 1, 2.0, '2025-06-08 08:00:00'),
(2, 1, 1.55, '2025-06-08 10:00:00'),
(1, 1, 0.90, '2025-06-08 12:00:00'),
(1, 1, 0.85, '2025-06-08 14:00:00'),
(2, 1, 1.45, '2025-06-08 16:00:00');

-- Sensor 3 (CadaVez) - Local 2
INSERT INTO leitura_sensor (fkAlerta, fkSensor, porcentagem_captada, data_hora) VALUES
(1, 3, 0.20, '2025-05-15 08:00:00'),
(1, 3, 0.75, '2025-05-15 10:00:00'),
(2, 3, 1.20, '2025-05-15 12:00:00'),
(1, 3, 0.40, '2025-05-15 14:00:00'),
(1, 3, 0.65, '2025-05-15 16:00:00'),
(2, 3, 1.60, '2025-05-16 08:00:00'),
(3, 3, 1.85, '2025-05-16 10:00:00'),
(2, 3, 1.90, '2025-05-16 12:00:00'),
(1, 3, 0.35, '2025-05-16 14:00:00'),
(1, 3, 0.60, '2025-05-16 16:00:00');

-- Sensor 4 (Alto) - Local 2
INSERT INTO leitura_sensor (fkAlerta, fkSensor, porcentagem_captada, data_hora) VALUES
(1, 4, 0.30, '2025-05-15 08:00:00'),
(2, 4, 1.10, '2025-05-15 10:00:00'),
(3, 4, 2.10, '2025-05-15 12:00:00'),
(2, 4, 1.65, '2025-05-15 14:00:00'),
(1, 4, 0.55, '2025-05-15 16:00:00'),
(1, 4, 0.40, '2025-05-16 08:00:00'),
(2, 4, 1.45, '2025-05-16 10:00:00'),
(3, 4, 2.20, '2025-05-16 12:00:00'),
(2, 4, 1.70, '2025-05-16 14:00:00'),
(1, 4, 0.90, '2025-05-16 16:00:00');
select * from local_instalacao join sensor on local_instalacao.idLocal_instalacao = sensor.fkLocal_instalacao;




-- Sensor 4 (Alto) - Teste4
INSERT INTO leitura_sensor (fkAlerta, fkSensor, porcentagem_captada, data_hora) VALUES
(1, 4, 0.30, '2025-05-15 08:00:00'),
(2, 4, 1.10, '2025-05-15 10:00:00'),
(3, 4, 2.10, '2025-05-15 12:00:00'),
(2, 4, 1.65, '2025-05-15 14:00:00'),
(1, 4, 0.55, '2025-05-15 16:00:00'),
(1, 4, 0.40, '2025-05-16 08:00:00'),
(2, 4, 1.45, '2025-05-16 10:00:00'),
(3, 4, 2.20, '2025-05-16 12:00:00'),
(2, 4, 1.70, '2025-05-16 14:00:00'),
(1, 4, 0.90, '2025-05-16 16:00:00');

select * from leitura_sensor;

DESCRIBE leitura_sensor;

select * from local_instalacao;

SELECT
        loc.nome_local AS nome_local,
        sen.nome_sensor AS nome_sensor,
        lei.data_hora AS data_hora,
        alerta.nivel_alerta AS nivel_alerta
        FROM leitura_sensor AS lei
        JOIN sensor AS sen ON lei.fkSensor = sen.idSensor
        JOIN local_instalacao AS loc ON sen.fkLocal_instalacao = loc.idLocal_instalacao
        JOIN alerta ON lei.fkAlerta = alerta.idAlerta
        WHERE alerta.nivel_alerta IN ('Crítico', 'Alerta')
        AND loc.idLocal_instalacao = 1
        ORDER BY lei.data_hora DESC;
        
        
        select * from local_instalacao;
        select * from sensor;
        
        select * from leitura_sensor left join sensor on leitura_sensor.fkSensor = sensor.idSensor
        left join local_instalacao on local_instalacao.idLocal_instalacao = sensor.fkLocal_instalacao
        where idLocal_instalacao = 2;
        
        SELECT idUsuario, nome, email, fkRestaurante, nome_restaurante FROM usuario join restaurante on usuario.fkRestaurante = restaurante.idRestaurante WHERE email = 'ana.mioki@sptech' AND senha = 'Senha123@';

    SELECT 
            COUNT(*) AS total_criticos_mes
        FROM leitura_sensor ls
        JOIN sensor s ON ls.fkSensor = s.idSensor
        JOIN local_instalacao li ON s.fkLocal_instalacao = li.idLocal_instalacao
        JOIN alerta a ON ls.fkAlerta = a.idAlerta
        WHERE a.nivel_alerta = 'Crítico'
        AND li.fkRestaurante = 1
        AND MONTH(ls.data_hora) = MONTH(CURRENT_DATE())
        AND YEAR(ls.data_hora) = YEAR(CURRENT_DATE());
