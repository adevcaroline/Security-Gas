show databases;

create database securityGas;
USE securityGas;

SHOW TABLES;

CREATE TABLE Empresa (
  idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
  nome_empresa VARCHAR(100) NOT NULL,
  cnpj CHAR(14) NOT NULL UNIQUE,
  telefone_fixo CHAR(10)
);

CREATE TABLE Usuario (
  idUsuario INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  senha VARCHAR(100) NOT NULL,
  celular CHAR(11)
);

CREATE TABLE Unidade (
  idUnidade INT PRIMARY KEY AUTO_INCREMENT,
  nome_unidade VARCHAR(45) NOT NULL,
  codigo_unidade VARCHAR(20) NOT NULL UNIQUE,
  fkEmpresa INT NOT NULL,
  CONSTRAINT fkUnidadeEmpresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);


CREATE TABLE Acesso_usuario (
  idAcesso_usuario INT PRIMARY KEY AUTO_INCREMENT, -- como a fkUsuario pode ser nula por conta da regra de negócios n foi implementado uma pkComposta
  fkUsuario INT NOT NULL,
  fkEmpresa INT DEFAULT NULL, -- n vai ser null qnd for inserido a fk 
  fkUnidade INT DEFAULT NULL,
  nivel_acesso VARCHAR(20) NOT NULL CHECK(nivel_acesso IN('empresa','unidade')),
  CONSTRAINT fkAuUsuario FOREIGN KEY(fkUsuario) 
  REFERENCES Usuario(idUsuario),
  CONSTRAINT fkAuEmpresa FOREIGN KEY(fkEmpresa) 
  REFERENCES Empresa(idEmpresa),
  CONSTRAINT fkAuUnidade FOREIGN KEY(fkUnidade) 
  REFERENCES Unidade(idUnidade),
  CONSTRAINT chkVinculo CHECK((fkEmpresa IS NOT NULL AND fkUnidade IS NULL) 
  OR (fkEmpresa IS NULL AND fkUnidade IS NOT NULL)) -- para n ocasionar de ter as duas na mesma inserção 
);


CREATE TABLE Endereco (
  idEndereco INT PRIMARY KEY AUTO_INCREMENT,
  cep CHAR(9) NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  estado VARCHAR(45) NOT NULL,
  logradouro VARCHAR(45) NOT NULL,
  numero VARCHAR(10),
  fkUnidade INT NOT NULL,
  CONSTRAINT fkEnderecoUnidade FOREIGN KEY(fkUnidade) REFERENCES Unidade(idUnidade)
);

CREATE TABLE Local_instalacao (
  idLocal_instalacao INT PRIMARY KEY AUTO_INCREMENT,
  nome_local VARCHAR(45) NOT NULL,
  complemento VARCHAR(45),
  fkUnidade INT NOT NULL,
  CONSTRAINT fkLocUnidade FOREIGN KEY(fkUnidade) 
  REFERENCES Unidade(idUnidade)
);
CREATE TABLE Sensor (
  idSensor INT PRIMARY KEY AUTO_INCREMENT,
  nome_sensor VARCHAR(45) NOT NULL,
  statusAtivacao VARCHAR(10) NOT NULL CHECK(statusAtivacao IN('ativo','inativo')),
  fkLocal_instalacao INT NOT NULL,
  CONSTRAINT fkSensorelocal FOREIGN KEY(fkLocal_instalacao) 
  REFERENCES Local_instalacao(idLocal_instalacao)
);

CREATE TABLE Leitura_sensor (
  idLeitura INT PRIMARY KEY AUTO_INCREMENT,
  porcentagem_captada DECIMAL(5,2) NOT NULL, -- CHECK(porcentagem_captada>=1 AND porcentagem_captada<=100) caso decidamos armazenar só os de atencao e critico
  data_hora DATETIME NOT NULL,
  fkSensor INT NOT NULL,
  CONSTRAINT fkLeiturasensor FOREIGN KEY(fkSensor) 
  REFERENCES Sensores(idSensor)
);

CREATE TABLE Alerta (
  idAlerta INT PRIMARY KEY AUTO_INCREMENT,
  nivel_alerta VARCHAR(20) NOT NULL CHECK(nivel_alerta IN('normal','atencao','critico')),
  mensagem VARCHAR(200) NOT NULL
);
