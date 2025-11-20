
-- Consulta 1
SELECT Nombre, Paterno, Materno, CodigoEntrenador, NombreUsuario, Nivel, Equipo FROM
Persona INNER JOIN Participante ON Persona.IdPersona = Participante.IdPersona
INNER JOIN Cuenta ON Participante.IdPersona = Cuenta.IdPersona;
-- Consulta 2
SELECT 
    per.IdPersona AS Participante,
    per.Nombre || ' ' || per.Paterno || ' ' || per.Materno AS Participante,
    et.NumeroEdicion AS Edicion,
    et.FechaEvento,
    COUNT(DISTINCT pok.IdPokemon) AS Total_Pokemons_Registrados
FROM Participante part
JOIN Persona per ON part.IdPersona = per.IdPersona
JOIN Cuenta c ON c.IdPersona = part.IdPersona
JOIN Pokemon pok ON pok.CodigoEntrenador = c.CodigoEntrenador
JOIN Pelear pel ON pel.IdPersona = part.IdPersona
JOIN Pelea pea ON pea.IdPelea = pel.IdPelea
JOIN Torneo t ON t.IdTorneo = pea.IdTorneo
JOIN EdicionTorneo et ON et.IdEdicion = t.IdEdicion
GROUP BY per.IdPersona, per.Nombre, per.Paterno, per.Materno, et.IdEdicion, et.NumeroEdicion, et.FechaEvento
ORDER BY et.NumeroEdicion, Total_Pokemons_Registrados DESC;

-- Consulta 3
SELECT *
FROM Pokemon
WHERE especie LIKE '%chu%';

-- Consulta 4
SELECT DISTINCT pa.IdPersona, per.Nombre, per.Paterno, per.Materno
FROM Participar pa
INNER JOIN Persona per ON pa.IdPersona = per.IdPersona
INNER JOIN CapturaShiny cs ON pa.IdTorneo = cs.IdTorneo
WHERE pa.IdPersona NOT IN ( SELECT pa2.IdPersona FROM Participar pa2 INNER JOIN Recorrido r ON pa2.IdTorneo = r.IdTorneo
);

-- Consulta 5
SELECT Participante.IdPersona, Persona.Nombre, Participante.NoCuenta, SUM(Recorrer.Distancia) AS DistanciaTotal FROM Recorrer 
INNER JOIN Participante ON Recorrer.IdPersona = Participante.IdPersona
INNER JOIN Persona ON Participante.IdPersona = Persona.IdPersona
GROUP BY Participante.IdPersona, Persona.Nombre, Participante.NoCuenta;

-- Consulta 6
SELECT * FROM Pokemon INNER JOIN Capturar ON Pokemon.IdPokemon = Capturar.IdPokemon
WHERE Pokemon.Shiny = TRUE AND CAST(Capturar.FechaYHora as TIME) BETWEEN '14:00:00' AND '18:00:00';

-- Consulta 7
SELECT per.Nombre, per.Paterno, per.Materno, v.IdPersona AS IdVendedor, a.IdAlimento, a.Nombre AS NombreAlimento, a.PrecioSinIVA AS PrecioSinIVA, (a.PrecioSinIVA * 1.16) AS PrecioConIVA
FROM Vendedor v INNER JOIN Empleado e ON v.IdPersona = e.IdPersona
INNER JOIN Persona per ON e.IdPersona = per.IdPersona
INNER JOIN Participante pa ON per.IdPersona = pa.IdPersona
INNER JOIN Venta ve ON pa.IdPersona = ve.IdPersonaV
INNER JOIN Registrar r ON ve.IdVenta = r.IdVenta
INNER JOIN Alimento a ON r.IdAlimento = a.IdAlimento
ORDER BY per.Paterno, per.Nombre, a.Nombre;

-- Consulta 8
SELECT 
    Facultad, 
    COUNT(DISTINCT Participar.IdPersona) AS TotalParticipantes
FROM 
    Participar
JOIN 
    Participante ON Participar.IdPersona = Participante.IdPersona
GROUP BY 
    Facultad
HAVING 
    COUNT(DISTINCT Participar.IdPersona) > 5;

-- Consulta 9
SELECT
    e.IdEmpleado,
    per.Nombre || ' ' || per.Paterno || ' ' || per.Materno AS NombreCompleto,
    v.Ubicacion,
    COUNT(DISTINCT a.IdAlimento) AS Total_Alimentos_Distintos
FROM Vendedor v
JOIN Empleado e ON v.IdPersona = e.IdPersona
JOIN Persona per ON e.IdPersona = per.IdPersona
JOIN Venta ven ON ven.IdPersonaV = v.IdPersona
JOIN Registrar r ON r.IdVenta = ven.IdVenta
JOIN Alimento a ON a.IdAlimento = r.IdAlimento
GROUP BY e.IdEmpleado, per.IdPersona, per.Nombre, per.Paterno, per.Materno, v.Ubicacion
HAVING COUNT(DISTINCT a.IdAlimento) > 3
ORDER BY Total_Alimentos_Distintos DESC;

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
