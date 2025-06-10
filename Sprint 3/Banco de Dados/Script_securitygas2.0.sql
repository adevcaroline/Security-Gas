create database securitygas3;
use securitygas3;
drop database securitygas3;
CREATE DATABASE securitygas3;
USE securitygas3;

CREATE TABLE restaurante (
	-- ADICIONAR UNIQUE 
    idRestaurante INT PRIMARY KEY AUTO_INCREMENT,
    nome_restaurante VARCHAR(45) NOT NULL,
    codigo_ativacao CHAR(6) UNIQUE
);

CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(50) NOT NULL,
    senha VARCHAR(45) NOT NULL,
    fkRestaurante INT,
    FOREIGN KEY (fkRestaurante) REFERENCES restaurante(idRestaurante) ON DELETE CASCADE
);

CREATE TABLE endereco (
    idEndereco INT AUTO_INCREMENT,
    cep CHAR(9) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    estado VARCHAR(45) NOT NULL,
    logradouro VARCHAR(45) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    fkRestaurante INT,
    CONSTRAINT pkCompostaEndereco PRIMARY KEY (idEndereco, fkRestaurante),
    FOREIGN KEY (fkRestaurante) REFERENCES restaurante(idRestaurante) ON DELETE CASCADE
);

CREATE TABLE local_instalacao (
    idLocal_instalacao INT PRIMARY KEY AUTO_INCREMENT,
    nome_local VARCHAR(45) NOT NULL,
    fkRestaurante INT,
    FOREIGN KEY (fkRestaurante) REFERENCES restaurante(idRestaurante) ON DELETE CASCADE
);

CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    nome_sensor VARCHAR(45) NOT NULL,
    statusAtivacao BOOLEAN NOT NULL,
    fkLocal_instalacao INT,
    FOREIGN KEY (fkLocal_instalacao) REFERENCES local_instalacao(idLocal_instalacao) ON DELETE CASCADE
);

CREATE TABLE alerta (
    idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    nivel_alerta VARCHAR(45) NOT NULL,
    mensagem VARCHAR(45)
);

CREATE TABLE leitura_sensor (
    idLeitura INT AUTO_INCREMENT PRIMARY KEY,
    fkAlerta INT,
    fkSensor INT,
    porcentagem_captada INT NOT NULL,
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fkAlerta) REFERENCES alerta(idAlerta) ON DELETE SET NULL,
    FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor) ON DELETE CASCADE
);

insert into restaurante (nome_restaurante, codigo_ativacao) values 
('MC', 'ABC123');

insert into restaurante  (nome_restaurante, codigo_ativacao) values 
('Coco bambum', 'AWD123');

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
select * from sensor;

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


INSERT INTO leitura_sensor (fkAlerta, fkSensor, porcentagem_captada, data_hora) VALUES
(3, 1, 1.9, '2025-06-08 22:02:00');

INSERT INTO leitura_sensor (fkAlerta, fkSensor, porcentagem_captada, data_hora) VALUES
(2, 1, 1.9, '2025-06-08 22:26:00');

INSERT INTO leitura_sensor (fkAlerta, fkSensor, porcentagem_captada, data_hora) VALUES
(1, 1, 1, '2025-06-08 22:46:00');

INSERT INTO leitura_sensor (fkAlerta, fkSensor, porcentagem_captada, data_hora) VALUES
(3, 2, 4, '2025-06-08 22:47:00');

INSERT INTO leitura_sensor (fkAlerta, fkSensor, porcentagem_captada, data_hora) VALUES
(2, 1, 1.8, '2025-06-08 22:47:00');

INSERT INTO leitura_sensor (fkAlerta, fkSensor, porcentagem_captada, data_hora) VALUES
(1, 2, 1, '2025-06-08 22:46:00');

INSERT INTO leitura_sensor (fkAlerta, fkSensor, porcentagem_captada, data_hora) VALUES
-- Sensor 1 (Cozinha)
(1, 2, 0.25, '2025-06-06 08:00:00'),
(1, 2, 0.80, '2025-06-06 10:00:00'),
(2, 2, 1.25, '2025-06-06 12:00:00'),
(1, 2, 0.45, '2025-06-06 14:00:00'),
(1, 2, 0.60, '2025-06-06 16:00:00'),
(2, 2, 1.75, '2025-06-06 08:00:00'),
(3, 2, 1.9, '2025-06-07 10:00:00'),
(2, 2, 1.95, '2025-06-07 12:00:00'),
(1, 2, 0.30, '2025-06-08 14:00:00'),
(1, 2, 0.70, '2025-06-08 16:00:00'),
(3, 2, 2.0, '2025-06-08 08:00:00'),
(2, 2, 1.55, '2025-06-08 10:00:00'),
(1, 2, 0.90, '2025-06-08 12:00:00'),
(1, 2, 0.85, '2025-06-08 14:00:00'),
(2, 2, 1.45, '2025-06-08 16:00:00');

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

select * from sensor join local_instalacao on local_instalacao.idLocal_instalacao = sensor.fkLocal_instalacao;
select * from leitura_sensor join sensor on leitura_sensor.fkSensor = sensor.idSensor join alerta on leitura_sensor.fkAlerta = alerta.idAlerta;

   SELECT 
            s.idSensor,
            ls.idLeitura,
            s.nome_sensor,
            l.nome_local,
            ls.porcentagem_captada
        FROM sensor s
        JOIN local_instalacao l ON s.fkLocal_instalacao = l.idLocal_instalacao
        JOIN leitura_sensor ls ON s.idSensor = ls.fkSensor
        WHERE ls.idLeitura IN (
            SELECT MAX(idLeitura)
            FROM leitura_sensor
            GROUP BY fkSensor
        );
        
select * from usuario;
select * from restaurante;
select * from sensor;
