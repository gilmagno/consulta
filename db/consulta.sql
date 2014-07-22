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
       date timestamp with time zone,
       text text,
       status varchar,
       created timestamp with time zone,
       updated timestamp with time zone
);

create table consultations (
       id serial primary key,
       register_id int references users,
       patient_id int references users,
       date date,
       text text,
       status varchar,
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

----------------------------------------------------------------------

insert into users (name) values ('Super Admin');
insert into users_roles (user_id, role_id) values (1, 1);

insert into users (name) values ('Admin');
insert into clients_users (user_id, client_id) values (2, 1);
insert into users_roles (user_id, role_id) values (2, 2);

insert into users (name) values ('Carlos Moura');
insert into clients_users (user_id, client_id) values (3, 1);
insert into users_roles (user_id, role_id) values (3, 3);

insert into users (name, rg, cpf, phone, email) values ('Gil Magno Silva', '2001010123123', '002.342.123-43', '(85) 9934-2849', 'gil@gmail.com');
insert into clients_users (user_id, client_id) values (4, 1);
insert into users_roles (user_id, role_id) values (4, 5);

insert into users (name) values ('Carlos Eça Figueiras');
insert into clients_users (user_id, client_id) values (5, 1);
insert into users_roles (user_id, role_id) values (5, 5);

insert into users (name) values ('Renato Germano Silva');
insert into clients_users (user_id, client_id) values (6, 1);
insert into users_roles (user_id, role_id) values (6, 5);

----------------------------------------------------------------------

insert into consultations (register_id, patient_id, date, text, status) values
       (3, 4, '2003-02-01', 'Paciente solicitou checagem completa. Solicitei homograma. Auscutei e encontrei estado normal. Chequei pulmões, normal. Chequei pressão e temperatura, normal.
Falou que tem tido febre, mas agora está melhor. Não está sob nenhuma medicação no momento.', 'done');

insert into consultations (register_id, patient_id, date, text, status) values
       (3, 4,  '2003-02-15', 'Paciente retornou com o exame solicitado e outros. Indicam normalidade. Paciente afirma estar bem melhor. Aconselhei repouso e que retornasse em duas semanas.', 'done');

insert into consultations (register_id, patient_id, date, text, status) values
       (3, 4, '2003-02-27', 'Paciente afirma não estar sentido mais nenhum incômodo físico.', 'done');
