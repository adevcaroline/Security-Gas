create database securitygas;
use securitygas;

-- Tabela Empresa
CREATE TABLE Empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome_empresa VARCHAR(45),
    cnpj CHAR(14),
    email VARCHAR(45),
    telefone VARCHAR(20)
);

-- Tabela Unidade
CREATE TABLE Unidade (
    idUnidade INT PRIMARY KEY AUTO_INCREMENT,
    nome_unidade VARCHAR(45),
    email VARCHAR(45),
    telefone VARCHAR(20),
    cep CHAR(9),
    cidade VARCHAR(45),
    estado VARCHAR(45),
    logradouro VARCHAR(45),
    numero VARCHAR(10),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

-- Tabela Usuarios
CREATE TABLE Usuarios (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    email VARCHAR(50),
    senha VARCHAR(45),
    cargo VARCHAR(45),
    fkUnidade INT,
    FOREIGN KEY (fkUnidade) REFERENCES Unidade(idUnidade)
);

-- Tabela Sensores
CREATE TABLE Sensores (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    local_instalacao VARCHAR(100),
    statusAtivacao VARCHAR(15)
);


-- Tabela Leituras_sensor
CREATE TABLE Leituras_sensor (
    idLeitura INT PRIMARY KEY AUTO_INCREMENT,
    ppm INT,
    data_hora DATETIME,
    fkSensor INT,
    FOREIGN KEY (fkSensor) REFERENCES Sensores(idSensor)
);

-- Tabela Local_Instalacao
CREATE TABLE Local_Instalacao (
    idLocal_Instalacao INT PRIMARY KEY AUTO_INCREMENT,
    nome_localInstalacao VARCHAR(45),
    Unidade_idUnidade INT,
    Sensores_idSensor INT,
    FOREIGN KEY (Unidade_idUnidade) REFERENCES Unidade(idUnidade),
    FOREIGN KEY (Sensores_idSensor) REFERENCES Sensores(idSensor)
);

