CREATE DATABASE securityGas;

Use securityGas;

CREATE TABLE Empresa (
    idEmpresa INT PRIMARY KEY,
    nome_empresa VARCHAR(45),
    cnpj CHAR(14),
    email VARCHAR(45),
    telefone VARCHAR(20)
);

CREATE TABLE Unidade (
    idUnidade INT PRIMARY KEY,
    nome_unidade VARCHAR(45),
    email VARCHAR(45),
    telefone VARCHAR(20),
    fkEmpresa INT,
    constraint fkUnidade_Empresa
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Endereco (
    idEndereco INT PRIMARY KEY,
    cep CHAR(9),
    cidade VARCHAR(45),
    estado VARCHAR(45),
    logradouro VARCHAR(45),
    numero VARCHAR(10),
    fkUnidade INT,
    constraint fkEndereco_Unidade
    FOREIGN KEY (fkUnidade) REFERENCES Unidade(idUnidade)
);

CREATE TABLE Usuarios (
    idUsuario INT PRIMARY KEY,
    nome VARCHAR(45),
    email VARCHAR(50),
    senha VARCHAR(45),
    cargo VARCHAR(45),
    fkUnidade INT,
    constraint fkUsuarios_Unidade
    FOREIGN KEY (fkUnidade) REFERENCES Unidade(idUnidade)
);

CREATE TABLE Local_instalacao (
    idLocal_instalacao INT PRIMARY KEY,
    nome_local VARCHAR(45),
    complemento VARCHAR(45),
    fkUnidade INT,
    constraint fkLocal_Unidade
    FOREIGN KEY (fkUnidade) REFERENCES Unidade(idUnidade)
);

CREATE TABLE Sensores (
    idSensor INT PRIMARY KEY,
    nome_sensor VARCHAR(45),
    statusAtivacao VARCHAR(15),
    fkLocal_instalacao INT,
    constraint fkSensores_Local
    FOREIGN KEY (fkLocal_instalacao) REFERENCES Local_instalacao(idLocal_instalacao)
);

CREATE TABLE Leituras_sensor (
    idLeitura INT,
    porcentagem_captada INT,
    data_hora DATETIME,
    fkSensor INT,
    PRIMARY KEY (idLeitura,fkSensor),
    constraint fkLeitura_Sensor
    FOREIGN KEY (fkSensor) REFERENCES Sensores(idSensor)
);

