-- Equipo Borregos
-- Creación del esquema
DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;
SET search_path TO public;

----------------- CREACIÓN DE TABLAS CON LLAVES PRIMARIAS -----------------

-- Espectador
CREATE TABLE Espectador (
    IdEspectador    BIGINT,
    Nombre          VARCHAR(50),
    Paterno         VARCHAR(50),
    Materno         VARCHAR(50),
    FechaNacimiento DATE,
    Genero          CHAR(1),
    HoraIngreso     TIME,
    HoraSalida      TIME
);

-- Restricciones Espectador (Dominio)
ALTER TABLE Espectador ADD CONSTRAINT espectador_d1 CHECK (Nombre <> '');
ALTER TABLE Espectador ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Espectador ADD CONSTRAINT espectador_d2 CHECK (Paterno <> '');
ALTER TABLE Espectador ALTER COLUMN Paterno SET NOT NULL;
ALTER TABLE Espectador ADD CONSTRAINT espectador_d3 CHECK (Materno <> '');
ALTER TABLE Espectador ALTER COLUMN FechaNacimiento SET NOT NULL;
ALTER TABLE Espectador ADD CONSTRAINT espectador_d4 CHECK (FechaNacimiento <= CURRENT_DATE);
ALTER TABLE Espectador ALTER COLUMN Genero SET NOT NULL;
ALTER TABLE Espectador ADD CONSTRAINT espectador_d5 CHECK (Genero = 'M' OR Genero = 'F');
ALTER TABLE Espectador ALTER COLUMN HoraIngreso SET NOT NULL;
ALTER TABLE Espectador ADD CONSTRAINT espectador_d6 CHECK (HoraIngreso BETWEEN '09:00:00' AND '19:00:00');
ALTER TABLE Espectador ALTER COLUMN HoraSalida SET NOT NULL;
ALTER TABLE Espectador ADD CONSTRAINT espectador_d7 CHECK (HoraSalida BETWEEN HoraIngreso AND '21:00:00');

-- Entidad
ALTER TABLE Espectador ADD CONSTRAINT espectador_pkey PRIMARY KEY (IdEspectador);


-- Tabla
COMMENT ON TABLE Espectador IS
'Tabla de espectadores con datos personales y horarios de acceso.';

-- Columnas
COMMENT ON COLUMN Espectador.IdEspectador IS
'Identificador único del espectador (BIGINT, PK).';

COMMENT ON COLUMN Espectador.Nombre IS
'Nombre(s) del espectador; obligatorio y no puede ser cadena vacía.';

COMMENT ON COLUMN Espectador.Paterno IS
'Apellido paterno; obligatorio y no puede ser cadena vacía.';

COMMENT ON COLUMN Espectador.Materno IS
'Apellido materno; si se registra, no puede ser cadena vacía.';

COMMENT ON COLUMN Espectador.FechaNacimiento IS
'Fecha de nacimiento; no puede ser futura.';

COMMENT ON COLUMN Espectador.Genero IS
'Género del espectador: ''M'' o ''F''.';

COMMENT ON COLUMN Espectador.HoraIngreso IS
'Hora de ingreso; debe estar entre 09:00:00 y 19:00:00.';

COMMENT ON COLUMN Espectador.HoraSalida IS
'Hora de salida; debe ser >= HoraIngreso y <= 21:00:00.';

-- Constraints (integridad)
COMMENT ON CONSTRAINT espectador_d1 ON Espectador IS
'CHECK: asegura que Nombre <> ''''.';

COMMENT ON CONSTRAINT espectador_d2 ON Espectador IS
'CHECK: asegura que Paterno <> ''''.';

COMMENT ON CONSTRAINT espectador_d3 ON Espectador IS
'CHECK: asegura que Materno <> ''''.';

COMMENT ON CONSTRAINT espectador_d4 ON Espectador IS
'CHECK: FechaNacimiento <= CURRENT_DATE (no fechas futuras).';

COMMENT ON CONSTRAINT espectador_d5 ON Espectador IS
'CHECK: Genero ∈ {''M'', ''F''}.';

COMMENT ON CONSTRAINT espectador_d6 ON Espectador IS
'CHECK: HoraIngreso entre 09:00:00 y 19:00:00.';

COMMENT ON CONSTRAINT espectador_d7 ON Espectador IS
'CHECK: HoraSalida BETWEEN HoraIngreso AND 21:00:00.';

COMMENT ON CONSTRAINT espectador_pkey ON Espectador IS
'Llave primaria de Espectador (IdEspectador).';





-- Persona
CREATE TABLE Persona (
    IdPersona       BIGINT,
    Nombre          VARCHAR(50),
    Paterno         VARCHAR(50),
    Materno         VARCHAR(50),
    FechaNacimiento DATE,
    Sexo            CHAR(1)
);

-- Restricciones Persona (Dominio)
ALTER TABLE Persona ADD CONSTRAINT persona_d1 CHECK (Nombre <> '');
ALTER TABLE Persona ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Persona ADD CONSTRAINT persona_d2 CHECK (Paterno <> '');
ALTER TABLE Persona ALTER COLUMN Paterno SET NOT NULL;
ALTER TABLE Persona ADD CONSTRAINT persona_d3 CHECK (Materno <> '');
ALTER TABLE Persona ALTER COLUMN FechaNacimiento SET NOT NULL;
ALTER TABLE Persona ADD CONSTRAINT persona_d4 CHECK (FechaNacimiento <= CURRENT_DATE);
ALTER TABLE Persona ALTER COLUMN Sexo SET NOT NULL;
ALTER TABLE Persona ADD CONSTRAINT persona_d5 CHECK (Sexo = 'M' OR Sexo = 'F');

-- Entidad
ALTER TABLE Persona ADD CONSTRAINT persona_pkey PRIMARY KEY (IdPersona);


-- Tabla
COMMENT ON TABLE Persona IS
'Tabla de personas con datos básicos y fecha de nacimiento.';

-- Columnas
COMMENT ON COLUMN Persona.IdPersona IS
'Identificador único de la persona (BIGINT, PK).';

COMMENT ON COLUMN Persona.Nombre IS
'Nombre(s) de la persona; obligatorio y no puede ser cadena vacía.';

COMMENT ON COLUMN Persona.Paterno IS
'Apellido paterno; obligatorio y no puede ser cadena vacía.';

COMMENT ON COLUMN Persona.Materno IS
'Apellido materno; si se registra, no puede ser cadena vacía.';

COMMENT ON COLUMN Persona.FechaNacimiento IS
'Fecha de nacimiento; no puede ser futura.';

COMMENT ON COLUMN Persona.Sexo IS
'Sexo de la persona: ''M'' o ''F''; obligatorio.';

-- Constraints (integridad)
COMMENT ON CONSTRAINT persona_d1 ON Persona IS
'CHECK: asegura que Nombre <> ''''.';

COMMENT ON CONSTRAINT persona_d2 ON Persona IS
'CHECK: asegura que Paterno <> ''''.';

COMMENT ON CONSTRAINT persona_d3 ON Persona IS
'CHECK: asegura que Materno <> ''''.';

COMMENT ON CONSTRAINT persona_d4 ON Persona IS
'CHECK: FechaNacimiento <= CURRENT_DATE (no fechas futuras).';

COMMENT ON CONSTRAINT persona_d5 ON Persona IS
'CHECK: Sexo ∈ {''M'', ''F''}.';

COMMENT ON CONSTRAINT persona_pkey ON Persona IS
'Llave primaria de Persona (IdPersona).';





-- Alimento
CREATE TABLE Alimento (
    IdAlimento    BIGINT,
    Nombre        VARCHAR(100),
    FechaCaducidad DATE,
    Perecedero    BOOLEAN,
    PrecioSinIVA  MONEY
);

-- Restricciones Alimento
ALTER TABLE Alimento ADD CONSTRAINT alimento_d1 CHECK (Nombre <> '');
ALTER TABLE Alimento ADD CONSTRAINT alimento_d6
  CHECK ((Perecedero = TRUE  AND FechaCaducidad > CURRENT_DATE) OR
         (Perecedero = FALSE));
ALTER TABLE Alimento ADD CONSTRAINT alimento_d3 CHECK (PrecioSinIVA > 0::money);

-- Entidad
ALTER TABLE Alimento ADD CONSTRAINT alimento_pkey PRIMARY KEY (IdAlimento);


-- Tabla
COMMENT ON TABLE Alimento IS
'Catálogo de alimentos con caducidad, perecibilidad y precio sin IVA.';

-- Columnas
COMMENT ON COLUMN Alimento.IdAlimento IS
'Identificador único del alimento (BIGINT, PK).';

COMMENT ON COLUMN Alimento.Nombre IS
'Nombre del alimento; si se registra, no puede ser la cadena vacía.';

COMMENT ON COLUMN Alimento.FechaCaducidad IS
'Fecha de caducidad; requerida solo cuando Perecedero = TRUE y debe ser > CURRENT_DATE.';

COMMENT ON COLUMN Alimento.Perecedero IS
'Indicador de estado "perecedero" (TRUE/FALSE); si es TRUE, se exige FechaCaducidad > CURRENT_DATE.';

COMMENT ON COLUMN Alimento.PrecioSinIVA IS
'Precio mayor a 0 en tipo MONEY (importe sin IVA).';

-- Constraints (integridad)
COMMENT ON CONSTRAINT alimento_d1 ON Alimento IS
'CHECK: asegura que Nombre <> '''' (no permite cadena vacía).';

COMMENT ON CONSTRAINT alimento_d6 ON Alimento IS
'CHECK: si Perecedero = TRUE entonces FechaCaducidad > CURRENT_DATE; '
'permite Perecedero = FALSE sin fecha; además evita Perecedero NULL por lógica de la condición.';

COMMENT ON CONSTRAINT alimento_d3 ON Alimento IS
'CHECK: PrecioSinIVA debe ser estrictamente mayor que 0 (MONEY).';

COMMENT ON CONSTRAINT alimento_pkey ON Alimento IS
'Llave primaria de Alimento (IdAlimento).';





-- Cuenta
CREATE TABLE Cuenta (
    CodigoEntrenador CHAR(5),
    IdPersona        BIGINT,
    NombreUsuario    VARCHAR(50),
    Nivel            INTEGER,
    Equipo           VARCHAR(30)
);

-- Restricciones Cuenta (Dominio)
ALTER TABLE Cuenta ALTER COLUMN Nivel SET DEFAULT 1;
ALTER TABLE Cuenta ALTER COLUMN Nivel SET NOT NULL;
ALTER TABLE Cuenta ADD CONSTRAINT cuenta_d1 CHECK (CHAR_LENGTH(CodigoEntrenador) = 5);
ALTER TABLE Cuenta ADD CONSTRAINT cuenta_d2 CHECK (IdPersona > 0);
ALTER TABLE Cuenta ADD CONSTRAINT cuenta_d3 CHECK (NombreUsuario <> '');
ALTER TABLE Cuenta ADD CONSTRAINT cuenta_d4 CHECK (Equipo <> '');

-- Entidad
ALTER TABLE Cuenta ADD CONSTRAINT cuenta_pkey PRIMARY KEY (CodigoEntrenador);



-- Tabla
COMMENT ON TABLE Cuenta IS
'Tabla de cuentas de entrenadores: usuario, nivel y equipo.';

-- Columnas
COMMENT ON COLUMN Cuenta.CodigoEntrenador IS
'Código del entrenador (CHAR(5)); identificador único y PK.';

COMMENT ON COLUMN Cuenta.IdPersona IS
'Identificador de la persona asociada; debe ser > 0 según CHECK d2.';

COMMENT ON COLUMN Cuenta.NombreUsuario IS
'Nombre de usuario; se valida que no sea cadena vacía (CHECK d3).';

COMMENT ON COLUMN Cuenta.Nivel IS
'Nivel de la cuenta; por defecto 1 y no vacío.';

COMMENT ON COLUMN Cuenta.Equipo IS
'Equipo del jugador; se valida que no sea cadena vacía (CHECK d4).';

-- Constraints (integridad)
COMMENT ON CONSTRAINT cuenta_d1 ON Cuenta IS
'CHECK: CHAR_LENGTH(CodigoEntrenador) = 5 (exactamente 5 caracteres).';

COMMENT ON CONSTRAINT cuenta_d2 ON Cuenta IS
'CHECK: IdPersona > 0.';

COMMENT ON CONSTRAINT cuenta_d3 ON Cuenta IS
'CHECK: NombreUsuario <> '''' (no permite cadena vacía).';

COMMENT ON CONSTRAINT cuenta_d4 ON Cuenta IS
'CHECK: Equipo <> '''' (no permite cadena vacía).';

COMMENT ON CONSTRAINT cuenta_pkey ON Cuenta IS
'Llave primaria de Cuenta (CodigoEntrenador).';






-- Pokemon
CREATE TABLE Pokemon (
   IdPokemon        INTEGER,
   CodigoEntrenador CHAR(5),
   Nombre           VARCHAR(50),
   CombatPoints     INTEGER,
   Especie          VARCHAR(50),
   Peso             NUMERIC(6,2),
   Sexo             VARCHAR(10),
   Shiny            BOOLEAN
);

-- Dominio
ALTER TABLE Pokemon
  ALTER COLUMN IdPokemon SET NOT NULL;

ALTER TABLE Pokemon
  ALTER COLUMN IdPokemon ADD GENERATED BY DEFAULT AS IDENTITY;

ALTER TABLE Pokemon
  ALTER COLUMN CodigoEntrenador SET NOT NULL,
  ALTER COLUMN Nombre           SET NOT NULL,
  ALTER COLUMN Especie          SET NOT NULL,
  ALTER COLUMN Shiny            SET DEFAULT FALSE,
  ALTER COLUMN CombatPoints     SET DEFAULT 0;

-- Entidad
ALTER TABLE Pokemon
  ADD CONSTRAINT pokemon_pk PRIMARY KEY (IdPokemon);

-- Referencial
ALTER TABLE Pokemon
  ADD CONSTRAINT pokemon_codigoentrenador_fk
  FOREIGN KEY (CodigoEntrenador) REFERENCES Cuenta (CodigoEntrenador)
  ON DELETE CASCADE ON UPDATE CASCADE;




-- Tabla
COMMENT ON TABLE Pokemon IS
'Registro de Pokémon por entrenador: datos básicos, CP, especie, peso, sexo y si es shiny.';

-- Columnas
COMMENT ON COLUMN Pokemon.IdPokemon IS
'Identificador único del Pokémon; NOT NULL y generado con IDENTITY (BY DEFAULT).';

COMMENT ON COLUMN Pokemon.CodigoEntrenador IS
'Código de la cuenta propietaria; FK a Cuenta(CodigoEntrenador).';

COMMENT ON COLUMN Pokemon.Nombre IS
'Nombre (apodo) del Pokémon; obligatorio.';

COMMENT ON COLUMN Pokemon.CombatPoints IS
'Puntos de combate (CP); por defecto 0.';

COMMENT ON COLUMN Pokemon.Especie IS
'Especie del Pokémon; obligatorio.';

COMMENT ON COLUMN Pokemon.Peso IS
'Peso con dos decimales (NUMERIC(6,2)).';

COMMENT ON COLUMN Pokemon.Sexo IS
'Sexo del Pokémon (texto libre acorde a la especie).';

COMMENT ON COLUMN Pokemon.Shiny IS
'Indicador de variocolor; por defecto FALSE.';

-- Constraints (integridad)
COMMENT ON CONSTRAINT pokemon_pk ON Pokemon IS
'Llave primaria de Pokemon (IdPokemon).';

COMMENT ON CONSTRAINT pokemon_codigoentrenador_fk ON Pokemon IS
'FK: Pokemon.CodigoEntrenador → Cuenta(CodigoEntrenador); con políticas en cascada (CASCADE).';




-- Enfrentamiento
CREATE TABLE Enfrentamiento (
   IdTorneo BIGINT
);

ALTER TABLE Enfrentamiento
  ALTER COLUMN IdTorneo SET NOT NULL;

ALTER TABLE Enfrentamiento
  ALTER COLUMN IdTorneo ADD GENERATED BY DEFAULT AS IDENTITY;
ALTER TABLE Enfrentamiento
  ADD CONSTRAINT enfrentamiento_pk PRIMARY KEY (IdTorneo);


-- Tabla
COMMENT ON TABLE Enfrentamiento IS
'Tabla de enfrentamientos; por ahora solo incluye el identificador autogenerado.';

-- Columna
COMMENT ON COLUMN Enfrentamiento.IdTorneo IS
'Identificador único (BIGINT) generado con IDENTITY; clave primaria de la tabla.';

-- Constraint (integridad)
COMMENT ON CONSTRAINT enfrentamiento_pk ON Enfrentamiento IS
'Llave primaria de Enfrentamiento (IdTorneo).';




-- Recorrido
CREATE TABLE Recorrido (
   IdTorneo BIGINT
);

ALTER TABLE Recorrido
  ALTER COLUMN IdTorneo SET NOT NULL;

ALTER TABLE Recorrido
  ALTER COLUMN IdTorneo ADD GENERATED BY DEFAULT AS IDENTITY;
ALTER TABLE Recorrido
  ADD CONSTRAINT recorrido_pk PRIMARY KEY (IdTorneo);


-- Tabla
COMMENT ON TABLE Recorrido IS
'Tabla de recorridos; contiene un identificador que autogeneramos.';

-- Columna
COMMENT ON COLUMN Recorrido.IdTorneo IS
'Identificador único (BIGINT) generado con IDENTITY; clave primaria de la tabla.';

-- Constraint (integridad)
COMMENT ON CONSTRAINT recorrido_pk ON Recorrido IS
'Llave primaria de Recorrido (IdTorneo).';



-- CapturaShiny
CREATE TABLE CapturaShiny (
   IdTorneo BIGINT
);

ALTER TABLE CapturaShiny
  ALTER COLUMN IdTorneo SET NOT NULL;

ALTER TABLE CapturaShiny
  ALTER COLUMN IdTorneo ADD GENERATED BY DEFAULT AS IDENTITY;
ALTER TABLE CapturaShiny
  ADD CONSTRAINT capturashiny_pk PRIMARY KEY (IdTorneo);


-- Tabla
COMMENT ON TABLE CapturaShiny IS
'Tabla de capturas shiny; contiene un identificador autogenerado por cada registro.';

-- Columna
COMMENT ON COLUMN CapturaShiny.IdTorneo IS
'Identificador único (BIGINT) generado con IDENTITY; clave primaria de la tabla.';

-- Constraint (integridad)
COMMENT ON CONSTRAINT capturashiny_pk ON CapturaShiny IS
'Llave primaria de CapturaShiny (IdTorneo).';




-- EdicionTorneo
CREATE TABLE EdicionTorneo (
    IdEdicion     BIGINT,
    NumeroEdicion INT,
    FechaEvento   DATE,
    Nota          TEXT
);

-- Restricciones EdicionTorneo (Dominio)
ALTER TABLE EdicionTorneo ALTER COLUMN NumeroEdicion SET NOT NULL;
ALTER TABLE EdicionTorneo ALTER COLUMN FechaEvento   SET NOT NULL;
ALTER TABLE EdicionTorneo ADD CONSTRAINT edicionTorneo_d1 CHECK (Nota <> '');
ALTER TABLE EdicionTorneo ADD CONSTRAINT edicionTorneo_d2 CHECK (NumeroEdicion > 0);
-- Entidad
ALTER TABLE EdicionTorneo ADD CONSTRAINT ediciontorneo_pkey PRIMARY KEY (IdEdicion);



-- Tabla
COMMENT ON TABLE EdicionTorneo IS
'Ediciones del torneo: número de edición, fecha del evento y nota.';

-- Columnas
COMMENT ON COLUMN EdicionTorneo.IdEdicion IS
'Identificador único de la edición (BIGINT, PK).';

COMMENT ON COLUMN EdicionTorneo.NumeroEdicion IS
'Número correlativo de la edición; obligatorio y > 0.';

COMMENT ON COLUMN EdicionTorneo.FechaEvento IS
'Fecha del evento; obligatoria.';

COMMENT ON COLUMN EdicionTorneo.Nota IS
'Nota descriptiva opcional; si se registra, no puede ser la cadena vacía.';

-- Constraints (integridad)
COMMENT ON CONSTRAINT edicionTorneo_d1 ON EdicionTorneo IS
'CHECK: Nota <> '''' (si Nota no es NULL, no permite cadena vacía).';

COMMENT ON CONSTRAINT edicionTorneo_d2 ON EdicionTorneo IS
'CHECK: NumeroEdicion > 0 (entero positivo).';

COMMENT ON CONSTRAINT ediciontorneo_pkey ON EdicionTorneo IS
'Llave primaria de EdicionTorneo (IdEdicion).';




-- Torneo
CREATE TABLE Torneo (
   IdTorneo  BIGINT,
   IdEdicion BIGINT,
   Inicio    TIME,
   Final     TIME
);

ALTER TABLE Torneo
  ALTER COLUMN IdTorneo SET NOT NULL;

ALTER TABLE Torneo
  ALTER COLUMN IdTorneo ADD GENERATED BY DEFAULT AS IDENTITY;
ALTER TABLE Torneo
  ALTER COLUMN IdEdicion SET NOT NULL,
  ALTER COLUMN Inicio    SET NOT NULL,
  ALTER COLUMN Final     SET NOT NULL;
ALTER TABLE Torneo
  ADD CONSTRAINT torneo_pk PRIMARY KEY (IdTorneo);

-- Referencial
ALTER TABLE Torneo ADD CONSTRAINT torneo_idedicion_fk
  FOREIGN KEY (IdEdicion) REFERENCES EdicionTorneo (IdEdicion)
  ON DELETE CASCADE ON UPDATE CASCADE;


-- Tabla
COMMENT ON TABLE Torneo IS
'Instancias de torneo por edición; incluye horario de inicio y fin.';

-- Columnas
COMMENT ON COLUMN Torneo.IdTorneo IS
'Identificador único (BIGINT) generado con IDENTITY; clave primaria.';

COMMENT ON COLUMN Torneo.IdEdicion IS
'Edición a la que pertenece el torneo; FK a EdicionTorneo(IdEdicion).';

COMMENT ON COLUMN Torneo.Inicio IS
'Hora de inicio del torneo; obligatoria.';

COMMENT ON COLUMN Torneo.Final IS
'Hora de término del torneo; obligatoria.';

-- Constraints (integridad)
COMMENT ON CONSTRAINT torneo_pk ON Torneo IS
'Llave primaria de Torneo (IdTorneo).';

COMMENT ON CONSTRAINT torneo_idedicion_fk ON Torneo IS
'FK: Torneo.IdEdicion → EdicionTorneo(IdEdicion); sin políticas explícitas (es NO ACTION por defecto).';




-- Participante
CREATE TABLE Participante (
    IdPersona  BIGINT,
    IdTorneo   BIGINT,
    NoCuenta   BIT(9),
    Facultad   VARCHAR(100),
    Carrera    VARCHAR(100),
    Ubicacion  NUMERIC(10,2),
    Distancia  NUMERIC(10,2),
    Hora       TIME
);

-- Restricciones Participante (Dominio)
ALTER TABLE Participante ADD CONSTRAINT participante_d1
  CHECK (bit_length(NoCuenta) = 9);
ALTER TABLE Participante ADD CONSTRAINT participante_d2
  CHECK (Facultad <> '');
ALTER TABLE Participante ADD CONSTRAINT participante_d3
  CHECK (Carrera <> '');
ALTER TABLE Participante ADD CONSTRAINT participante_d4
  CHECK (Distancia >= 0);
ALTER TABLE Participante ALTER COLUMN NoCuenta SET NOT NULL;
ALTER TABLE Participante ADD CONSTRAINT no_cuenta_unique UNIQUE (NoCuenta);

-- Entidad
ALTER TABLE Participante ADD CONSTRAINT participante_pkey PRIMARY KEY (IdPersona);

-- Referencias
ALTER TABLE Participante ADD CONSTRAINT participante_fkey_torneo
  FOREIGN KEY (IdTorneo) REFERENCES Torneo (IdTorneo)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- Cuenta → Participante
ALTER TABLE Cuenta ADD CONSTRAINT cuenta_fkey
  FOREIGN KEY (IdPersona) REFERENCES Participante (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;


-- Tabla
COMMENT ON TABLE Participante IS
'Participantes inscritos en un torneo: persona, cuenta, datos académicos y métricas.';

-- Columnas
COMMENT ON COLUMN Participante.IdPersona IS
'Identificador de la persona participante (BIGINT); clave primaria.';

COMMENT ON COLUMN Participante.IdTorneo IS
'Torneo al que está inscrito el participante; FK a Torneo(IdTorneo).';

COMMENT ON COLUMN Participante.NoCuenta IS
'Número de cuenta en formato BIT(9); obligatorio y único, exactamente 9 bits.';

COMMENT ON COLUMN Participante.Facultad IS
'Facultad de procedencia; validada para no ser cadena vacía (CHECK d2).';

COMMENT ON COLUMN Participante.Carrera IS
'Carrera del participante; validada para no ser cadena vacía (CHECK d3).';

COMMENT ON COLUMN Participante.Ubicacion IS
'Valor de ubicación (métrica definida en el modelo) con 2 decimales.';

COMMENT ON COLUMN Participante.Distancia IS
'Distancia (2 decimales); debe ser >= 0 (CHECK d4).';

COMMENT ON COLUMN Participante.Hora IS
'Hora asociada al registro del participante.';

-- Constraints (integridad)
COMMENT ON CONSTRAINT participante_d1 ON Participante IS
'CHECK: longitud en bits de (NoCuenta) = 9 (exactamente 9 bits).';

COMMENT ON CONSTRAINT participante_d2 ON Participante IS
'CHECK: Facultad <> '''' (no permite cadena vacía).';

COMMENT ON CONSTRAINT participante_d3 ON Participante IS
'CHECK: Carrera <> '''' (no permite cadena vacía).';

COMMENT ON CONSTRAINT participante_d4 ON Participante IS
'CHECK: Distancia >= 0 (no negativa).';

COMMENT ON CONSTRAINT no_cuenta_unique ON Participante IS
'UNIQUE: garantiza unicidad de NoCuenta.';

COMMENT ON CONSTRAINT participante_pkey ON Participante IS
'Llave primaria de Participante (IdPersona).';

COMMENT ON CONSTRAINT participante_fkey_torneo ON Participante IS
'FK: Participante.IdTorneo → Torneo(IdTorneo); sin políticas explícitas (NO ACTION por defecto).';

COMMENT ON CONSTRAINT cuenta_fkey ON Cuenta IS
'FK: Cuenta.IdPersona → Participante(IdPersona); sin políticas explícitas (NO ACTION por defecto).';




-- Telefono
CREATE TABLE Telefono (
    IdPersona BIGINT,
    Telefono  VARCHAR(20)
);

-- Restricciones Telefono
ALTER TABLE Telefono ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE Telefono ALTER COLUMN Telefono  SET NOT NULL;

-- Referencial
ALTER TABLE Telefono ADD CONSTRAINT telefono_fkey
  FOREIGN KEY (IdPersona) REFERENCES Persona (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- Tabla
COMMENT ON TABLE Telefono IS
'Teléfonos asociados a personas. Cada fila registra un número para una persona.';

-- Columnas
COMMENT ON COLUMN Telefono.IdPersona IS
'Persona dueña del teléfono; NOT NULL y referenciada a Persona(IdPersona).';

COMMENT ON COLUMN Telefono.Telefono IS
'Número telefónico en formato texto; NOT NULL.';

-- Constraints (integridad)
COMMENT ON CONSTRAINT telefono_fkey ON Telefono IS
'FK: Telefono.IdPersona → Persona(IdPersona); sin políticas explícitas (es NO ACTION por defecto).';



-- Correo
CREATE TABLE Correo (
    IdPersona BIGINT,
    Correo    VARCHAR(100)
);

-- Restricciones Correo
ALTER TABLE Correo ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE Correo ADD CONSTRAINT correo_d1 CHECK (correo LIKE '%_@_%._%');
ALTER TABLE Correo ALTER COLUMN Correo SET NOT NULL;

-- Referencial
ALTER TABLE Correo ADD CONSTRAINT correo_fkey
  FOREIGN KEY (IdPersona) REFERENCES Persona (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- Tabla
COMMENT ON TABLE Correo IS
'Direcciones de correo asociadas a personas.';

-- Columnas
COMMENT ON COLUMN Correo.IdPersona IS
'Persona dueña del correo; NOT NULL y referenciada a Persona(IdPersona).';

COMMENT ON COLUMN Correo.Correo IS
'Dirección de correo electrónico; NOT NULL y validada con patrón básico.';

-- Constraints (integridad)
COMMENT ON CONSTRAINT correo_d1 ON Correo IS
'CHECK: valida formato básico de e-mail con LIKE ''%_@_%._%'' (validación mínima).';

COMMENT ON CONSTRAINT correo_fkey ON Correo IS
'FK: Correo.IdPersona → Persona(IdPersona); sin políticas explícitas (NO ACTION por defecto).';





----------------- CREACION DE TABLAS DE ESPECIALIZACION -----------------

-- Empleado
CREATE TABLE Empleado (
    IdPersona BIGINT,
    IdEmpleado VARCHAR(20),
    Ciudad VARCHAR(50),
    Calle  VARCHAR(50),
    Colonia VARCHAR(50),
    CP INT,
    NoExterior INT,
    NoInterior INT
);

-- Restricciones Empleado
ALTER TABLE Empleado ADD CONSTRAINT empleado_d1 CHECK (IdEmpleado <> '');
ALTER TABLE Empleado ALTER COLUMN IdEmpleado SET NOT NULL;
ALTER TABLE Empleado ADD CONSTRAINT empleado_id_unique UNIQUE (IdEmpleado);
ALTER TABLE Empleado ADD CONSTRAINT empleado_d2 CHECK (Ciudad <> '');
ALTER TABLE Empleado ALTER COLUMN Ciudad SET NOT NULL;
ALTER TABLE Empleado ADD CONSTRAINT empleado_d3 CHECK (Calle <> '');
ALTER TABLE Empleado ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE Empleado ADD CONSTRAINT empleado_d4 CHECK (Colonia <> '');
ALTER TABLE Empleado ALTER COLUMN Colonia SET NOT NULL;
ALTER TABLE Empleado ADD CONSTRAINT empleado_d5 CHECK (CP BETWEEN 10000 AND 99999);

-- Entidad
ALTER TABLE Empleado ADD CONSTRAINT empleado_pkey PRIMARY KEY (IdPersona);

-- Referencial
ALTER TABLE Empleado ADD CONSTRAINT empleado_fkey
  FOREIGN KEY (IdPersona) REFERENCES Persona (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;


-- Tabla
COMMENT ON TABLE Empleado IS
'Empleados (que extiende Persona) con identificador de empleado y domicilio postal.';

-- Columnas
COMMENT ON COLUMN Empleado.IdPersona IS
'Identificador de la persona; PK de Empleado y FK a Persona(IdPersona).';

COMMENT ON COLUMN Empleado.IdEmpleado IS
'Clave/código del empleado (VARCHAR(20)); NOT NULL, UNIQUE y no vacío.';

COMMENT ON COLUMN Empleado.Ciudad IS
'Ciudad del domicilio; NOT NULL y no puede ser cadena vacía.';

COMMENT ON COLUMN Empleado.Calle IS
'Calle del domicilio; NOT NULL y no puede ser cadena vacía.';

COMMENT ON COLUMN Empleado.Colonia IS
'Colonia del domicilio; NOT NULL y no puede ser cadena vacía.';

COMMENT ON COLUMN Empleado.CP IS
'Código Postal (INT) validado a 5 dígitos: entre 10000 y 99999.';

COMMENT ON COLUMN Empleado.NoExterior IS
'Número exterior; opcional.';

COMMENT ON COLUMN Empleado.NoInterior IS
'Número interior; opcional.';

-- Constraints (integridad)
COMMENT ON CONSTRAINT empleado_d1 ON Empleado IS
'CHECK: IdEmpleado <> '''' (no permite cadena vacía).';

COMMENT ON CONSTRAINT empleado_id_unique ON Empleado IS
'UNIQUE: garantiza unicidad de IdEmpleado.';

COMMENT ON CONSTRAINT empleado_d2 ON Empleado IS
'CHECK: Ciudad <> '''' (no permite cadena vacía).';

COMMENT ON CONSTRAINT empleado_d3 ON Empleado IS
'CHECK: Calle <> '''' (no permite cadena vacía).';

COMMENT ON CONSTRAINT empleado_d4 ON Empleado IS
'CHECK: Colonia <> '''' (no permite cadena vacía).';

COMMENT ON CONSTRAINT empleado_d5 ON Empleado IS
'CHECK: CP entre 10000 y 99999 (CP de 5 dígitos).';

COMMENT ON CONSTRAINT empleado_pkey ON Empleado IS
'Llave primaria de Empleado (IdPersona).';

COMMENT ON CONSTRAINT empleado_fkey ON Empleado IS
'FK: Empleado.IdPersona → Persona(IdPersona); sin políticas explícitas (es NO ACTION por defecto).';



-- Cuidador
CREATE TABLE Cuidador (
    IdPersona   BIGINT,
    Horario     TIME,
    Localizacion TEXT,
    Salario     MONEY
);

-- Restricciones Cuidador
ALTER TABLE Cuidador ALTER COLUMN Horario SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d1 CHECK (Horario BETWEEN '09:00:00' AND '15:00:00');
ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d2 CHECK (Localizacion <> '');
ALTER TABLE Cuidador ALTER COLUMN Localizacion SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN Salario SET NOT NULL;

-- Entidad
ALTER TABLE Cuidador ADD CONSTRAINT cuidador_pkey PRIMARY KEY (IdPersona);

-- Referencial
ALTER TABLE Cuidador ADD CONSTRAINT cuidador_fkey
  FOREIGN KEY (IdPersona) REFERENCES Empleado (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;


-- Tabla
COMMENT ON TABLE Cuidador IS
'Empleados con rol de cuidador; registra horario, localización y salario.';

-- Columnas
COMMENT ON COLUMN Cuidador.IdPersona IS
'Identificador de la persona; PK de Cuidador y FK a Empleado(IdPersona).';

COMMENT ON COLUMN Cuidador.Horario IS
'Horario laboral; NOT NULL y debe estar entre 09:00:00 y 15:00:00.';

COMMENT ON COLUMN Cuidador.Localizacion IS
'Localización/asignación del cuidador; NOT NULL y no puede ser cadena vacía.';

COMMENT ON COLUMN Cuidador.Salario IS
'Salario en tipo MONEY; NOT NULL.';

-- Constraints (integridad)
COMMENT ON CONSTRAINT cuidador_d1 ON Cuidador IS
'CHECK: Horario BETWEEN 09:00:00 AND 15:00:00.';

COMMENT ON CONSTRAINT cuidador_d2 ON Cuidador IS
'CHECK: Localizacion <> '''' (no permite cadena vacía).';

COMMENT ON CONSTRAINT cuidador_pkey ON Cuidador IS
'Llave primaria de Cuidador (IdPersona).';

COMMENT ON CONSTRAINT cuidador_fkey ON Cuidador IS
'FK: Cuidador.IdPersona → Empleado(IdPersona); sin políticas explícitas (es NO ACTION por defecto).';


-- Encargado
CREATE TABLE Encargado (
    IdPersona BIGINT,
    Registro  INT
);

-- Restricciones Encargado
ALTER TABLE Encargado ADD CONSTRAINT encargado_d1 CHECK (Registro >= 0);
ALTER TABLE Encargado ALTER COLUMN Registro SET NOT NULL;

-- Entidad
ALTER TABLE Encargado ADD CONSTRAINT encargado_pkey PRIMARY KEY (IdPersona);

-- Referencial
ALTER TABLE Encargado ADD CONSTRAINT encargado_fkey
  FOREIGN KEY (IdPersona) REFERENCES Empleado (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;


-- Tabla
COMMENT ON TABLE Encargado IS
'Empleados con rol de encargado; registra un contador/registro asociado.';

-- Columnas
COMMENT ON COLUMN Encargado.IdPersona IS
'Identificador de la persona; PK de Encargado y FK a Empleado(IdPersona).';

COMMENT ON COLUMN Encargado.Registro IS
'Valor entero de registro; NOT NULL y no negativo (>= 0).';

-- Constraints (integridad)
COMMENT ON CONSTRAINT encargado_d1 ON Encargado IS
'CHECK: Registro >= 0 (no negativo).';

COMMENT ON CONSTRAINT encargado_pkey ON Encargado IS
'Llave primaria de Encargado (IdPersona).';

COMMENT ON CONSTRAINT encargado_fkey ON Encargado IS
'FK: Encargado.IdPersona → Empleado(IdPersona); sin políticas explícitas (es NO ACTION por defecto).';



-- Vendedor
CREATE TABLE Vendedor (
    IdPersona BIGINT,
    Ventas    INT,
    Ubicacion TEXT
);

-- Restricciones Vendedor
ALTER TABLE Vendedor ADD CONSTRAINT vendedor_d1 CHECK (Ubicacion <> '');
ALTER TABLE Vendedor ALTER COLUMN Ubicacion SET NOT NULL;
ALTER TABLE Vendedor ADD CONSTRAINT vendedor_d2 CHECK (Ventas >= 0);
ALTER TABLE Vendedor ALTER COLUMN Ventas SET NOT NULL;

-- Entidad
ALTER TABLE Vendedor ADD CONSTRAINT vendedor_pkey PRIMARY KEY (IdPersona);

-- Referencial
ALTER TABLE Vendedor ADD CONSTRAINT vendedor_fkey
  FOREIGN KEY (IdPersona) REFERENCES Empleado (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;


-- Tabla
COMMENT ON TABLE Vendedor IS
'Empleados con rol de vendedor; registra número de ventas y ubicación.';

-- Columnas
COMMENT ON COLUMN Vendedor.IdPersona IS
'Identificador de la persona; PK de Vendedor y FK a Empleado(IdPersona).';

COMMENT ON COLUMN Vendedor.Ventas IS
'Conteo de ventas (INT); NOT NULL y no negativo (>= 0).';

COMMENT ON COLUMN Vendedor.Ubicacion IS
'Ubicación/asignación del vendedor; NOT NULL y no puede ser cadena vacía.';

-- Constraints (integridad)
COMMENT ON CONSTRAINT vendedor_d1 ON Vendedor IS
'CHECK: Ubicacion <> '''' (no permite cadena vacía).';

COMMENT ON CONSTRAINT vendedor_d2 ON Vendedor IS
'CHECK: Ventas >= 0 (no negativo).';

COMMENT ON CONSTRAINT vendedor_pkey ON Vendedor IS
'Llave primaria de Vendedor (IdPersona).';

COMMENT ON CONSTRAINT vendedor_fkey ON Vendedor IS
'FK: Vendedor.IdPersona → Empleado(IdPersona); sin políticas explícitas (es NO ACTION por defecto).';




-- Limpiador
CREATE TABLE Limpiador (
    IdPersona   BIGINT,
    Horario     TIME,
    Localizacion TEXT,
    Salario     MONEY
);

-- Restricciones Limpiador
ALTER TABLE Limpiador ALTER COLUMN Horario SET NOT NULL;
ALTER TABLE Limpiador ADD CONSTRAINT limpiador_d1 CHECK (Horario BETWEEN '09:00:00' AND '15:00:00');
ALTER TABLE Limpiador ADD CONSTRAINT limpiador_d2 CHECK (Localizacion <> '');
ALTER TABLE Limpiador ALTER COLUMN Localizacion SET NOT NULL;
ALTER TABLE Limpiador ALTER COLUMN Salario SET NOT NULL;

-- Entidad
ALTER TABLE Limpiador ADD CONSTRAINT limpiador_pkey PRIMARY KEY (IdPersona);

-- Referencial
ALTER TABLE Limpiador ADD CONSTRAINT limpiador_fkey
  FOREIGN KEY (IdPersona) REFERENCES Empleado (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- Tabla
COMMENT ON TABLE Limpiador IS
'Empleados con rol de limpiador; registra horario, localización y salario.';

-- Columnas
COMMENT ON COLUMN Limpiador.IdPersona IS
'Identificador de la persona; PK de Limpiador y FK a Empleado(IdPersona).';

COMMENT ON COLUMN Limpiador.Horario IS
'Horario laboral; NOT NULL y debe estar entre 09:00:00 y 15:00:00.';

COMMENT ON COLUMN Limpiador.Localizacion IS
'Localización/asignación del limpiador; NOT NULL y no puede ser cadena vacía.';

COMMENT ON COLUMN Limpiador.Salario IS
'Salario en tipo MONEY; NOT NULL.';

-- Constraints (integridad)
COMMENT ON CONSTRAINT limpiador_d1 ON Limpiador IS
'CHECK: Horario entre 09:00:00 y 15:00:00.';

COMMENT ON CONSTRAINT limpiador_d2 ON Limpiador IS
'CHECK: Localizacion <> '''' (no permite cadena vacía).';

COMMENT ON CONSTRAINT limpiador_pkey ON Limpiador IS
'Llave primaria de Limpiador (IdPersona).';

COMMENT ON CONSTRAINT limpiador_fkey ON Limpiador IS
'FK: Limpiador.IdPersona → Empleado(IdPersona); sin políticas explícitas (es NO ACTION).';





CREATE TABLE Venta (
    IdVenta      BIGINT,
    IdPersona    BIGINT,
    IdPersonaV   BIGINT,
    IdEspectador BIGINT,
    TipoPago     VARCHAR(50),
    FechaHora    TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    TotalSinIva  MONEY
);

-- Restricciones Venta (Dominio)
ALTER TABLE Venta ADD CONSTRAINT venta_d1 CHECK (TipoPago <> '');
ALTER TABLE Venta ADD CONSTRAINT venta_d2 CHECK (TipoPago IN ('Efectivo','Tarjeta','Transferencia','Otro'));
ALTER TABLE Venta ADD CONSTRAINT venta_d3 CHECK (TotalSinIva IS NULL OR TotalSinIva > 0::money);
ALTER TABLE Venta ADD CONSTRAINT venta_d4 CHECK (FechaHora <= NOW());

-- exactamente 1 de {IdPersona, IdEspectador} debe venir informado
ALTER TABLE Venta ADD CONSTRAINT venta_destinatario_chk
  CHECK ((IdPersona IS NOT NULL AND IdEspectador IS NULL) OR
         (IdPersona IS NULL AND IdEspectador IS NOT NULL));

-- Entidad
ALTER TABLE Venta ADD CONSTRAINT venta_pkey PRIMARY KEY (IdVenta);

-- Referencias
ALTER TABLE Venta ADD CONSTRAINT venta_fkey_idpersona
  FOREIGN KEY (IdPersona)  REFERENCES Persona (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Venta ADD CONSTRAINT venta_fkey_idpersonav
  FOREIGN KEY (IdPersonaV) REFERENCES Vendedor (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Venta ADD CONSTRAINT venta_fkey_espectador
  FOREIGN KEY (IdEspectador) REFERENCES Espectador (IdEspectador)
  ON DELETE CASCADE ON UPDATE CASCADE;


-- Tabla
COMMENT ON TABLE Venta IS
'Ventas: vincula participantes o espectadores con método de pago, fecha/hora y total sin IVA.';

-- Columnas
COMMENT ON COLUMN Venta.IdVenta IS
'Identificador único de la venta (BIGINT, PK).';

COMMENT ON COLUMN Venta.IdPersona IS
'Participante asociado a la venta; mutuamente excluyente con IdEspectador (ver CHECK venta_destinatario_chk).';

COMMENT ON COLUMN Venta.IdPersonaV IS
'Participante que registra/realiza la venta (vendedor/atendiente); FK a Participante(IdPersona).';

COMMENT ON COLUMN Venta.IdEspectador IS
'Espectador asociado a la venta; mutuamente excluyente con IdPersona (ver CHECK venta_destinatario_chk).';

COMMENT ON COLUMN Venta.TipoPago IS
'Método de pago; validado contra {Efectivo, Tarjeta, Transferencia, Otro}.';

COMMENT ON COLUMN Venta.FechaHora IS
'Marca de tiempo de la venta (TIMESTAMPTZ); DEFAULT CURRENT_TIMESTAMP y no puede ser futura (CHECK d4).';

COMMENT ON COLUMN Venta.TotalSinIva IS
'Importe sin IVA en MONEY; NULL permitido, si no es NULL debe ser > 0.';

-- Constraints (integridad)
COMMENT ON CONSTRAINT venta_d1 ON Venta IS
'CHECK: TipoPago <> '''' (no permite cadena vacía).';

COMMENT ON CONSTRAINT venta_d2 ON Venta IS
'CHECK: TipoPago ∈ {''Efectivo'', ''Tarjeta'', ''Transferencia'', ''Otro''}.';

COMMENT ON CONSTRAINT venta_d3 ON Venta IS
'CHECK: TotalSinIva IS NULL OR TotalSinIva > 0::money (importe positivo cuando se informa).';

COMMENT ON CONSTRAINT venta_d4 ON Venta IS
'CHECK: FechaHora <= NOW() (impide fechas/horas futuras).';

COMMENT ON CONSTRAINT venta_destinatario_chk ON Venta IS
'CHECK: exactamente uno informado entre IdPersona y IdEspectador (XOR).';

COMMENT ON CONSTRAINT venta_pkey ON Venta IS
'Llave primaria de Venta (IdVenta).';

COMMENT ON CONSTRAINT venta_fkey_idpersona ON Venta IS
'FK: Venta.IdPersona → Participante(IdPersona); con políticas en cascada (CASCADE).';

COMMENT ON CONSTRAINT venta_fkey_idpersonav ON Venta IS
'FK: Venta.IdPersonaV → Participante(IdPersona); con políticas en cascada (CASCADE).';

COMMENT ON CONSTRAINT venta_fkey_espectador ON Venta IS
'FK: Venta.IdEspectador → Espectador(IdEspectador); con políticas en cascada (CASCADE).';




-- Pelea
CREATE TABLE Pelea (
    IdPelea        BIGINT,
    IdParticipante BIGINT,
    IdTorneo       BIGINT
);

-- Entidad
ALTER TABLE Pelea ADD CONSTRAINT pelea_pkey PRIMARY KEY (IdPelea);

-- Referencial 
ALTER TABLE Pelea ADD CONSTRAINT pelea_fkey_participante
  FOREIGN KEY (IdParticipante) REFERENCES Participante (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Pelea ADD CONSTRAINT pelea_fkey_torneo
  FOREIGN KEY (IdTorneo) REFERENCES Torneo (IdTorneo)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- Tabla
COMMENT ON TABLE Pelea IS
'Registro de peleas: vincula a un participante con un torneo; la identificamos por IdPelea.';

-- Columnas
COMMENT ON COLUMN Pelea.IdPelea IS
'Identificador único de la pelea (BIGINT, PK).';

COMMENT ON COLUMN Pelea.IdParticipante IS
'Participante involucrado en la pelea; FK a Participante(IdPersona).';

COMMENT ON COLUMN Pelea.IdTorneo IS
'Torneo en el que ocurre la pelea; FK a Torneo(IdTorneo).';

-- Constraints (integridad)
COMMENT ON CONSTRAINT pelea_pkey ON Pelea IS
'Llave primaria de Pelea (IdPelea).';

COMMENT ON CONSTRAINT pelea_fkey_participante ON Pelea IS
'FK: Pelea.IdParticipante → Participante(IdPersona); con políticas en cascada (CASCADE).';

COMMENT ON CONSTRAINT pelea_fkey_torneo ON Pelea IS
'FK: Pelea.IdTorneo → Torneo(IdTorneo); con políticas en cascada (CASCADE).';



-- Capturar
CREATE TABLE Capturar (
    IdPersona  BIGINT,
    IdPokemon  INT,
    IdTorneo   BIGINT,
    FechaYHora TIMESTAMPTZ
);

-- Restricciones Capturar
ALTER TABLE Capturar ADD CONSTRAINT capturar_d1 CHECK (IdPokemon > 0);
ALTER TABLE Capturar ADD CONSTRAINT capturar_d2 CHECK (IdPersona > 0);
ALTER TABLE Capturar ADD CONSTRAINT capturar_d3 CHECK (FechaYHora <= NOW());

-- Referencias
ALTER TABLE Capturar ADD CONSTRAINT capturar_fkey_persona
  FOREIGN KEY (IdPersona) REFERENCES Participante (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Capturar ADD CONSTRAINT capturar_fkey_pokemon
  FOREIGN KEY (IdPokemon) REFERENCES Pokemon (IdPokemon)
  ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Capturar ADD CONSTRAINT capturar_fkey_torneo
  FOREIGN KEY (IdTorneo)  REFERENCES Torneo (IdTorneo)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- Tabla
COMMENT ON TABLE Capturar IS
'Capturas realizadas por participantes en un torneo; registra Pokémon, participante y momento de captura.';

-- Columnas
COMMENT ON COLUMN Capturar.IdPersona IS
'Participante que realiza la captura; FK a Participante(IdPersona).';

COMMENT ON COLUMN Capturar.IdPokemon IS
'Pokémon capturado; entero > 0 y FK a Pokemon(IdPokemon).';

COMMENT ON COLUMN Capturar.IdTorneo IS
'Torneo en el que ocurrió la captura; FK a Torneo(IdTorneo).';

COMMENT ON COLUMN Capturar.FechaYHora IS
'Marca de tiempo (TIMESTAMPTZ) de la captura; no puede ser futura.';

-- Constraints (integridad)
COMMENT ON CONSTRAINT capturar_d1 ON Capturar IS
'CHECK: IdPokemon > 0.';

COMMENT ON CONSTRAINT capturar_d2 ON Capturar IS
'CHECK: IdPersona > 0.';

COMMENT ON CONSTRAINT capturar_d3 ON Capturar IS
'CHECK: FechaYHora <= NOW() (evita fechas futuras).';

COMMENT ON CONSTRAINT capturar_fkey_persona ON Capturar IS
'FK: Capturar.IdPersona → Participante(IdPersona); con políticas en cascada (CASCADE).';

COMMENT ON CONSTRAINT capturar_fkey_pokemon ON Capturar IS
'FK: Capturar.IdPokemon → Pokemon(IdPokemon); con políticas en cascada (CASCADE).';

COMMENT ON CONSTRAINT capturar_fkey_torneo ON Capturar IS
'FK: Capturar.IdTorneo → Torneo(IdTorneo); con políticas en cascada (CASCADE).';




-- Ganar
CREATE TABLE Ganar (
   IdPersona BIGINT,
   IdTorneo  BIGINT
);

-- Dominio
ALTER TABLE Ganar
  ALTER COLUMN IdPersona SET NOT NULL,
  ALTER COLUMN IdTorneo  SET NOT NULL;

-- Referencial
ALTER TABLE Ganar ADD CONSTRAINT ganar_idpersona_fk
  FOREIGN KEY (IdPersona) REFERENCES Persona (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Ganar ADD CONSTRAINT ganar_idtorneo_fk
  FOREIGN KEY (IdTorneo) REFERENCES Torneo (IdTorneo)
  ON DELETE CASCADE ON UPDATE CASCADE;


-- Tabla
COMMENT ON TABLE Ganar IS
'Registro de ganadores por torneo (en nuestra relación persona ↔ torneo).';

-- Columnas
COMMENT ON COLUMN Ganar.IdPersona IS
'Persona ganadora; NOT NULL y FK a Persona(IdPersona).';

COMMENT ON COLUMN Ganar.IdTorneo IS
'Torneo ganado; NOT NULL y FK a Torneo(IdTorneo).';

-- Constraints (integridad referencial)
COMMENT ON CONSTRAINT ganar_idpersona_fk ON Ganar IS
'FK: Ganar.IdPersona → Persona(IdPersona); ON UPDATE CASCADE; ON DELETE RESTRICT.';

COMMENT ON CONSTRAINT ganar_idtorneo_fk ON Ganar IS
'FK: Ganar.IdTorneo → Torneo(IdTorneo); ON UPDATE CASCADE; ON DELETE CASCADE.';



-- Participar
CREATE TABLE Participar (
    IdPersona BIGINT,
    IdTorneo  BIGINT
);

-- Referencial
ALTER TABLE Participar ADD CONSTRAINT participar_fkey_persona
  FOREIGN KEY (IdPersona) REFERENCES Participante (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Participar ADD CONSTRAINT participar_fkey_torneo
  FOREIGN KEY (IdTorneo)  REFERENCES Torneo (IdTorneo)
  ON DELETE CASCADE ON UPDATE CASCADE;


-- Tabla
COMMENT ON TABLE Participar IS
'Relación de participación: vincula a un participante con un torneo.';

-- Columnas
COMMENT ON COLUMN Participar.IdPersona IS
'Participante que participa; FK a Participante(IdPersona).';

COMMENT ON COLUMN Participar.IdTorneo IS
'Torneo en el que participa; FK a Torneo(IdTorneo).';

-- Constraints (integridad referencial)
COMMENT ON CONSTRAINT participar_fkey_persona ON Participar IS
'FK: Participar.IdPersona → Participante(IdPersona); con políticas en cascada (CASCADE).';

COMMENT ON CONSTRAINT participar_fkey_torneo ON Participar IS
'FK: Participar.IdTorneo → Torneo(IdTorneo); con políticas en cascada (CASCADE).';



-- Registrar
CREATE TABLE Registrar (
    IdAlimento BIGINT,
    IdVenta    BIGINT
);

-- Restricciones Registrar (Dominio)
ALTER TABLE Registrar ADD CONSTRAINT registrar_d1 CHECK (IdAlimento > 0);
ALTER TABLE Registrar ADD CONSTRAINT registrar_d2 CHECK (IdVenta > 0);

-- Referencias
ALTER TABLE Registrar ADD CONSTRAINT registrar_fkey_alimento
  FOREIGN KEY (IdAlimento) REFERENCES Alimento (IdAlimento)
  ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Registrar ADD CONSTRAINT registrar_fkey_venta
  FOREIGN KEY (IdVenta)    REFERENCES Venta (IdVenta)
  ON DELETE CASCADE ON UPDATE CASCADE;


-- Tabla
COMMENT ON TABLE Registrar IS
'Relación que asocia alimentos con ventas.';

-- Columnas
COMMENT ON COLUMN Registrar.IdAlimento IS
'Identificador del alimento; > 0 según CHECK d1 y FK a Alimento(IdAlimento).';

COMMENT ON COLUMN Registrar.IdVenta IS
'Identificador de la venta; > 0 según CHECK d2 y FK a Venta(IdVenta).';

-- Constraints (integridad)
COMMENT ON CONSTRAINT registrar_d1 ON Registrar IS
'CHECK: IdAlimento > 0.';

COMMENT ON CONSTRAINT registrar_d2 ON Registrar IS
'CHECK: IdVenta > 0.';

COMMENT ON CONSTRAINT registrar_fkey_alimento ON Registrar IS
'FK: Registrar.IdAlimento → Alimento(IdAlimento); sin políticas explícitas (es NO ACTION por defecto).';

COMMENT ON CONSTRAINT registrar_fkey_venta ON Registrar IS
'FK: Registrar.IdVenta → Venta(IdVenta); sin políticas explícitas (es NO ACTION por defecto).';




-- Tipo (multivaluado)
CREATE TABLE Tipo (
    IdPokemon INT,
    Tipo      VARCHAR(50)
);

-- Restricciones (Dominio)
ALTER TABLE Tipo ALTER COLUMN IdPokemon SET NOT NULL;
ALTER TABLE Tipo ALTER COLUMN Tipo      SET NOT NULL;

ALTER TABLE Tipo ADD CONSTRAINT tipo_d1
  CHECK (Tipo <> '');

-- Entidad (PK compuesta
ALTER TABLE Tipo ADD CONSTRAINT tipo_pkey
  PRIMARY KEY (IdPokemon, Tipo);

-- Referencial
ALTER TABLE Tipo ADD CONSTRAINT tipo_idpokemon_fk
  FOREIGN KEY (IdPokemon) REFERENCES Pokemon (IdPokemon)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- Tabla
COMMENT ON TABLE Tipo IS
'Tipos asignados a cada Pokémon (permitimos múltiples tipos por Pokémon).';

-- Columnas
COMMENT ON COLUMN Tipo.IdPokemon IS
'Pokémon al que se le asigna el tipo; NOT NULL y FK a Pokemon(IdPokemon).';

COMMENT ON COLUMN Tipo.Tipo IS
'Nombre del tipo (VARCHAR(50)); NOT NULL y parte de la PK compuesta.';

-- Constraints
COMMENT ON CONSTRAINT tipo_d1 ON Tipo IS
'CHECK: Tipo <> '''' (no permite cadena vacía).';

COMMENT ON CONSTRAINT tipo_pkey ON Tipo IS
'Llave primaria compuesta: (IdPokemon, Tipo).';

COMMENT ON CONSTRAINT tipo_idpokemon_fk ON Tipo IS
'FK: Tipo.IdPokemon → Pokemon(IdPokemon); sin políticas explícitas (es NO ACTION).';





-- Trabajar 
CREATE TABLE Trabajar (
    IdPersona BIGINT,
    IdEdicion BIGINT
);

-- Dominio
ALTER TABLE Trabajar ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE Trabajar ALTER COLUMN IdEdicion SET NOT NULL;

-- Entidad (PK compuesta)
ALTER TABLE Trabajar ADD CONSTRAINT trabajar_pkey
  PRIMARY KEY (IdPersona, IdEdicion);

-- Referencial
ALTER TABLE Trabajar ADD CONSTRAINT trabajar_idpersona_fk
  FOREIGN KEY (IdPersona) REFERENCES Empleado (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Trabajar ADD CONSTRAINT trabajar_idedicion_fk
  FOREIGN KEY (IdEdicion) REFERENCES EdicionTorneo (IdEdicion)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- Tabla
COMMENT ON TABLE Trabajar IS
'Relación de trabajo: qué empleado (IdPersona) trabaja en qué edición de torneo (IdEdicion).';

-- Columnas
COMMENT ON COLUMN Trabajar.IdPersona IS
'Empleado asignado; NOT NULL y FK a Empleado(IdPersona).';

COMMENT ON COLUMN Trabajar.IdEdicion IS
'Edición del torneo donde trabaja; NOT NULL y FK a EdicionTorneo(IdEdicion).';

-- Constraints
COMMENT ON CONSTRAINT trabajar_pkey ON Trabajar IS
'Llave primaria compuesta: (IdPersona, IdEdicion) evita asignaciones duplicadas.';

COMMENT ON CONSTRAINT trabajar_idpersona_fk ON Trabajar IS
'FK: Trabajar.IdPersona → Empleado(IdPersona); sin políticas explícitas (es NO ACTION).';

COMMENT ON CONSTRAINT trabajar_idedicion_fk ON Trabajar IS
'FK: Trabajar.IdEdicion → EdicionTorneo(IdEdicion); sin políticas explícitas (es NO ACTION).';




-- Pelear 
CREATE TABLE Pelear (
    IdPersona BIGINT,
    IdPelea   BIGINT  
);

-- Dominio
ALTER TABLE Pelear ALTER COLUMN IdPersona SET NOT NULL;
ALTER TABLE Pelear ALTER COLUMN IdPelea   SET NOT NULL;

-- Entidad (PK compuesta)
ALTER TABLE Pelear ADD CONSTRAINT pelear_pkey
  PRIMARY KEY (IdPersona, IdPelea);

-- Referencial
ALTER TABLE Pelear ADD CONSTRAINT pelear_idpersona_fk
  FOREIGN KEY (IdPersona) REFERENCES Participante (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Pelear ADD CONSTRAINT pelear_idpelea_fk
  FOREIGN KEY (IdPelea) REFERENCES Pelea (IdPelea)
  ON DELETE CASCADE ON UPDATE CASCADE;

-- Tabla
COMMENT ON TABLE Pelear IS
'Relación N:N entre participantes y peleas (quién participa en qué pelea).';

-- Columnas
COMMENT ON COLUMN Pelear.IdPersona IS
'Participante que pelea; NOT NULL y FK a Participante(IdPersona).';

COMMENT ON COLUMN Pelear.IdPelea IS
'Pelea en la que participa; NOT NULL y FK a Pelea(IdPelea).';

-- Constraints
COMMENT ON CONSTRAINT pelear_pkey ON Pelear IS
'Llave primaria compuesta: (IdPersona, IdPelea) evita registros duplicados.';

COMMENT ON CONSTRAINT pelear_idpersona_fk ON Pelear IS
'FK: Pelear.IdPersona → Participante(IdPersona); con políticas en cascada (CASCADE).';

COMMENT ON CONSTRAINT pelear_idpelea_fk ON Pelear IS
'FK: Pelear.IdPelea → Pelea(IdPelea); con políticas en cascada (CASCADE).';

-- CAMBIOS AL MODELO (RELACIÓN RECORRER)
CREATE TABLE Recorrer (
    IdPersona BIGINT,
    IdTorneo BIGINT,
    Ubicacion VARCHAR(20),
    Distancia NUMERIC(10,2),
    Hora TIME
);

-- Restricciones Recorrer (Dominio)
ALTER TABLE Recorrer ADD CONSTRAINT recorrer_d1 CHECK (Ubicacion <> '');
ALTER TABLE Recorrer ADD CONSTRAINT recorrer_d2 CHECK (Distancia >= 0);

-- Referencial
ALTER TABLE Recorrer ADD CONSTRAINT recorrer_fkey_torneo
  FOREIGN KEY (IdTorneo) REFERENCES Torneo (IdTorneo)
  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Recorrer ADD CONSTRAINT recorrer_fkey_persona
  FOREIGN KEY (IdPersona) REFERENCES Participante (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;

  -- Tabla
  COMMENT ON TABLE Recorrer IS
  'Los datos del recorrido de un participante en el torneo de recorridos.';

  -- Columnas
  COMMENT ON COLUMN Recorrer.IdPersona IS
  'Identificador de la persona participante (BIGINT); llave foránea.';

  COMMENT ON COLUMN Recorrer.IdTorneo IS
  'Identificador del torneo de recorridos (BIGINT); llave foránea.';

  COMMENT ON COLUMN Recorrer.Ubicacion IS
  'Lugar en donde se registraron los datos del torneo.';

  COMMENT ON COLUMN Recorrer.Distancia IS
  'Distancia recorrida por el participante en el torneo.';

  COMMENT ON COLUMN Recorrer.Hora IS
  'Hora en la cual se registraron estos datos.';

  -- Constraints
  COMMENT ON CONSTRAINT recorrer_d1 ON Recorrer IS
  'CHECK: La ubicación no sea una cadena vacía.';

  COMMENT ON CONSTRAINT recorrer_d2 ON Recorrer IS
  'CHECK: La distancia recorrida no es negativa.';

  COMMENT ON CONSTRAINT recorrer_fkey_persona ON Recorrer IS
  'Llave primaria de Participante (IdPersona).';

  COMMENT ON CONSTRAINT recorrer_fkey_torneo ON Recorrer IS
  'Llave primaria de Torneo (IdTorneo).';


  -- MODIFICACIONES A LA TABLA PARTICIPANTE --
  -- SE QUITAN LAS COLUMNAS UBICACION, HORA Y DISTANCIA --
  ALTER TABLE Participante
    DROP COLUMN IdTorneo,
    DROP COLUMN Ubicacion,
    DROP COLUMN Distancia,
    DROP COLUMN Hora;

  -- MODIFICACIONES A LA TABLA PARTICIPANTE --
  -- SE MODIFICA EL TIPO DE DATO DE NoCuenta Y SE AGREGA RESTRICCIÓN --
  ALTER TABLE Participante DROP CONSTRAINT participante_d1;
  ALTER TABLE Participante ALTER COLUMN NoCuenta TYPE CHAR(9);
  ALTER TABLE Participante ADD CONSTRAINT participante_d5 CHECK (NoCuenta ~ '^[0-9]{9}$');

  -- Referencias nuevas
  ALTER TABLE PARTICIPANTE ADD CONSTRAINT participante_fkey_persona 
    FOREIGN KEY (IdPersona) REFERENCES Persona (IdPersona) 
    ON DELETE CASCADE ON UPDATE CASCADE;


-- CAMBIOS AL MODELO (EQUIPAR) --
CREATE TABLE Equipar (
  IdPersona BIGINT,
  IdTorneo BIGINT,
  IdPokemon INTEGER
);

  -- Restricciones referenciales --
  ALTER TABLE Equipar ADD CONSTRAINT equipar_fkey_participante
  FOREIGN KEY (IdPersona) REFERENCES Participante (IdPersona)
  ON DELETE CASCADE ON UPDATE CASCADE;

  ALTER TABLE Equipar ADD CONSTRAINT equipar_fkey_torneo
  FOREIGN KEY (IdTorneo) REFERENCES Enfrentamiento (IdTorneo)
  ON DELETE CASCADE ON UPDATE CASCADE;

  ALTER TABLE Equipar ADD CONSTRAINT equipar_fkey_pokemon
  FOREIGN KEY (IdPokemon) REFERENCES Pokemon (IdPokemon)
  ON DELETE CASCADE ON UPDATE CASCADE;

  -- COMENTARIOS --

  -- Tabla
  COMMENT ON TABLE Equipar IS
  'Los pokémones que cada participante lleva al torneo de peleas.';

  -- Columnas
  COMMENT ON COLUMN Equipar.IdPersona IS
  'Identificador de la persona participante (BIGINT); llave foránea.';

  COMMENT ON COLUMN Equipar.IdTorneo IS
  'Identificador del torneo de peleas (BIGINT); llave foránea.';

  COMMENT ON COLUMN Equipar.IdPokemon IS
  'Identificador del pokemon usado en el torneo (INTEGER); llave foránea.';

  -- Constraints
  COMMENT ON CONSTRAINT equipar_fkey_participante ON Equipar IS
  'Llave primaria del Participante que registra los pokemones (IdPersona).';

  COMMENT ON CONSTRAINT equipar_fkey_torneo ON Equipar IS
  'Llave primaria del torneo de Enfrentamiento (IdTorneo).';

  COMMENT ON CONSTRAINT equipar_fkey_pokemon ON Equipar IS
  'Llave primaria del Pokemon inscrito (IdPokemon).';
