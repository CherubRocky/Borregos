----------------------------------------------------------
-- Disparadores para la Base de Datos del Torneo Pokémon--
----------------------------------------------------------

-- Valida que un participante no cuente con más de 6 pokémon en un mismo torneo
-- Cada participante puede tener hasta un máximo de 6 pokémon en un torneo específico pero no más.
create or replace function check_num_pokemones()
returns trigger as 
$$
declare
    pokemones integer; -- Variable donde guardaremos el conteo de pokémon del participante en el torneo
begin
    select count(*) into pokemones
    from Equipar
    where idPersona = new.idPersona
      and idTorneo = new.idTorneo;
    
    if TG_OP = 'INSERT' or 
       (TG_OP = 'UPDATE' and (NEW.idPersona != OLD.idPersona or NEW.idTorneo != OLD.idTorneo)) then
        pokemones := pokemones + 1;
    end if;

    if pokemones > 6 then
        raise exception 'Solamente se admiten hasta 6 pokémon por participante en un torneo.';
    end if;

    return new;
end;
$$
language plpgsql;
-- Trigger
create trigger trg_check_num_pokemones
before insert or update on Equipar
for each row
execute function check_num_pokemones();


-- Valida que un participante inscrito en un torneo de pelea no pueda estar en otro torneo.
-- Solamente puede estar en mas de un torneo un participante si no pertenece a un torneo de pelea.
create or replace function check_participante_en_torneos()
returns trigger as
$$
declare
    es_pelea_nuevo boolean;
    ya_en_pelea boolean;
begin
    -- Primero verificamos si el torneo nuevo es de pelea
    select exists (
        select 1 from enfrentamiento e where e.idtorneo = new.idtorneo
    ) into es_pelea_nuevo;

    -- Comprobamos si el participante ya está inscrito en algún torneo de pelea, no necesariamente el mismo
    select exists (
        select 1 from participar pa
        join enfrentamiento e on e.idtorneo = pa.idtorneo
        where pa.idpersona = new.idpersona
          and (TG_OP = 'INSERT' or pa.idtorneo <> new.idtorneo)
    ) into ya_en_pelea;

    -- Si ya está en un torneo de pelea, no puede inscribirse en ningún otro
    if ya_en_pelea then
        raise exception 'Un participante en torneo de pelea no puede estar en otros torneos.';
    end if;

    -- Si el torneo nuevo es de pelea y el participante ya está inscrito en otro torneo entonces no puede inscribirse
    if es_pelea_nuevo then
        if exists (
            select 1 from participar pa
            where pa.idpersona = new.idpersona
              and (TG_OP = 'INSERT' or pa.idtorneo <> new.idtorneo)
        ) then
            raise exception 'Un participante en torneo de pelea no puede estar en otros torneos.';
        end if;
    end if;

    return new;
end;
$$
language plpgsql;

-- Trigger sobre Participar
create trigger trg_check_participante_en_torneos
before insert or update on participar
for each row
execute function check_participante_en_torneos();


------------------------------------------------------------------
-- Procesos almacenados para la Base de Datos del Torneo Pokémon--
------------------------------------------------------------------

-- Procedimiento para mostrar a todos los participantes que están registrados y almacenados en nuestra base de datos.
create or replace procedure mostrar_informacion_participantes() as
$$
declare
    fila record;
    i int := 1;
begin
    for fila in
        select
            Participante.IdPersona,
            Persona.Nombre || ' ' || Persona.Paterno || ' ' || Persona.Materno as NombreCompleto,
            Participante.NoCuenta,
            Participante.Facultad,
            Participante.Carrera,
            calcular_edad_persona(Persona.FechaNacimiento) as Edad,
            Persona.Sexo
        from Participante
        join Persona on Participante.IdPersona = Persona.IdPersona
    loop
        raise notice 'Participante %: IdPersona = % | Nombre = % | NoCuenta = % | Facultad = % | Carrera = % | Edad = % | Sexo = %',
            i, fila.IdPersona, fila.NombreCompleto, fila.NoCuenta, fila.Facultad, fila.Carrera, fila.Edad, fila.Sexo;
        i := i + 1;
    end loop;
end;
$$
language plpgsql;

-- Procedimiento para convertir un Encargado en Participante para que pueda participar en diferentes torneos.
create or replace procedure encargado_a_participante(
    p_idpersona bigint,
    p_idtorneo bigint,
    p_nocuenta bit(9),
    p_facultad varchar,
    p_carrera varchar,
    p_ubicacion numeric,
    p_distancia numeric,
    p_hora time
) as
$$
declare
    existe int;
begin
    -- Primero nos aseguramos que el idPersona del Encargado exista
    select count(*) into existe from Encargado where IdPersona = p_idpersona;
    if existe = 0 then
        raise exception 'El IdPersona % no corresponde a ningún Encargado registrado, no fue posible la conversión a Participante.', p_idpersona;
    end if;

    -- Una vez que vemos que existe dicho encargado, lo insertamos ahora como un participante
    insert into Participante (
        IdPersona, IdTorneo, NoCuenta, Facultad, Carrera, Ubicacion, Distancia, Hora
    ) values (
        p_idpersona, p_idtorneo, p_nocuenta, p_facultad, p_carrera, p_ubicacion, p_distancia, p_hora
    );

    raise notice 'Encargado % convertido en participante y será participante del torneo %', p_idpersona, p_idtorneo;
end;
$$
language plpgsql;

-- Procedimiento para permitir el cambio de pokémon asociado a un participante en un torneo específico.
create or replace procedure cambiar_pokemon_participante(
    p_idpersona bigint,
    p_idtorneo bigint,
    p_idpokemon_old bigint,
    p_idpokemon_new bigint
) as
$$
declare
    existe_old int;
    existe_new int;
begin
    -- Verificamos que exista el pokémon antiguo asociado al participante en el torneo para poder garantizar el cambio
    select count(*) into existe_old
    from Equipar
    where idPersona = p_idpersona
      and idTorneo = p_idtorneo
      and idPokemon = p_idpokemon_old;

    if existe_old = 0 then
        raise exception 'El Pokémon antiguo no existe para este participante en el torneo.';
    end if;

    -- Nos aseguramos de que el nuevo pokémon pertenezca al participante mediante su cuenta
    select count(*) into existe_new
    from Pokemon
    where IdPokemon = p_idpokemon_new
      and CodigoEntrenador = (
          select CodigoEntrenador from Cuenta where IdPersona = p_idpersona
      );

    if existe_new = 0 then
        raise exception 'El nuevo Pokémon no forma parte de alguna de las cuentas del participante.';
    end if;

    -- Por ultimo, checamos que el nuevo pokémon a asignar no esté ya registrado en el torneo
    if exists (
        select 1 from Equipar
        where idPersona = p_idpersona
          and idTorneo = p_idtorneo
          and idPokemon = p_idpokemon_new
    ) then
        raise exception 'El Pokémon que se desea asignar ya está registrado para este participante en el torneo.';
    end if;

    -- Una vez validados las condiciones anteriores, procedemos ahora sí a hacer el cambio correspondiente
    delete from Equipar
    where idPersona = p_idpersona
      and idTorneo = p_idtorneo
      and idPokemon = p_idpokemon_old;

    insert into Equipar (idPersona, idTorneo, idPokemon)
    values (p_idpersona, p_idtorneo, p_idpokemon_new);

    raise notice 'El proceso de cambio de pokémon para el participante % en el torneo % se realizó con éxito.', p_idpersona, p_idtorneo;
end;
$$
language plpgsql;


--------------------------------------------------------------------------------------------------
-- Funciones para los atributos derivados/calculados de nuestra Base de Datos del Torneo Pokémon--
--------------------------------------------------------------------------------------------------

-- Calcular edad de una Persona
create or replace function calcular_edad_persona(fecha_nacimiento DATE)
returns integer as
$$
begin
    return date_part('year', age(current_date, fecha_nacimiento));
end;
$$
language plpgsql;

-- Calcular edad de un Espectador
create or replace function calcular_edad_espectador(fecha_nacimiento DATE)
returns integer as
$$
begin
    return date_part('year', age(current_date, fecha_nacimiento));
end;
$$
language plpgsql;

-- Calcular y dar el precio final de una Venta con IVA incluido
create or replace function calcular_iva_venta(total_sin_iva MONEY)
returns money as
$$
begin
    if total_sin_iva is null then
        return null;
    end if;
    return (total_sin_iva * 0.16) + total_sin_iva;
end;
$$
language plpgsql;

-- Calcular el pago correspondiente a un Encargado según el número de personas que registró
create or replace function calcular_pago_encargado(registros INT)
returns money as
$$
begin 
    return registros * 50;
end;
$$
language plpgsql;

-- Calcular el pago correspondiente a un Vendedor según las ganancias generadas en sus ventas.
create or replace function calcular_pago_vendedor(id_vendedor bigint)
returns money as
$$
declare
    total_ganancia money := 0;
begin
    select sum((TotalSinIva * 0.16)) into total_ganancia
    from Venta
    where IdPersona = id_vendedor;

    return total_ganancia * 0.25;
end;
$$
language plpgsql;