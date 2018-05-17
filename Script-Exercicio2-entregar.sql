-- criação do banco de dados
create database Exercicio2
go

--criação Pessoa
create table Pessoa(
	Cpf char(11) primary key not null,
	Num_carteira_motorista char(11),
	Nome varchar(100) not null,
	Endereco varchar(300),
	Id_proprietario int not null);

--criação Banco
create table Banco(
	Bnome varchar(100) primary key not null,
	Bendereco varchar(300),
	Id_proprietario int not null);

--criação Empresa
create table Empresa(
	Enome varchar(100) primary key not null,
	Eendereco varchar(200),
	Id_proprietario int not null);

--criação Proprietario
create table Proprietario(
	Id_proprietario int primary key not null);

--criação Veiculo_Registrado
create table Veiculo_Registrado(
	Cod_veiculo varchar(100) primary key not null,
	Placa varchar(7));

--criação Carro
create table Carro(
	Cod_veiculo varchar(100) primary key not null,
	Estilo varchar(10),
	Marca_carro varchar(20),
	Modelo_carro varchar(10)
	Ano_carro date);

--criação Caminhao
create table Caminhao(
	Cod_veiculo varchar(100)primary key not null,
	Marca_caminhao varchar(20),
	Modelo_caminhao varchar(10),
	Capacidade_peso float,
	Ano_caminhao date);

--criação Dono
create table Dono(
	Id_proprietario int primary key not null,
	Cod_veiculo varchar(100) primary key not null,
	Data_compra date,
	Alienado_ou_regular varchar(100)
	);