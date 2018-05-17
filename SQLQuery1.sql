
CREATE DATABASE MeuDB;
GO

USE MeuDB;
GO

-- Cria tabela curso
DROP TABLE IF EXISTS Oferecimento;
DROP TABLE IF EXISTS Curso;
DROP TABLE IF EXISTS Disciplina;
DROP TABLE IF EXISTS Professor;
GO

CREATE TABLE Curso (curso_cod INT IDENTITY PRIMARY KEY,
                    nome VARCHAR(50),
                    duracao INT,
                    mensalidade REAL,
                    area CHAR(10), 
                    CHECK (area IN ('Exatas', 'Biologicas', 'Humanas')));

-- Cria tabela disciplina
CREATE TABLE Disciplina (disc_cod INT PRIMARY KEY,
                         nome VARCHAR(50),
                         carga INT,
                         area CHAR(10) ,
                         pre_req INT FOREIGN KEY REFERENCES Disciplina(disc_cod),
                         CHECK (area IN ('Exatas', 'Biologicas', 'Humanas')));

-- cria tabela professor

CREATE TABLE Professor (prof_cod INT IDENTITY PRIMARY KEY,
                        nome VARCHAR(100),
                        cidade VARCHAR(100),
                        titulo CHAR(20),
                        salario REAL);

-- cria tabela oferecimento
CREATE TABLE Oferecimento (curso_cod INT FOREIGN KEY REFERENCES Curso(curso_cod),
                           disc_cod INT FOREIGN KEY REFERENCES Disciplina(disc_cod),
                           prof_cod INT FOREIGN KEY REFERENCES Professor(prof_cod),
                           sala VARCHAR(10),
                           PRIMARY KEY (curso_cod, disc_cod, prof_cod));


-- Insere na tabela curso
INSERT INTO Curso VALUES 
    ('Enfermagem', 4, 700.50, 'Biologicas'),
    ('Eng. Mecanica', 5, 1500.0, 'Exatas'),
    ('Ciencia da Computacao', 4, 1200.0, 'Exatas'),
    ('Eng. Eletrica', 5, 1700.0, 'Exatas'),
    ('Turismo', 4, 500.0, 'Humanas'),
    ('Sociologia', 4, 910.70, 'Humanas'),
    ('Ciencias Biomedicas', 4, 1000.0, 'Biologicas'),
    ('Farmacia e Bioquimica', 5, 1107.0, 'Biologicas');

--Insere na table disciplina
INSERT INTO Disciplina VALUES
    (1, 'Praticas de enfermagem I', 2, 'Biologicas', NULL),
    (2, 'Bioquimica', 2, 'Biologicas', NULL),
    (3, 'Biologia Molecular', 4, 'Biologicas', 2),
    (4, 'Imunologia', 4, 'Biologicas', 3),
    (5, 'Calculo Dif. e Int. I', 4, 'Exatas', NULL),
    (6, 'Calculo Dif. e Int. II', 4, 'Exatas', 5),
    (7, 'Geometria e Algebra Linear', 4, 'Exatas', NULL),
    (8, 'Calculo Dif. e Int. III', 4, 'Exatas', 6),
    (9, 'Sinais e Sistemas', 4, 'Exatas', 8),
    (10, 'Programacao Orientada a Objetos', 4, 'Exatas', NULL),
    (11, 'Sistemas Operacionais', 4, 'Exatas', 10),
    (12, 'Historia do Brasil', 1, 'Humanas', NULL),
    (13, 'Anatomia Humana', 4, 'Biologicas', NULL),
    (14, 'Fisiologia Humana', 4, 'Biologicas', 13),
    (15, 'Patologia', 4, 'Biologicas', 14),
    (16, 'Quimica Inorgonica', 4, 'Exatas', NULL),
    (17, 'Quimica Organica', 4, 'Exatas', NULL);

-- Insere na tabela professor
INSERT INTO Professor VALUES
    ('Luis Gustavo Pereira', 'Osasco', 'Graduado', 2000.0), -- bio 1
    ('Joaquim Barbosa Ferreira', 'Osasco', 'Doutor', 7000.0),
    ('Flavia Oliveira', 'Osasco', 'Especialista', 2100.0), -- bio 3 
    ('Francisco Muller', 'Osasco', 'Especialista', 2250.0),
    ('Luis Estevao Costa', 'Diadema', 'Especialista', 2061.0),
    ('Felipe Silva', 'Sao Paulo', 'Mestre', 2400.0),
    ('Claudio Souza', 'Sao Paulo', 'Mestre', 2310.0), -- hum
    ('Everton Carvalho', 'Sao Paulo', 'Doutor', 6115.5),
    ('Henrique Cavalcante', 'Sao Paulo', 'Mestre', 1195.5), --bio 9
    ('Cesar Gomes Paula', 'Sao Paulo', 'Doutor', 11500.7),
    ('Lucas Garcia', 'Sao Bernardo', 'Mestre', 5015.0);

-- Insere na tabela oferecimento
INSERT INTO Oferecimento (curso_cod, disc_cod, prof_cod, sala) VALUES
    (8, 15, 9, '210B'),
    (7, 2, 3, '202B'),
    (7, 3, 1, '200A'),
    (7, 15, 9, '210B'),
    (6, 12, 7, 'S1.1'),
    (5, 12, 7, 'S1.2'),
    (4, 9, 8, '301A'),
    (3, 5, 2, '304'),
    (3, 5, 4, '310C'),
    (3, 6, 5, '304'),
    (3, 7, 10, '301'),
    (3, 10, 10, '310A'),
    (3, 11, 10, '310A'),
    (1, 1, 3, '201C'),
    (1, 2, 3, '202B'),
    (1, 3, 1, '200A'),
    (1, 15, 9, '210B'),
    (2, 5, 2, '304'),
    (2, 5, 4, '310C'),
    (2, 6, 5, '304'),
    (2, 7, 10, '301'),
    (2, 8, 10, '310A');
GO
 