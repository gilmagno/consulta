create table states (
       id serial primary key,
       name varchar,
       abbreviation varchar
);

create table cities (
       id serial primary key,
       state_id int references states,
       name varchar
);

----------------------------------------------------------------------

create table clients (
       id serial primary key,
       name varchar,
       created timestamp with time zone,
       updated timestamp with time zone
);

create table clients_users (
       client_id int,
       user_id int,
       primary key (client_id, user_id)
);       

----------------------------------------------------------------------

create table users (
       id serial primary key,

       username varchar,
       password varchar,

       name varchar,
       rg varchar,
       cpf varchar,

       address_state_id          int references states,
       address_city_id           int references cities,
       address_street_etc        varchar, -- Rua, número, complemento
       address_district          varchar, -- ¡Barrio!
       address_zip_code          varchar, -- CEP

       phone varchar,
       phone2 varchar,

       -- Comentários nos telefones. Exemplo: "TIM", "Oi"
       -- phone_comment varchar,
       -- phone2_comment varchar,

       -- Qual(is) telefone(s) deve(m) receber SMS?
       -- phone_sms_check boolean,
       -- phone2_sms_check boolean,

       email varchar,
       email2 varchar,

       created timestamp with time zone,
       updated timestamp with time zone
);

create table roles (
       id serial primary key,
       name varchar
);

create table actions (
       id serial primary key,
       name varchar
);

create table users_roles (
       user_id int references users,
       role_id int references roles,
       primary key (user_id, role_id)
);

create table role_actions (
       id serial primary key,
       role_id int,
       action_id int
);

----------------------------------------------------------------------

create table appointments (
       id serial primary key,
       register_id int references users,
       doctor_id int references users,
       patient_id int references users,
       date_time timestamp with time zone,
       text text,
       status varchar, -- todo ou done
       created timestamp with time zone,
       updated timestamp with time zone
);

create table consultations (
       id serial primary key,
       register_id int references users,
       patient_id int references users,
       date date,
       text text,
       created timestamp with time zone,
       updated timestamp with time zone
);

create table consultation_files (
       id serial primary key,
       consultation_id int references consultations,
       filename varchar
);

----------------------------------------------------------------------
----------------------------------------------------------------------

insert into states (name, abbreviation) values ('CE', 'Ceará');
insert into cities (state_id, name) values (1, 'Fortaleza');

insert into clients (name) values ('Fortal Clinic');

insert into roles (name) values ('Super Admin');
insert into roles (name) values ('Admin');
insert into roles (name) values ('Médico');
insert into roles (name) values ('Atendente');
insert into roles (name) values ('Paciente');

insert into actions (name) values ('users_view_list');
insert into actions (name) values ('users_view_details');
insert into actions (name) values ('users_create');
insert into actions (name) values ('users_edit');
insert into actions (name) values ('users_delete');

insert into actions (name) values ('consultations_view_list');    --  6
insert into actions (name) values ('consultations_view_details'); --  7
insert into actions (name) values ('consultations_create');       --  8
insert into actions (name) values ('consultations_edit');         --  9
insert into actions (name) values ('consultations_delete');       -- 10

insert into actions (name) values ('appointments_view_list');
insert into actions (name) values ('appointments_view_details');
insert into actions (name) values ('appointments_create');
insert into actions (name) values ('appointments_edit');
insert into actions (name) values ('appointments_delete');

  -- Super Admin
insert into role_actions (role_id, action_id) values (1,  1);
insert into role_actions (role_id, action_id) values (1,  2);
insert into role_actions (role_id, action_id) values (1,  3);
insert into role_actions (role_id, action_id) values (1,  4);
insert into role_actions (role_id, action_id) values (1,  5);
insert into role_actions (role_id, action_id) values (1,  6);
insert into role_actions (role_id, action_id) values (1,  7);
insert into role_actions (role_id, action_id) values (1,  8);
insert into role_actions (role_id, action_id) values (1,  9);
insert into role_actions (role_id, action_id) values (1, 10);
insert into role_actions (role_id, action_id) values (1, 11);
insert into role_actions (role_id, action_id) values (1, 12);
insert into role_actions (role_id, action_id) values (1, 13);
insert into role_actions (role_id, action_id) values (1, 14);
insert into role_actions (role_id, action_id) values (1, 15);

  -- Admin
insert into role_actions (role_id, action_id) values (2,  1);
insert into role_actions (role_id, action_id) values (2,  2);
insert into role_actions (role_id, action_id) values (2,  3);
insert into role_actions (role_id, action_id) values (2,  4);
insert into role_actions (role_id, action_id) values (2,  5);
insert into role_actions (role_id, action_id) values (2,  6);
insert into role_actions (role_id, action_id) values (2,  7);
insert into role_actions (role_id, action_id) values (2,  8);
insert into role_actions (role_id, action_id) values (2,  9);
insert into role_actions (role_id, action_id) values (2, 10);
insert into role_actions (role_id, action_id) values (2, 11);
insert into role_actions (role_id, action_id) values (2, 12);
insert into role_actions (role_id, action_id) values (2, 13);
insert into role_actions (role_id, action_id) values (2, 14);
insert into role_actions (role_id, action_id) values (2, 15);

  -- Médico
insert into role_actions (role_id, action_id) values (3,  1);
insert into role_actions (role_id, action_id) values (3,  2);
insert into role_actions (role_id, action_id) values (3,  3);
insert into role_actions (role_id, action_id) values (3,  4);
insert into role_actions (role_id, action_id) values (3,  5);
insert into role_actions (role_id, action_id) values (3,  6);
insert into role_actions (role_id, action_id) values (3,  7);
insert into role_actions (role_id, action_id) values (3,  8);
insert into role_actions (role_id, action_id) values (3,  9);
insert into role_actions (role_id, action_id) values (3, 10);
insert into role_actions (role_id, action_id) values (3, 11);
insert into role_actions (role_id, action_id) values (3, 12);
insert into role_actions (role_id, action_id) values (3, 13);
insert into role_actions (role_id, action_id) values (3, 14);
insert into role_actions (role_id, action_id) values (3, 15);

  -- Atendente
insert into role_actions (role_id, action_id) values (4, 1); -- users
insert into role_actions (role_id, action_id) values (4, 2);
insert into role_actions (role_id, action_id) values (4, 3);
insert into role_actions (role_id, action_id) values (4, 4);

insert into role_actions (role_id, action_id) values (4, 6); -- consultations
insert into role_actions (role_id, action_id) values (4, 7);

insert into role_actions (role_id, action_id) values (4, 11); -- appointments
insert into role_actions (role_id, action_id) values (4, 12);
insert into role_actions (role_id, action_id) values (4, 13);
insert into role_actions (role_id, action_id) values (4, 14);
insert into role_actions (role_id, action_id) values (4, 15);

  -- Paciente
insert into role_actions (role_id, action_id) values (5, 2); -- users_view_details
insert into role_actions (role_id, action_id) values (5, 6); -- consultations_view_list
insert into role_actions (role_id, action_id) values (5, 7); -- consultations_view_details

----------------------------------------------------------------------

insert into users (name) values ('Super Admin');
insert into users_roles (user_id, role_id) values (1, 1);

insert into users (name) values ('Admin');
insert into clients_users (user_id, client_id) values (2, 1);
insert into users_roles (user_id, role_id) values (2, 2);

insert into users (name, username, password) values ('Carlos Moura', 'carlosmoura', 'senha');
insert into clients_users (user_id, client_id) values (3, 1);
insert into users_roles (user_id, role_id) values (3, 3);

insert into users (name, username, password, rg, cpf, phone, email) values ('Gil Magno Silva', 'gilmagno', 'senha', '2001010123123', '002.342.123-43', '(85) 9934-2849', 'gil@gmail.com');
insert into clients_users (user_id, client_id) values (4, 1);
insert into users_roles (user_id, role_id) values (4, 5);

insert into users (name) values ('Carlos Eça Figueiras');
insert into clients_users (user_id, client_id) values (5, 1);
insert into users_roles (user_id, role_id) values (5, 5);

insert into users (name) values ('Renato Germano Silva');
insert into clients_users (user_id, client_id) values (6, 1);
insert into users_roles (user_id, role_id) values (6, 5);

----------------------------------------------------------------------

insert into consultations (register_id, patient_id, date, text) values
(3, 4, '2003-02-01', 'Paciente solicitou checagem completa. Solicitei homograma. Auscutei e encontrei estado normal. Chequei pulmões, normal. Chequei pressão e temperatura, normal.
Falou que tem tido febre, mas agora está melhor. Não está sob nenhuma medicação no momento.');

insert into consultations (register_id, patient_id, date, text) values
(3, 4,  '2003-02-15', 'Paciente retornou com o exame solicitado e outros. Indicam normalidade. Paciente afirma estar bem melhor. Aconselhei repouso e que retornasse em duas semanas.');

insert into consultations (register_id, patient_id, date, text) values
(3, 4, '2003-02-27', 'Paciente afirma não estar sentido mais nenhum incômodo físico.');
