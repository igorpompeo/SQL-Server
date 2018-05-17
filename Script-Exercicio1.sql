--script do exercicio 09/03/2018
create database Exercicio1

use Exercicio1

create table Livro(
	Codigo int identity(1,1) primary key,
	Titulo varchar (1000),
	Nome_Editora varchar (1000));

create table Livro_Autor(
	Cod_Livro int foreign key references Livro(Codigo),
	Nome_Autor varchar(1000));

create table Editora(
	Codigo int primary key,
	Nome varchar(100),
	Endereço varchar(100),
	Telefone varchar(10));

create table Unidade_Biblioteca(
	Codigo int primary key,
	Nome varchar(100),
	Endereço varchar(100));

create table Livro_Copias(
	Cod_Livro int foreign key references Livro(Codigo),
	Cod_Unidade int foreign key references Unidade_Biblioteca(Codigo)
	primary key (Cod_Livro, Cod_Unidade));

create table Livro_Emprestimo(
	Cod_Livro int,
	Cod_Unidade int foreign key references Unidade_Biblioteca(Codigo),
	Num_Cartão int,
	Data_emprestimo date,
	Data_devolução date
	primary key (Cod_Livro, Num_Cartão, Cod_Unidade));

create table Usuário(
	Num_Cartão int primary key,
	Nome varchar(100),
	Endereço varchar(100),
	Telefone varchar(10));