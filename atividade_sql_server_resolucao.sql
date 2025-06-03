-- Desafio Montando Consultas Relacionais no SQL Server - DIO

/*
Este desafio foca apresentar uma série de consultas realizadas no DB Filmes apresentado na descrição dele. 

*/

-- 1 - Buscar o nome e ano dos filmes
GO
SELECT Nome, Ano FROM Filmes
GO

-- 2 - Buscar o nome e ano dos filmes, ordenados por ordem crescente pelo ano 
-- obs: está consfuso pelo fato de que na imagem de exemplo a coluna Duracao aparece também, mas a descrição não comenta nada.
GO
SELECT Nome, Ano FROM Filmes ORDER BY Ano ASC
GO

-- 3 - Buscar pelo filme de volta para o futuro, trazendo o nome, ano e a duração
GO
SELECT Nome, Ano, Duracao FROM Filmes WHERE Nome = 'De Volta para o Futuro'
GO

-- 4 - Buscar os filmes lançados em 1997
GO
SELECT Nome, Ano, Duracao FROM Filmes WHERE Ano = 1997
GO

-- 5 - Buscar os filmes lançados APÓS o ano 2000
GO
SELECT Nome, Ano, Duracao FROM Filmes WHERE Ano > 2000 
GO

-- 6 - Buscar os filmes com a duracao maior que 100 e menor que 150, ordenando pela duracao em ordem crescente
GO
SELECT Nome, Ano, Duracao FROM Filmes 
WHERE Duracao BETWEEN 101 AND 149
ORDER BY Duracao ASC
GO

-- 7 - Buscar a quantidade de filmes lançadas no ano, agrupando por ano, ordenando pela duracao em ordem decrescente
-- *Essa questão está mal estruturada, pois apresenta 2 idéias diferentes (contagem de anos e ordernar por Duracao), algo inviável para essa situação.
-- *Vou seguir se acordo com a imagem mostrada como exemplo.
-- *Contar quantos filmes cada ano possui ordenando o resultado pela quantidade de modo decrescente  
GO
SELECT Ano, COUNT(*) AS "Quantidade"
FROM Filmes 
GROUP BY Ano
ORDER BY "Quantidade" DESC
GO


-- 8 Buscar os Atores do gênero masculino, retornando o PrimeiroNome, UltimoNome
GO
SELECT PrimeiroNome, UltimoNome, Genero FROM Atores WHERE Genero = 'M'
GO

-- 9 Buscar os Atores do gênero feminino, retornando o PrimeiroNome, UltimoNome, e ordenando pelo PrimeiroNome
GO
SELECT PrimeiroNome, UltimoNome, Genero FROM Atores WHERE Genero = 'F' ORDER BY PrimeiroNome;
GO

-- 10 - Buscar o nome do filme e o gênero
-- Como o desafio 11 também vai usar a mesma consulta só que com a diferença de que será apenas os filmes do tipo "Mistério",
-- Eu vou criar uma view para diminuir a quantidade de queries.
GO
CREATE VIEW vw_Filmes_Genero AS
SELECT F.Nome, G.Genero FROM Filmes F
INNER JOIN FilmesGenero FG ON FG.IdFilme = F.Id
INNER JOIN Generos G ON G.Id = FG.IdGenero;
GO

GO
SELECT * FROM vw_Filmes_Genero;
GO

-- 11 - Buscar o nome do filme e o gênero do tipo "Mistério"
GO
SELECT * FROM vw_Filmes_Genero WHERE Genero = 'Mistério';
GO

-- 12 - Buscar o nome do filme e os atores, trazendo o PrimeiroNome, UltimoNome e seu Papel
-- Vendo a imagem, percebi que a tabela Nome junto com PrimeiroNome e UltimoNome pode ser confuso para análise
-- Então vou nomear para NomeFilme para separar melhor.
GO
SELECT F.Nome as 'NomeFilme', A.PrimeiroNome, A.UltimoNome, EF.Papel
FROM Atores A 
INNER JOIN ElencoFilme EF ON A.Id = EF.IdAtor
INNER JOIN Filmes F ON F.Id = EF.IdFilme
GO