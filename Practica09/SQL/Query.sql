
-- Consulta 1
SELECT Nombre, Paterno, Materno, CodigoEntrenador, NombreUsuario, Nivel, Equipo FROM
Persona INNER JOIN Participante ON Persona.IdPersona = Participante.IdPersona
INNER JOIN Cuenta ON Participante.IdPersona = Cuenta.IdPersona;
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
WITH
DistTotal AS (
   SELECT IdPersona, SUM(Distancia) AS DistanciaTotal
   FROM Recorrer
   GROUP BY IdPersona
),
PromDistancia AS (
   SELECT
       AVG(DistanciaTotal) AS Promedio
   FROM DistTotal
),
TotalCapturados AS (
   SELECT
       IdPersona,
       COUNT(IdPersona) AS Capturados
       FROM Capturar INNER JOIN Pokemon ON Capturar.IdPokemon = Pokemon.IdPokemon
       WHERE Shiny = true
       GROUP BY IdPersona
)

SELECT Nombre, Paterno, Materno, Facultad
FROM Persona INNER JOIN Participante ON Persona.IdPersona = Participante.IdPersona
INNER JOIN TotalCapturados ON TotalCapturados.IdPersona = Participante.IdPersona
INNER JOIN DistTotal ON DistTotal.IdPersona = Participante.IdPersona
WHERE TotalCapturados.Capturados > 5 AND DistTotal.DistanciaTotal > (SELECT Promedio FROM PromDistancia);
