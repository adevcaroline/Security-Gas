CREATE DATABASE securityGas;
Use securityGas;

CREATE TABLE Empresa (
    idEmpresa INT PRIMARY KEY auto_increment,
    nome_empresa VARCHAR(45) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    email VARCHAR(45) NOT NULL,
    telefone VARCHAR(20) NOT NULL
);

CREATE TABLE Unidade (
    idUnidade INT PRIMARY KEY auto_increment,
    nome_unidade VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    fkEmpresa INT NOT NULL,
    constraint fkUnidade_Empresa
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Endereco (
    idEndereco INT PRIMARY KEY auto_increment,
    cep CHAR(9) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    estado VARCHAR(45) NOT NULL,
    logradouro VARCHAR(45) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    fkUnidade INT NOT NULL,
    constraint fkEndereco_Unidade
    FOREIGN KEY (fkUnidade) REFERENCES Unidade(idUnidade)
);

CREATE TABLE Usuarios (
    idUsuario INT PRIMARY KEY auto_increment,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(50) NOT NULL,
    senha VARCHAR(45) NOT NULL,
	cargo VARCHAR(45) NOT NULL CHECK (cargo IN ('Gerente', 'Técnico(a)')),
    fkUnidade INT NOT NULL,
    constraint fkUsuarios_Unidade
    FOREIGN KEY (fkUnidade) REFERENCES Unidade(idUnidade)
);

CREATE TABLE Local_instalacao (
    idLocal_instalacao INT PRIMARY KEY auto_increment,
    nome_local VARCHAR(45) NOT NULL,
    complemento VARCHAR(45) NOT NULL,
    fkUnidade INT NOT NULL,
    constraint fkLocal_Unidade
    FOREIGN KEY (fkUnidade) REFERENCES Unidade(idUnidade)
);

CREATE TABLE Sensores (
    idSensor INT PRIMARY KEY auto_increment,
    nome_sensor VARCHAR(45) NOT NULL,
    statusAtivacao VARCHAR(15) NOT NULL,
    fkLocal_instalacao INT NOT NULL,
    constraint fkSensores_Local
    FOREIGN KEY (fkLocal_instalacao) REFERENCES Local_instalacao(idLocal_instalacao)
);

CREATE TABLE Leituras_sensor (
    idLeitura INT PRIMARY KEY auto_increment,
    porcentagem_captada INT NOT NULL,
    data_hora DATETIME NOT NULL,
    fkSensor INT NOT NULL,
    constraint fkLeitura_Sensor
    FOREIGN KEY (fkSensor) REFERENCES Sensores(idSensor)
);

-- Inserindo dados na tabela empresa
INSERT INTO Empresa (idEmpresa, nome_empresa, cnpj, email, telefone)
VALUES 
(1, 'Sabor & Cia', '12345678000191', 'contato@saborecia.com', '(11) 3000-1000'),
(2, 'Grill Master', '22345678000192', 'contato@grillmaster.com', '(11) 4000-2000'),
(3, 'Veggie House', '32345678000193', 'contato@veggiehouse.com', '(11) 5000-3000');

-- UNIDADES
INSERT INTO Unidade (idUnidade, nome_unidade, email, telefone, fkEmpresa)
VALUES 
(1, 'Sabor & Cia - Centro', 'centro@saborecia.com', '(11) 91111-1111', 1),
(2, 'Sabor & Cia - Zona Sul', 'zonasul@saborecia.com', '(11) 91111-2222', 1),
(3, 'Grill Master - Moema', 'moema@grillmaster.com', '(11) 92222-3333', 2),
(4, 'Grill Master - Itaim', 'itaim@grillmaster.com', '(11) 92222-4444', 2),
(5, 'Veggie House - Paulista', 'paulista@veggiehouse.com', '(11) 93333-5555', 3),
(6, 'Veggie House - Vila Madalena', 'vilamadalena@veggiehouse.com', '(11) 93333-6666', 3);

-- USUÁRIOS
INSERT INTO Usuarios (idUsuario, nome, email, senha, cargo, fkUnidade)
VALUES 
(1, 'Mariana Alves', 'mariana@saborecia.com', 'senha123', 'Gerente', 1),
(2, 'Rafael Lima', 'rafael@saborecia.com', 'senha123', 'Técnico(a)', 1),
(3, 'Fernanda Rocha', 'fernanda@saborecia.com', 'senha123', 'Técnico(a)', 2),
(4, 'João Mendes', 'joao@grillmaster.com', 'senha123', 'Gerente', 3),
(5, 'Lucas Pereira', 'lucas@grillmaster.com', 'senha123', 'Técnico(a)', 4),
(6, 'Beatriz Nunes', 'beatriz@veggiehouse.com', 'senha123', 'Gerente', 5),
(7, 'Patrícia Dias', 'patricia@veggiehouse.com', 'senha123', 'Técnico(a)', 6);

-- LOCAIS
INSERT INTO Local_instalacao (idLocal_instalacao, nome_local, complemento, fkUnidade)
VALUES 
(1, 'Cozinha Principal', 'Subsolo', 1),
(2, 'Cozinha Secundária', 'Fundos', 1),
(3, 'Estoque de Gás', 'Lado externo', 2),
(4, 'Cozinha Churrasqueira', 'Térreo', 3),
(5, 'Cozinha', 'Subsolo', 4),
(6, 'Cozinha', 'Terraço', 5),
(7, 'Instalação Externa', 'Subsolo', 6);

-- SENSORES
INSERT INTO Sensores (idSensor, nome_sensor, statusAtivacao, fkLocal_instalacao)
VALUES 
(1, 'Sensor S1', 'Ativo', 1),
(2, 'Sensor S2', 'Ativo', 2),
(3, 'Sensor A1', 'Inativo', 3),
(4, 'Sensor A2', 'Ativo', 4),
(5, 'Sensor B1', 'Ativo', 5),
(6, 'Sensor B2', 'Inativo', 6),
(7, 'Sensor C1', 'Ativo', 7);

INSERT INTO Leituras_sensor (idLeitura, porcentagem_captada, data_hora, fkSensor)
VALUES 
(1, 0, '2025-04-20 08:00:00', 1),
(2, 5, '2025-04-20 09:00:00', 1),
(3, 6, '2025-04-20 10:00:00', 2),
(4, 5, '2025-04-20 08:30:00', 3),
(5, 0, '2025-04-20 09:30:00', 4),
(6, 8, '2025-04-20 08:45:00', 5),
(7, 0, '2025-04-20 09:15:00', 6),
(8, 2, '2025-04-20 10:30:00', 7);


-- Leituras acima de 2 (Alerta Emitido)
SELECT l.idLeitura, l.porcentagem_captada, s.nome_sensor, loc.nome_local, u.nome_unidade
FROM Leituras_sensor l
JOIN Sensores s ON l.fkSensor = s.idSensor
JOIN Local_instalacao loc ON s.fkLocal_instalacao = loc.idLocal_instalacao
JOIN Unidade u ON loc.fkUnidade = u.idUnidade
WHERE l.porcentagem_captada >= 2;

-- Sensores inativos por unidade (sensor com problema)
SELECT s.nome_sensor, s.statusAtivacao, un.nome_unidade
FROM Sensores s
JOIN Local_instalacao l ON s.fkLocal_instalacao = l.idLocal_instalacao
JOIN Unidade un ON l.fkUnidade = un.idUnidade
WHERE s.statusAtivacao = 'Inativo';

-- Relatório de usuários por empresa
SELECT e.nome_empresa, u.nome, u.cargo, un.nome_unidade
FROM Usuarios u
JOIN Unidade un ON u.fkUnidade = un.idUnidade
JOIN Empresa e ON un.fkEmpresa = e.idEmpresa;

-- Locais seguros (sem vazamento de gas)
SELECT l.idLeitura, l.porcentagem_captada, s.nome_sensor, loc.nome_local, u.nome_unidade
FROM Leituras_sensor l
JOIN Sensores s ON l.fkSensor = s.idSensor
JOIN Local_instalacao loc ON s.fkLocal_instalacao = loc.idLocal_instalacao
JOIN Unidade u ON loc.fkUnidade = u.idUnidade
WHERE l.porcentagem_captada = 0;


