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


