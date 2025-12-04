-- Ediciones de torneo
insert into EdicionTorneo (IdEdicion, NumeroEdicion, FechaEvento, Nota) values (1, 1, '2024-12-06', 'Sin Notas');
insert into EdicionTorneo (IdEdicion, NumeroEdicion, FechaEvento, Nota) values (2, 2, '2025-06-07', 'Sin Notas');
insert into EdicionTorneo (IdEdicion, NumeroEdicion, FechaEvento, Nota) values (3, 3, '2025-12-03', 'Sin Notas');

insert into Torneo (IdTorneo, IdEdicion, Inicio, Final) values (1, 1, '7:00:00', '21:00:00');
insert into Torneo (IdTorneo, IdEdicion, Inicio, Final) values (2, 1, '7:00:00', '21:00:00');
insert into Torneo (IdTorneo, IdEdicion, Inicio, Final) values (3, 1, '7:00:00', '21:00:00');
insert into Torneo (IdTorneo, IdEdicion, Inicio, Final) values (4, 2, '7:00:00', '21:00:00');
insert into Torneo (IdTorneo, IdEdicion, Inicio, Final) values (5, 2, '7:00:00', '21:00:00');
insert into Torneo (IdTorneo, IdEdicion, Inicio, Final) values (6, 2, '7:00:00', '21:00:00');
insert into Torneo (IdTorneo, IdEdicion, Inicio, Final) values (7, 3, '7:00:00', '21:00:00');
insert into Torneo (IdTorneo, IdEdicion, Inicio, Final) values (8, 3, '7:00:00', '21:00:00');
insert into Torneo (IdTorneo, IdEdicion, Inicio, Final) values (9, 3, '7:00:00', '21:00:00');

insert into Enfrentamiento (IdTorneo) values (1);
insert into Recorrido (IdTorneo) values (2);
insert into CapturaShiny (IdTorneo) values (3);

insert into Enfrentamiento (IdTorneo) values (4);
insert into Recorrido (IdTorneo) values (5);
insert into CapturaShiny (IdTorneo) values (6);

insert into Enfrentamiento (IdTorneo) values (7);
insert into Recorrido (IdTorneo) values (8);
insert into CapturaShiny (IdTorneo) values (9);
