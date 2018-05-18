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

CREATE PROCEDURE deposita (@valor1 FLOAT, @valor2 FLOAT) AS
BEGIN
	IF Professor.titulo = 'Graduado' THEN
		Professor.salario = Professor.salario * @valor1;
		INSERT INTO Professor.salario VALUE (Professor.salario);
	END IF
	IF Professor.titulo = 'Doutor' THEN
		Professor.salario = Professor.salario * @valor2;
		INSERT INTO Professor.salario VALUE (Professor.salario);
	END IF
END;
GO
	
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
