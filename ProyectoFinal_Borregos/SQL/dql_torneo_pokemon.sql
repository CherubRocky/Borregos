-- 1.- Lista cada venta individual, calculando precio base sin IVA, IVA, precio final con IVA, ganancia neta SBA (75%) y comisión vendedor (25%).

SELECT v.IdVenta, v.TipoPago, v.FechaHora, 
        v.TotalSinIva AS "Precio sin Iva",
        (calcular_iva_venta(v.TotalSinIva) - v.TotalSinIva) AS "IVA",
        calcular_iva_venta(v.TotalSinIva) AS "Precio con IVA",
        (v.TotalSinIva * 0.75) AS "Ganancia neta SBA",
        (v.TotalSinIva * 0.25) AS "Comision para vendedor" 
FROM Venta v;

-- 2.- Listar Nombre Vendedor, Nombre Alimento, FechaCaducidad, Precio con Iva del alimento y Cantidad de vendidos de ese alimento. Ordenado de mayor a menor.

SELECT per.Nombre, per.Paterno, per.Materno, ali.Nombre AS Alimento, 
        ali.FechaCaducidad, 
        calcular_iva_venta(ali.PrecioSinIVA) AS "Precio con IVA",
        COUNT(v.IdPersonaV) AS CantidadVendidos
FROM Alimento ali JOIN Registrar r ON ali.IdAlimento = r.IdAlimento
            JOIN Venta v ON r.IdVenta = v.IdVenta
            JOIN Vendedor ven ON v.IdPersonaV = ven.IdPersona
            JOIN Empleado emp ON ven.IdPersona = emp.IdPersona
            JOIN Persona per ON emp.IdPersona = per.IdPersona
GROUP BY ali.IdAlimento, ali.Nombre, ali.FechaCaducidad, ali.PrecioSinIVA,
        per.IdPersona, per.Nombre, per.Paterno, per.Materno
ORDER BY CantidadVendidos DESC;

-- 3.- Listar alimentos perecederos ordenados por ventas, con una columna que indique si su estado es Crítico si la fecha de caducidad es el día del evento.

SELECT ali.Nombre AS Alimento, ali.FechaCaducidad, 
        COUNT(reg.IdAlimento) AS Vendidos,
        CASE
            WHEN ali.FechaCaducidad IN (SELECT FechaEvento FROM EdicionTorneo) THEN 'Crítico'
            ELSE 'Bien'
        END AS Estado
FROM Alimento ali LEFT JOIN Registrar reg ON ali.IdAlimento = reg.IdAlimento
WHERE ali.Perecedero = TRUE
GROUP BY ali.IdAlimento, ali.Nombre, ali.FechaCaducidad
ORDER BY Vendidos ASC;

-- 4.- Listar el nombre completo, edad, sexo y fecha de nacimiento de las personas que hayan hecho al menos 2 compras con un monto total mayor a $150 pesos cada una.

SELECT per.Nombre, per.Paterno, per.Materno, 
        (calcular_edad_persona(per.FechaNacimiento)) AS Edad, per.Sexo,
        per.FechaNacimiento
FROM Persona per JOIN Venta v ON per.IdPersona = v.IdPersona
WHERE calcular_iva_venta(v.TotalSinIva) > 150::money
GROUP BY per.IdPersona, per.Nombre, per.Paterno, per.Materno,
        per.FechaNacimiento, per.Sexo
HAVING COUNT(v.IdVenta) >= 2;

-- 5.- Listar a todos los participantes de peleas. Con columnas que indiquen Total Peleas, Victorias, Derrotas y % Efectividad, ordenado por efectividad de mayor a menor.

SELECT per.Nombre, per.Paterno, per.Materno, par.Facultad,
        COUNT(DISTINCT pelr.IdPelea) AS TotalPeleas,
        COUNT(DISTINCT pe.IdPelea) AS Victorias,
        (COUNT(DISTINCT pelr.IdPelea) - COUNT(DISTINCT pe.IdPelea)) AS Derrotas,
        ROUND((COUNT(DISTINCT pe.IdPelea) * 100.0) / NULLIF(COUNT(DISTINCT pelr.IdPelea), 0), 2) AS "Porcentaje Efectividad"
FROM Persona per JOIN Participante par ON per.IdPersona = par.IdPersona
            JOIN Pelear pelr ON par.IdPersona = pelr.IdPersona
            LEFT JOIN Pelea pe ON par.IdPersona = pe.IdParticipante
GROUP BY per.IdPersona, per.Nombre, per.Paterno, per.Materno, par.Facultad
ORDER BY "Porcentaje Efectividad" DESC;

-- 6.- Listar las especies de Pokémon. Con columnas que indiquen: Cantidad de cada especie registrada, Promedio de CP, Peso Promedio, ordenado por Especie.

SELECT po.Especie,
        COUNT(po.IdPokemon) AS CantidadRegistrada,
        ROUND(AVG(po.CombatPoints), 2) AS "Promedio de CombatPoints",
        ROUND(AVG(po.Peso), 2) AS "Peso Promedio"
FROM Pokemon po
GROUP BY po.Especie
ORDER BY po.Especie;

-- 7.- Listar a todos los espectadores que ingresaron al evento, calculando cuántas horas permanecieron dentro. Solamente aquellos que se quedaron más de 4 horas.

SELECT esp.Nombre, esp.Paterno, esp.Materno,
        (calcular_edad_espectador(esp.FechaNacimiento)) AS Edad, esp.Genero,
        (esp.HoraSalida - esp.HoraIngreso) AS "Horas Permanecidas"
FROM Espectador esp
WHERE (EXTRACT (HOUR FROM (esp.HoraSalida - esp.HoraIngreso))) > 4;

-- 8.- Mostrar cuántos miembros de Sabiduría, Instinto y Valor hay por cada Facultad y carrera

SELECT par.Facultad, par.Carrera, c.Equipo,
        COUNT(par.IdPersona) AS "Cantidad de Miembros"
FROM Participante par JOIN Cuenta c ON par.IdPersona = c.IdPersona
GROUP BY par.Facultad, par.Carrera, c.Equipo
ORDER BY par.Facultad, par.Carrera, c.Equipo;

-- 9.- Calcular la edad exacta en años, meses y días de todos los participantes y espectadores registrados, clasificándolos por "Generación Z" o "Millennial" según su año de nacimiento, ordenado del más joven al más viejo.

SELECT per.Nombre, per.Paterno, per.Materno, per.FechaNacimiento,
        (calcular_edad_persona(per.FechaNacimiento)) AS "Edad en Años",
        (EXTRACT(MONTH FROM AGE(per.FechaNacimiento))) AS "Meses",
        (EXTRACT(DAY FROM AGE(per.FechaNacimiento))) AS "Días",
        CASE
            WHEN EXTRACT(YEAR FROM per.FechaNacimiento) BETWEEN 1981 AND 1996 THEN 'Millennial'
            WHEN EXTRACT(YEAR FROM per.FechaNacimiento) BETWEEN 1997 AND 2010 THEN 'Generación Z'
            ELSE 'Otra Generación'
        END AS Generacion,
        'Participante' AS Tipo
FROM Persona per JOIN Participante par ON per.IdPersona = par.IdPersona
UNION
SELECT esp.Nombre, esp.Paterno, esp.Materno, esp.FechaNacimiento,
        (calcular_edad_espectador(esp.FechaNacimiento)) AS "Edad en Años",
        (EXTRACT(MONTH FROM AGE(esp.FechaNacimiento))) AS "Meses",
        (EXTRACT(DAY FROM AGE(esp.FechaNacimiento))) AS "Días",
        CASE
            WHEN EXTRACT(YEAR FROM esp.FechaNacimiento) BETWEEN 1981 AND 1996 THEN 'Millennial'
            WHEN EXTRACT(YEAR FROM esp.FechaNacimiento) BETWEEN 1997 AND 2010 THEN 'Generación Z'
            ELSE 'Otra Generación'
        END AS Generacion,
        'Espectador' AS Tipo
FROM Espectador esp
ORDER BY "Edad en Años" ASC, "Meses" ASC, "Días" ASC;

-- 10.- Calcular el nivel promedio de los participantes agrupado por Facultad y Carrera.

SELECT par.Facultad, par.Carrera,
        ROUND(AVG(c.Nivel), 2) AS "Nivel Promedio"
FROM Participante par JOIN Cuenta c ON par.IdPersona = c.IdPersona
GROUP BY par.Facultad, par.Carrera
ORDER BY par.Facultad, par.Carrera;

-- 11.- Mostrar a todos los participantes del torneo de distancia, con columnas calculadas que muestren "Llegó a Rectoría: SÍ/NO", "Llegó a Universum: SÍ/NO" y "Llegó a entrada de CU: SÍ/NO".

SELECT per.Nombre, per.Paterno, per.Materno, par.NoCuenta, par.Facultad, par.Carrera,
        MAX(CASE
            WHEN LOWER(rec.Ubicacion) = 'rectoría' THEN 'SÍ'
            ELSE 'NO'
        END) AS "Llegó a Rectoría",
        MAX(CASE
            WHEN LOWER(rec.Ubicacion) = 'universum' THEN 'SÍ'
            ELSE 'NO'
        END) AS "Llegó a Universum",
        MAX(CASE
            WHEN LOWER(rec.Ubicacion) = 'cu' THEN 'SÍ'
            ELSE 'NO'
        END) AS "Llegó a entrada de CU"
FROM Persona per JOIN Participante par ON per.IdPersona = par.IdPersona
            LEFT JOIN Recorrer rec ON par.IdPersona = rec.IdPersona
WHERE per.IdPersona IN (SELECT IdPersona FROM Participar) AND (rec.IdTorneo IN (SELECT IdTorneo FROM Recorrido) OR rec.IdTorneo IS NULL)
GROUP BY per.IdPersona, per.Nombre, per.Paterno, per.Materno, par.NoCuenta, par.Facultad, par.Carrera;

-- 12.- Listar el nombre completo, edad, fecha de nacimiento, sexo y ciudad de los trabajadores que su codigo postal empiece con 4 pero que no sean Encargados.

SELECT per.Nombre, per.Paterno, per.Materno,
        (calcular_edad_persona(per.FechaNacimiento)) AS Edad,
        per.FechaNacimiento, per.Sexo, emp.Ciudad, emp.CP
FROM Persona per JOIN Empleado emp ON per.IdPersona = emp.IdPersona
WHERE CAST(emp.CP AS TEXT) LIKE '4%' AND emp.IdPersona NOT IN (SELECT IdPersona FROM Encargado);

-- 13.- Calcular cuántos Pokémons registró cada participante para el torneo de peleas por cada una de las ediciones.

SELECT per.IdPersona AS Participante,
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

-- 14.- Listar los Pokémones shinys, que fueron capturados durante el evento, únicamente si fueron capturados entre las 14:00hrs y las 18:00hrs.

SELECT * FROM Pokemon INNER JOIN Capturar ON Pokemon.IdPokemon = Capturar.IdPokemon
WHERE Pokemon.Shiny = TRUE AND CAST(Capturar.FechaYHora as TIME) BETWEEN '14:00:00' AND '18:00:00';

-- 15.- Obtener la lista de participantes que estén inscritos en el Torneo de Captura de Shiny y a su vez que no estén inscritos en el torneo de distancia recorrida.
SELECT DISTINCT pa.IdPersona, per.Nombre, per.Paterno, per.Materno
FROM Participar pa
            INNER JOIN Persona per ON pa.IdPersona = per.IdPersona
            INNER JOIN CapturaShiny cs ON pa.IdTorneo = cs.IdTorneo
WHERE pa.IdPersona NOT IN ( SELECT pa2.IdPersona FROM Participar pa2 
            INNER JOIN Recorrido r ON pa2.IdTorneo = r.IdTorneo);