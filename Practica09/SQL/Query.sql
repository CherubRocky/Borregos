
-- Consulta 1
-- Consulta 2
-- Consulta 3
-- Consulta 4
-- Consulta 5
SELECT Participante.IdPersona, Persona.Nombre, Participante.NoCuenta, SUM(Recorrer.Distancia) AS DistanciaTotal FROM Recorrer 
INNER JOIN Participante ON Recorrer.IdPersona = Participante.IdPersona
INNER JOIN Persona ON Participante.IdPersona = Persona.IdPersona
GROUP BY Participante.IdPersona, Persona.Nombre, Participante.NoCuenta;

-- Consulta 6
SELECT * FROM Pokemon INNER JOIN Capturar ON Pokemon.IdPokemon = Capturar.IdPokemon
WHERE Pokemon.Shiny = TRUE AND EXTRACT(HOUR FROM Capturar.FechaYHora) BETWEEN 14 AND 18;

-- Consulta 7
-- Consulta 8
-- Consulta 9
-- Consulta 10