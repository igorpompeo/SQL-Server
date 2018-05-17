--criação do banco de dados
CREATE DATABASE igor_20198778
GO

--comando para usar o banco de dados que foi criado
use igor_20198778;

--criação da tabela
create table Aluno (Nome varchar (100) not null,
	Cpf char (11) primary key,
	Telefone char (12) not null,
	Endereco varchar (300),
	Cidade varchar(100),
	Nascimento date);

--comando para confirmar se foi criada a tabela
Select * from Aluno;

/*deletar a tabela
drop table Aluno;*/

--criação da tabela com PK e FK
create table Matricula (Cpf_Aluno char (11),
	Disciplina varchar(100),
	foreign key (Cpf_aluno) references Aluno(Cpf),
	primary key (Cpf_Aluno, Disciplina));

--criando tabela com coluna sequencial
create table Livro(
	codigo int identity(1,1) primary key,
	nome varchar(100),
	Author varchar(100));

--inserção de valor na tabela livro
insert into Livro values ('Senhor dos Aneis: Sociedade do Anel', 'Tolkien');
insert into Livro values('Senhor dos Aneis: As duas Torres', 'Tolkien');

select * from Livro
--comando de alteração de uma tabela, inserção de uma nova coluna
alter table Livro add Autor varchar(100);
select * from Aluno
alter table Aluno add Curso varchar(1000);

insert into Aluno (Nome, Cpf, Telefone, Endereco, Cidade, Nascimento, Curso) 
	values ('Igor', '1234567890', '12345678900', 'aosidnsaodin', 'oasidnasdoin', '10/18/1990', 'SI')