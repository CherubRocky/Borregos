
-- Consulta 1
-- Consulta 2
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
-- Consulta 10