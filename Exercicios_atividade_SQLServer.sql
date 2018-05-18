/*Crie uma função que receba o nome de um professor e retorne a carga 
horária total de suas disciplinas.*/

CREATE OR ALTER FUNCTION htotal (@Nome VARCHAR(100))
RETURNS INT
BEGIN	
	DECLARE @result INT;
	SET @result = (select SUM (RA20198778_Igor.Disciplina.carga) from RA20198778_Igor.Oferecimento 
    	inner join RA20198778_Igor.Professor on RA20198778_Igor.Oferecimento.prof_cod = RA20198778_Igor.Professor.prof_cod
    	inner join RA20198778_Igor.Disciplina on Oferecimento.disc_cod = RA20198778_Igor.Disciplina.disc_cod 
	where RA20198778_Igor.Professor.nome = @Nome)
	RETURN @result;
END;
GO

select nome from RA20198778_Igor.Professor
select dbo.htotal('Flavia Oliveira') AS Total;

/*Crie uma função que receba o nome de um professor e retorne o número 
de disciplinas lecionadas por esse professor.*/

CREATE OR ALTER FUNCTION leciona (@Nome VARCHAR(100))
RETURNS INT
BEGIN
DECLARE @result INT;
	SET @result = (select count(RA20198778_Igor.Oferecimento.disc_cod) from RA20198778_Igor.Oferecimento
	inner join RA20198778_Igor.Professor on RA20198778_Igor.Oferecimento.prof_cod = RA20198778_Igor.Professor.prof_cod
	inner join RA20198778_Igor.Disciplina on RA20198778_Igor.Oferecimento.disc_cod = RA20198778_Igor.Disciplina.disc_cod
	where RA20198778_Igor.Professor.nome = @Nome)
		RETURN @result;
END;
GO

/*Crie um procedimento que receba dois valores de proporções (entre 0 e 1) 
e realize um acréscimo no salário dos professores utilizando a primeira 
proporção para professores mestres e a segunda proporção para 
professores doutores.*/

create procedure aumento (@valor1 float, @valor2 float) 
@nome rowtype Professor.nome = Professor.nome, 
@cidade rowtype Professor.cidade = Professor.cidade, 
@grau rowtype Professor.titulo = Professor.titulo,
@salario rowtype Professor.salario := Professor.salario
as
begin
set @nome = (select Professor.nome from RA20198778_Igor.Professor where Professor.nome = @nome)
set @cidade = (select Professor.cidade from RA20198778_Igor.Professor where Professor.cidade = @cidade)
set @grau = (select Professor.titulo from RA20198778_Igor.Professor where Professor.titulo = @titulo)
if @grau = 'Graduado' then
	@salario = @salario * @valor1
	insert into RA20198778_Igor.Professor (@nome, @cidade, @grau, @salario)
end if
else then
	@salario = @salario * @valor2
	insert into RA20198778_Igor.Professor (@nome, @cidade, @grau, @salairo)
end else
end;
go
	
/*Crie um procedimento que receba o nome de um curso e remova todas as 
disciplinas deste curso.*/

CREATE PROCEDURE deleta @Nome VARCHAR(50) AS
BEGIN
	SELECT curso_cod, disc_cod FROM Oferecimento
		INNER JOIN Curso ON
			Oferecimento.curso_cod = Curso.curso_cod
		INNER JOIN Disciplinas ON
			Oferecimento.disc_cod = Disciplina.disc_cod
		DELETE FROM Disciplina WHERE Curso.area = Disciplina.area;
END;
GO
