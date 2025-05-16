create database securitygas3;
use securitygas3;

create table restaurante(
idRestaurante int primary key auto_increment,
nome_restaurante varchar(45) not null,
cnpj char(14) not null,
telefoneFixo varchar(45)
);

create table usuario(
idUsuario int primary key auto_increment,
nome varchar(45),
email varchar(50),
senha varchar(45),
celular char(11),
fkRestaurante int,
foreign key (fkRestaurante) references restaurante(idRestaurante)
);

create table endereco(
idEndereco int primary key auto_increment,
cep char(9) not null,
cidade varchar(45) not null,
estado varchar(45) not null,
logradouro varchar(45) not null,
numero varchar(10) not null,
fkRestaurante int,
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
statusAtivacao boolean,
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
porcentagem_captada int,
data_hora datetime,
foreign key (fkAlerta) references alerta(idAlerta),
foreign key (fkSensor) references sensor(idSensor)
);

