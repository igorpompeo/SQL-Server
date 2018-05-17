USE MeuDB;
GO

-- Possíveis consultas com a tabela professor

-- Consulta na tabela professor
SELECT * FROM Professor;

-- Quais sao os professores com doutorado ?
SELECT nome, titulo FROM Professor WHERE titulo LIKE 'doutor';

-- Qual o salario dos professores doutores ?
SELECT nome, titulo, salario FROM Professor WHERE titulo LIKE 'doutor';

-- E possivel aplicar operacoes a uma coluna

-- Qual sera o salario dos professores se houver um acrescimo de 10 porcento ? 
SELECT nome, titulo, salario, salario * 1.1 AS Com_acrescimo FROM Professor ;

-- Ordene os professores pelo salario
-- Ordem crescente
SELECT * FROM Professor ORDER BY salario;
-- Ordem decrescente
SELECT * FROM Professor ORDER BY salario DESC;

-- Qual a media salarial por titulacao ?
SELECT titulo, AVG(salario) AS Media FROM Professor GROUP BY titulo ORDER By Media;

-- Qual o maior salario ?
SELECT MAX(salario) AS MaiorSalario FROM Professor;

-- Qual o menor salario ?
SELECT MIN(salario) AS MenorSalario FROM Professor;

-- Qual professor recebe o menor salario ?
SELECT nome, salario FROM Professor WHERE salario = (SELECT MIN(salario) FROM PROFESSOR);

-- Qual professor recebe o maior salario ?
SELECT nome, salario FROM Professor WHERE salario = (SELECT MAX(salario) FROM PROFESSOR);

-- Quantos Professores existem por cidade ?
SELECT cidade, COUNT(*) AS NumeroDeProfessores FROM Professor GROUP BY cidade ORDER BY NumeroDeProfessores;

-- Quais são as cidades que possuem menos do que 3 professores ?
SELECT cidade, COUNT(*) AS NumeroDeProfessores FROM Professor GROUP BY cidade HAVING COUNT(*) < 3 ORDER BY NumeroDeProfessores;

-- Quais são os professores que possuem a letra inicial do nome igual a C ?
SELECT nome FROM Professor WHERE nome LIKE 'c%';

-- Quais são os professores que possuem a letra inicial do nome igual a C ou E?
SELECT nome FROM Professor WHERE nome LIKE '[ce]%';

-- Possiveis consultas com a tabela curso
SELECT * FROM Curso;

-- Qual o nome e mensalidade do curso com maior mensalidade ?
SELECT nome, mensalidade FROM Curso WHERE mensalidade = (SELECT MAX(Mensalidade) FROM Curso);

-- E a menor mensalidade ? 
SELECT nome, mensalidade FROM Curso WHERE mensalidade = (SELECT MIN(Mensalidade) FROM Curso);

-- Quais são os cursos com duracao de 5 anos ?
SELECT * FROM Curso WHERE duracao = 5;

-- Qual o custo médio de mensalidade em cada área ?
SELECT area, COUNT(*) AS num_cursos, AVG(mensalidade) AS mensalidade_media FROM Curso GROUP BY area ORDER BY mensalidade_media;

-- Qual a mensalidade média ? 
SELECT CONCAT('A mensalidade media eh ', AVG(mensalidade)) AS Resposta FROM Curso;

-- Qual o número de caracteres da frase anterior ?
SELECT LEN(CONCAT('A mensalidade media eh ', AVG(mensalidade))) AS Resposta FROM Curso;

-- Quais são os cursos de cada área ?
SELECT CONCAT('Os cursos da area de ', area, ' sao ', STRING_AGG(nome, ', ')) AS Resposta FROM Curso GROUP BY area;

-- Consultas possíveis na tabela disciplina
SELECT * FROM Disciplina;

-- Qual a disciplina com maior carga horária semanal ?
SELECT * FROM Disciplina WHERE carga = (SELECT MAX(carga) FROM Disciplina); 

-- Consultas associando diferentes tabela ?
SELECT * FROM Oferecimento;

--JOIN
SELECT DISTINCT * FROM Oferecimento AS o 
    INNER JOIN Curso AS c ON o.curso_cod = c.curso_cod 
    INNER JOIN Disciplina AS d ON d.disc_cod = o.disc_cod;

SELECT DISTINCT * FROM Oferecimento AS o 
    INNER JOIN Curso AS c ON o.curso_cod = c.curso_cod 
    INNER JOIN Disciplina AS d ON d.disc_cod = o.disc_cod
    INNER JOIN Professor AS p ON p.prof_cod = o.prof_cod;

SELECT DISTINCT * FROM Oferecimento AS o 
    INNER JOIN Curso AS c ON o.curso_cod = c.curso_cod 
    INNER JOIN Disciplina AS d ON d.disc_cod = o.disc_cod
    INNER JOIN Professor AS p ON p.prof_cod = o.prof_cod;

-- Quais são as disciplinas oferecidas no curso de Ciencia de Computacao ?
SELECT DISTINCT c.nome, d.nome FROM Oferecimento AS o 
    INNER JOIN Curso AS c ON o.curso_cod = c.curso_cod 
    INNER JOIN Disciplina AS d ON d.disc_cod = o.disc_cod
    WHERE c.nome = 'Ciencia da Computacao';

-- Quais são os professores dessas disciplinas ?
SELECT DISTINCT c.nome, d.nome, p.nome FROM Oferecimento AS o 
    INNER JOIN Curso AS c ON o.curso_cod = c.curso_cod 
    INNER JOIN Disciplina AS d ON d.disc_cod = o.disc_cod
    INNER JOIN Professor AS p ON p.prof_cod = o.prof_cod
    WHERE c.nome = 'Ciencia da Computacao';

-- Qual a média salarial dos professores por curso ?

-- Maneira incorreta porem pode ser uma razoável estimativa,
-- desta maneira se um professor leciona mais de uma disciplina
-- o salario dele será contado duas vezes
SELECT DISTINCT c.nome, AVG(p.salario) AS MediaSalario FROM Oferecimento AS o 
    INNER JOIN Curso AS c ON o.curso_cod = c.curso_cod 
    INNER JOIN Disciplina AS d ON d.disc_cod = o.disc_cod
    INNER JOIN Professor AS p ON p.prof_cod = o.prof_cod
    GROUP BY c.nome
    ORDER BY MediaSalario;

-- Maneira correta, desse jeito utilizamos o DISTINCT no subselect e o
-- salario do professor não irá se repetir
SELECT DISTINCT curso_nome, AVG(salario_professor) AS MediaSalario FROM
    (SELECT DISTINCT c.nome AS curso_nome, p.salario AS salario_professor
        FROM Oferecimento AS o 
        INNER JOIN Curso AS c ON o.curso_cod = c.curso_cod 
        INNER JOIN Disciplina AS d ON d.disc_cod = o.disc_cod
        INNER JOIN Professor AS p ON p.prof_cod = o.prof_cod) AS sub 
    GROUP BY curso_nome ORDER BY MediaSalario;

-- Qual o número de professores graduados, especialistas, mestres e doutores em cada curso ?
SELECT DISTINCT c.nome, p.titulo, COUNT(DISTINCT p.prof_cod) FROM Oferecimento AS o 
    INNER JOIN Curso AS c ON o.curso_cod = c.curso_cod 
    INNER JOIN Disciplina AS d ON d.disc_cod = o.disc_cod
    INNER JOIN Professor AS p ON p.prof_cod = o.prof_cod
    GROUP BY c.nome, p.titulo
    ORDER BY c.nome, p.titulo;

-- Quais são as salas de aulas utilizadas em cada curso ?
SELECT c.nome, STRING_AGG(o.sala, ', ') AS salas FROM Oferecimento AS o 
    INNER JOIN Curso AS c ON o.curso_cod = c.curso_cod 
    GROUP BY c.nome;

-- Similar porém sem repetições
SELECT nome, STRING_AGG(sala, ', ') AS salas FROM (
    SELECT DISTINCT c.nome, o.sala FROM Oferecimento AS o 
    INNER JOIN Curso AS c ON o.curso_cod = c.curso_cod
    ) AS cs
    GROUP BY cs.nome ;

-- Quais são os pre-requisitos das disciplinas ?
SELECT d.nome, pr.nome AS pre_requisito FROM Disciplina AS d
    INNER JOIN Disciplina AS pr ON pr.disc_cod = d.pre_req;

-- Quais são as disciplinas oferecidas tanto pelo Prof. Joaquim quanto pelo Prof. Francisco ?
SELECT * FROM Oferecimento AS o
    INNER JOIN Disciplina AS d ON d.disc_cod = o.disc_cod 
    WHERE d.disc_cod IN (
        SELECT in_d.disc_cod FROM Disciplina AS in_d 
            INNER JOIN Oferecimento AS in_o ON in_d.disc_cod = in_o.disc_cod
            INNER JOIN Professor AS p ON in_o.prof_cod = p.prof_cod
            WHERE p.nome LIKE 'Joaquim%'
    )
    AND
    d.disc_cod IN (
        SELECT in_d.disc_cod FROM Disciplina AS in_d 
            INNER JOIN Oferecimento AS in_o ON in_d.disc_cod = in_o.disc_cod
            INNER JOIN Professor AS p ON in_o.prof_cod = p.prof_cod
            WHERE p.nome LIKE 'Francisco%'
    );

-- 


GO
-- Criar uma visao do JOIN
DROP VIEW IF EXISTS oferecimento_view;
GO

CREATE VIEW oferecimento_view AS 
    SELECT o.*, c.area AS area_curso, c.duracao, c.mensalidade, c.nome AS nome_curso, 
           d.area AS area_disc, p.cidade AS cidade_prof, p.salario, p.titulo,
           pr.nome AS pre_requisito
    FROM Oferecimento AS o 
    INNER JOIN Curso AS c ON o.curso_cod = c.curso_cod 
    INNER JOIN Disciplina AS d ON d.disc_cod = o.disc_cod
    INNER JOIN Professor AS p ON p.prof_cod = o.prof_cod
    LEFT JOIN Disciplina AS pr ON pr.disc_cod = d.disc_cod;
GO

-- Consulta na VIEW
SELECT * FROM oferecimento_view;