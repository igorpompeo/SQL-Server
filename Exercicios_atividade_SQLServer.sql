/*Crie uma função que receba o nome de um professor e retorne a carga 
horária total de suas disciplinas.*/

CREATE OR REPLACE FUNCTION htotal @Nome VARCHAR(100) AS
BEGIN
	/*
	DECLARE @RESULT INT;
    set @RESULT =  (select SUM (Disciplina.carga) from Oferecimento 
    	inner join Professor on Oferecimento.prof_cod = Professor.prof_cod
    	inner join Disciplina on Oferecimento.disc_cod = Disciplina.disc_cod 
	where Professor.nome = @Nome);
    Return @RESULT;
    */
	SELECT prof_cod, disc_cod FROM Oferecimento
		INNER JOIN Professor ON
			Oferecimento.prof_cod = Professor.prof_cod
		INNER JOIN Disciplina ON
			Oferecimento.disc_cod = Disciplina.disc_cod
	RETURN SUM(Disciplina.carga);
END;
GO

/*Crie uma função que receba o nome de um professor e retorne o número 
de disciplinas lecionadas por esse professor.*/

CREATE OR REPLACE FUNCTION leciona @Nome VARCHAR(100) AS
BEGIN
	SELECT prof_cod, disc_cod FROM Oferecimento
		INNER JOIN Professor ON
			Oferecimento.prof_cod = Professor.prof_cod
		INNER JOIN Disciplinas ON
			Oferecimento.disc_cod = Disciplina.disc_cod
		RETURN COUNT(Oferecimento.disc_cod);
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
