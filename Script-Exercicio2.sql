/*Exercício 2*/

create table Paciente 
(cpf char(11) primary key,
nome varchar(100),
rua varchar(255),
bairro varchar(255),
numero int,
complemento varchar(255),
data_nascimento date);

create table Variante(
codigo bigint identity primary key,
cromossomo varchar(50),
posicao bigint,
referencia varchar(255),
alterado varchar(255)
);

create table Amostra(
codigo int identity primary key,
cpf_paciente char(11) foreign key references Paciente(cpf),
cid varchar(100),
observacao varchar(255),
tecido varchar(100)
);

create table EXAC(
cod_variante bigint primary key,
populacao varchar(10),
frequencia real,
foreign key (cod_variante) references Variante(codigo),
primary key (cod_variante, populacao)
);

create table Gene(
codigo cromosso varchar(50),
inicio bigint,
fim bigint,
nome varchar(20)
);

create table Variante_Amostra(
cod_amostra int,
cod_variante bigint,
primary key (cod_amostra, cod_variante),
foreign key (cod_amostra) references Amostra(codigo),
foreign key (cod_variante) references Variante(codigo)
);
