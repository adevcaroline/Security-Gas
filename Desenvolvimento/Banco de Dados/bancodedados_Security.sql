-- comando de criação do bando de dados
create database pi;


-- comando de utilização do bando de dados
use pi;


-- criação da tabela sensorGas com o campos 
-- (idSensor, idEmpresa, nome, statusGas, quantidadePPM, dtInstalacao, dtUltimaManutencao)


CREATE TABLE sensorGas(
	idSensor INT PRIMARY KEY AUTO_INCREMENT, -- idSensor = o número de identificação do sensor (empresa não tem acesso)
	nome VARCHAR(50), -- nome = nome do sensor para a empresa identificar o sensor
	statusGas BOOL, -- statusGas = Irá dizer se está vazando ou não
    quantidadePorcen FLOAT, -- quantidadePPM = representa a porcentagem gas detectado pelo sensor de gás
    dtInstalacao DATE, -- dtInstalacao = data em que o sensor foi instalado
	fkUnidade INT -- fkEmpresa = o número de identificação da empresa

);

CREATE TABLE empresa(
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT, -- idEmpresa = número de identificação da empresa (empresa não tem acesso)
    nome VARCHAR(50), -- nomeEmpresa = nome da empresa no sistema
    cnpj CHAR(14), -- cnpj = identificação da empresa
    telefone CHAR(13), -- telefone = número de contato com a empresa
    email VARCHAR(255)-- para contato

);

CREATE TABLE unidade(
    idUnidade INT PRIMARY KEY AUTO_INCREMENT, -- idUnidade = número de indetificação da unidade (para o banco de dados, empresa não tem acesso)
    nome VARCHAR(50), -- nome = nome da unidade
    sufixo VARCHAR(4),-- sufixo = número de identificação da unidade para a empresa
    logradouro VARCHAR(50), -- endereço = nome da localização da unidade
	numero VARCHAR(10),
	bairro VARCHAR(50),
	cidade VARCHAR(50),
	estado VARCHAR(50),
    cep CHAR(9), -- cep = código de localização da unidade
    qtdSensores INT, -- qtdSensores == quantidade de sensores que a unidade da empresa utiliza
    email VARCHAR(255) UNIQUE, -- email = email da unidade da empresa para contato
    telefone CHAR(13), -- telefone = número de contato com a unidade
    fkEmpresa INT -- fkEmpresa -- será pego os dados da tabela empresa pela `chave estrangeira`
);


CREATE TABLE usuario(
	idUsuario INT PRIMARY KEY AUTO_INCREMENT, -- idUsuario = número de identificação do usuário (empresa não tem acesso)
	idEmpresa INT, -- idEmpresa = será pego os dados da tabela empresa pelo `chave estrangeira`
	idUnidade INT, -- idUnidade = será pego os dados da tabela unidade pela `chave estrangeira`
    nome VARCHAR (50), -- nome = nome dado ao `funcionário` da empresa
	senha VARCHAR(255), -- senha - código de acesso do usuário
	email VARCHAR(255) UNIQUE, -- email = email do `funcionário` da empresa para acesso de dados
	telefone CHAR(13), -- +551199690-0714
	cargo VARCHAR(20), -- cargo = o cargo serve para restrigir a quantidade de permições que o `funcionário` terá no site
	dtCriacaoConta DATETIME, -- data = data em que a conta foi criada
    logado BOOL, -- logado = status se está online ou não
	CONSTRAINT chk_cargo CHECK(cargo IN('Administrador', 'Funcionário', 'Representante')) -- constraint = sentença para o campo cargo
);

-- A tabela vazameto é uma tabela onde mostra as informações dos vazamentos que ocorreram
create table vazamento(
	idVazamento INT PRIMARY KEY AUTO_INCREMENT, -- idVazamneto = número de identificação do vazamento
	dtVazamento DATETIME, -- dtVazamento = data e hora em que o vazamento ocorreu
    fkSensor INT, -- fkSensor = será pego os dados do sensor que notifdicou o vazamento pela `chave estrangeira`
    fkFuncionario INT -- fkFuncionario = será pego o dado do funcionário que identificou o vazamento pela ´chave estrangeira´
);

-- Inserindo dados na tabela Empresa
INSERT INTO empresa (nome, cnpj, telefone, endereco, CEP, email)
VALUES 
('OutBack', '12345678901234', '1122334455', 'Rua A, 123', '01234-567', 'contato@outback.com');

-- Inserindo dados na tabela Unidade
INSERT INTO unidade (idEmpresa, nome, endereco, email, cep, qtdSensores, telefone, sufixo)
VALUES 
(1, 'Unidade Central', 'Rua B, 456', 'central@empresax.com', '98765-432', 10, '5566778899', 'CENT'),
(1, 'Unidade Leste', 'Rua C, 789', 'leste@empresax.com', '54321-987', 5, '9988776655', 'LEST');

-- Inserindo dados na tabela Usuario
INSERT INTO usuario (idEmpresa, idUnidade, nome, senha, email, telefone, cargo)
VALUES 
(1, 1, 'Carlos Silva', 'senha456', 'carlos@empresax.com', '551199999999', 'Administrador'),
(1, 2, 'Ana Oliveira', 'senha789', 'ana@empresax.com', '551198888888', 'Funcionário');

-- Inserindo dados na tabela sensorGas
INSERT INTO sensorGas (idUnidade, nome, statusGas, quantidadePorcen, dtInstalacao)
VALUES 
(1, 'Sensor A', 0, 40, '2025-01-10'),
(1, 'Sensor B', 1, 25, '2025-02-15');

-- Inserindo dados na tabela vazamento
INSERT INTO vazamento (dtVazamento, idSensor, idFuncionario)
VALUES 
('2025-03-15 08:20:00', 2, 1),
('2025-03-16 14:45:00', 2, 2);

SELECT * FROM vazamento;
select concat('O vazamento ocorreu no dia e horário:', dtVazamento) as vazamento from vazamento;

SELECT * FROM sensorGas;
select * from sensorGas where nome like '%a%';

SELECT * FROM usuario;
select ifnull(telefone,'Não há número de celular cadastrado') as telefone from Usuario;

SELECT * FROM unidade;
select case nome when 'Unidade Central' then 'Rua B, 456' else 'Rua C, 789' end as endereço from unidade;

SELECT * FROM empresa;
select * from empresa where idEmpresa = 1;