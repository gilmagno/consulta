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

       username varchar unique,
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

create table user_roles (
       user_id int references users,
       role_id int references roles,
       primary key (user_id, role_id)
);

create table role_actions (
       role_id int references roles,
       action_id int references actions,
       primary key (role_id, action_id)
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


--------------------------------------------------------------------------------

create table medicines (
       id serial primary key,
       name varchar -- exemplo: "Azitromicina 500mg comp"
);

create table prescriptions_medicines (
       id serial primary key,

       doctor_id int references users,
       patient_id int references users,
       date date,

       use_method varchar, -- exemplo: uso tópico, uso oral etc.
       medicine_id int references medicines,
       quantity varchar, -- exemplo: 4
       unity varchar, -- exemplo: comprimidos, gotas, caixas etc.
       text text,

       created timestamp with time zone,
       updated timestamp with time zone
);

create table prescriptions_glasses (
       id serial primary key,

       doctor_id int references users,
       patient_id int references users,
       date date,

       spherical_right int,
       spherical_left int,
       cilindrical_right int,
       cilindrical_left int,
       axis_right int,
       axis_left int,
       npd_right int,
       npd_left int,
       add int,

       text text,
       created timestamp with time zone,
       updated timestamp with time zone
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
-- admin pode ver conteúdo das consultas? privacidade?
-- insert into role_actions (role_id, action_id) values (2, 7);
insert into role_actions (role_id, action_id) values (2,  8);
insert into role_actions (role_id, action_id) values (2,  9);

insert into role_actions (role_id, action_id) values (2, 10);
insert into role_actions (role_id, action_id) values (2, 11);
insert into role_actions (role_id, action_id) values (2, 12);
insert into role_actions (role_id, action_id) values (2, 13);
insert into role_actions (role_id, action_id) values (2, 14);
insert into role_actions (role_id, action_id) values (2, 15);

-- Médico
insert into role_actions (role_id, action_id) values (3,  1); -- users
insert into role_actions (role_id, action_id) values (3,  2);
insert into role_actions (role_id, action_id) values (3,  3);
insert into role_actions (role_id, action_id) values (3,  4);
insert into role_actions (role_id, action_id) values (3,  5);

insert into role_actions (role_id, action_id) values (3,  6); -- consultations
insert into role_actions (role_id, action_id) values (3,  7);
insert into role_actions (role_id, action_id) values (3,  8);
insert into role_actions (role_id, action_id) values (3,  9);
insert into role_actions (role_id, action_id) values (3, 10);

insert into role_actions (role_id, action_id) values (3, 11); -- appointments
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
-- atendente pode ver conteúdo das consultas? privacidade?
-- insert into role_actions (role_id, action_id) values (4, 7);

insert into role_actions (role_id, action_id) values (4, 11); -- appointments
insert into role_actions (role_id, action_id) values (4, 12);
insert into role_actions (role_id, action_id) values (4, 13);
insert into role_actions (role_id, action_id) values (4, 14);
insert into role_actions (role_id, action_id) values (4, 15);

-- Paciente
insert into role_actions (role_id, action_id) values (5, 2); -- users_view_details
insert into role_actions (role_id, action_id) values (5, 6); -- consultations_view_list
insert into role_actions (role_id, action_id) values (5, 7); -- consultations_view_details

insert into role_actions (role_id, action_id) values (5, 10); -- appointments_view_list
insert into role_actions (role_id, action_id) values (5, 11); -- appointments_view_details

----------------------------------------------------------------------

insert into users (name, username, password, rg, cpf, phone, email)
values ('Super Admin', 'superadmin', 'senha', '', '',
        '(85) 6234-6913', 'superadmin@gmail.com');
insert into user_roles    (user_id, role_id)   values (1, 1);

insert into users (name, username, password, rg, cpf, phone, email)
values ('Fortalclinic Admin', 'admin', 'senha', '', '',
        '(85) 4234-6913', 'admin@gmail.com');
insert into clients_users (user_id, client_id) values (2, 1);
insert into user_roles    (user_id, role_id)   values (2, 2);

insert into users (name, username, password, rg, cpf, phone, email)
values ('Carlos Moura', 'carlosmoura', 'senha', '200873465123123', '245.376.873-43',
        '(85) 9234-6913', 'carlosmoura@gmail.com');
insert into clients_users (user_id, client_id) values (3, 1);
insert into user_roles    (user_id, role_id)   values (3, 3);

insert into users (name, username, password, rg, cpf, phone, email)
values ('Paulo Sampaio', 'paulosampaio', 'senha', '20043210123123', '232.322.563-43',
        '(85) 8715-5490', 'paulosampaio@gmail.com');
insert into clients_users (user_id, client_id) values (4, 1);
insert into user_roles    (user_id, role_id)   values (4, 4);

insert into users (name, username, password, rg, cpf, phone, email)
values ('Gil Magno Silva', 'gilmagno', 'senha', '2001010123123', '002.342.123-43',
        '(85) 9934-2849', 'gilmagno@gmail.com');
insert into clients_users (user_id, client_id) values (5, 1);
insert into user_roles    (user_id, role_id)   values (5, 5);

insert into users (name, username, password, rg, cpf, phone, email)
values ('Pedro Moreira', 'pedro', '', '203464123123', '002.645.323-43',
        '(85) 5123-5243', 'pedrovillagran@gmail.com');
insert into clients_users (user_id, client_id) values (6, 1);
insert into user_roles    (user_id, role_id)   values (6, 5);

insert into users (name, username, password, rg, cpf, phone, email)
values ('Flora Morais', 'flora', '', '263670910123123', '202.442.323-43',
        '(85) 9934-2849', 'florinda@gmail.com');
insert into clients_users (user_id, client_id) values (7, 1);
insert into user_roles    (user_id, role_id)   values (7, 5);

insert into users (name, username, password, rg, cpf, phone, email)
values ('Ramon Cardoso', 'ramon', '', '2837465123123', '402.442.523-43',
        '(85) 9454-4549', 'ramon@gmail.com');
insert into clients_users (user_id, client_id) values (8, 1);
insert into user_roles    (user_id, role_id)   values (8, 5);

insert into users (name, username, password, rg, cpf, phone, email)
values ('Hector Silveira', 'hector', '', '347610123123', '502.342.423-43',
        '(85) 5634-2349', 'hector@gmail.com');
insert into clients_users (user_id, client_id) values (9, 1);
insert into user_roles    (user_id, role_id)   values (9, 5);

insert into users (name, username, password, rg, cpf, phone, email)
values ('Roberto Silva', 'roberto', '', '200234234123123', '202.442.423-43',
        '(85) 9214-2849', 'roberto@gmail.com');
insert into clients_users (user_id, client_id) values (10, 1);
insert into user_roles    (user_id, role_id)   values (10, 5);

insert into users (name, username, password, rg, cpf, phone, email)
values ('Roger Carvalho', 'roger', '', '201231234123123', '242.542.423-43',
        '(85) 2344-2849', 'roger@gmail.com');
insert into clients_users (user_id, client_id) values (11, 1);
insert into user_roles    (user_id, role_id)   values (11, 5);

insert into users (name, username, password, rg, cpf, phone, email)
values ('Amanda Teixeira', 'amanda', '', '2340234234123123', '202.412.323-43',
        '(85) 9344-4249', 'amanda@gmail.com');
insert into clients_users (user_id, client_id) values (12, 1);
insert into user_roles    (user_id, role_id)   values (12, 5);

----------------------------------------------------------------------

insert into medicines (name) values ('Azitromicina 500mg comp');

----------------------------------------------------------------------

insert into prescriptions_medicines (doctor_id, patient_id, date, use_method, medicine_id, quantity, unity, text)
values (3, 5, '2014-08-01', 'Uso oral', '1', '1', 'caixa', 'Um comprimido a cada 12 horas');

insert into prescriptions_medicines (doctor_id, patient_id, date, use_method, medicine_id, quantity, unity, text)
values (3, 5, '2014-03-07', 'Uso oral', '1', '1', 'caixa', 'Um comprimido a cada 24 horas');

----------------------------------------------------------------------

insert into consultations (register_id, patient_id, date, text) values
(3, 5, '2003-02-01', 'Paciente solicitou exames para checagem completa de seu estado. Solicitei hemograma. Auscutei e encontrei estado normal. Chequei pulmões, normal. Chequei pressão e temperatura, normal.
Falou que tem tido febre, mas agora está melhor. Não está sob nenhuma medicação no momento.');

insert into consultations (register_id, patient_id, date, text) values
(3, 5,  '2003-02-15', 'Paciente retornou com o exame solicitado e outros. Indicam normalidade. Paciente afirma estar bem melhor. Aconselhei repouso e que retornasse em duas semanas.');

insert into consultations (register_id, patient_id, date, text) values
(3, 5, '2003-02-27', 'Paciente afirma não estar sentido mais nenhum incômodo físico.');

insert into consultations (register_id, patient_id, date, text) values
(3, 5, '2003-03-27', 'Checagem geral. Solicitei vários exames.');

insert into consultations (register_id, patient_id, date, text) values
(3, 5, '2003-04-27', 'Retorno.');

----------------------------------------------------------------------

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-06-30 14:30', null, 'Concluído', null, null);





insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-01 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-01 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-01 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-01 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-01 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-01 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-01 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-01 18:30', null, 'Concluído', null, null);




insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-02 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-02 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-02 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-02 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-02 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-02 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-02 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-02 18:30', null, 'Concluído', null, null);



insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-03 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-03 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-03 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-03 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-03 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-03 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-03 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-03 18:30', null, 'Concluído', null, null);



insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-04 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-04 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-04 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-04 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-04 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-04 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-04 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-04 18:30', null, 'Concluído', null, null);



insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-07 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-07 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-07 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-07 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-07 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-07 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-07 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-07 18:30', null, 'Concluído', null, null);



insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-08 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-08 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-08 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-08 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-08 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-08 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-08 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-08 18:30', null, 'Concluído', null, null);



insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-09 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-09 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-09 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-09 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-09 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-09 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-09 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-09 18:30', null, 'Concluído', null, null);



insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-10 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-10 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-10 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-10 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-10 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-10 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-10 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-10 18:30', null, 'Concluído', null, null);




insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-11 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-11 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-11 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-11 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-11 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-11 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-11 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-11 18:30', null, 'Concluído', null, null);




insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-14 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-14 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-14 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-14 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-14 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-14 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-14 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-14 18:30', null, 'Concluído', null, null);




insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-15 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-15 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-15 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-15 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-15 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-15 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-15 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-15 18:30', null, 'Concluído', null, null);




insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-16 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-16 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-16 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-16 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-16 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-16 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-16 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-16 18:30', null, 'Concluído', null, null);






insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-17 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-17 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-17 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-17 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-17 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-17 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-17 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-17 18:30', null, 'Concluído', null, null);






insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-18 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-18 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-18 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-18 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-18 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-18 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-18 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-18 18:30', null, 'Concluído', null, null);





insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-21 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-21 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-21 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-21 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-21 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-21 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-21 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-21 18:30', null, 'Concluído', null, null);







insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-22 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-22 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-22 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-22 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-22 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-22 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-22 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-22 18:30', null, 'Concluído', null, null);







insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-23 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-23 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-23 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-23 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-23 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-23 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-23 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-23 18:30', null, 'Concluído', null, null);







insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-24 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-24 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-24 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-24 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-24 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-24 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-24 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-24 18:30', null, 'Concluído', null, null);







insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-28 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-28 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-28 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-28 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-28 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-28 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-28 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-28 18:30', null, 'Concluído', null, null);






insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-29 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-29 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-29 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-29 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-29 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-29 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-29 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-29 18:30', null, 'Concluído', null, null);





insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-25 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-25 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-25 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-25 14:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-25 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-25 16:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-25 17:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-25 18:30', null, 'Concluído', null, null);



insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 5, '2014-07-30 09:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 6, '2014-07-30 10:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 7, '2014-07-30 11:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 8, '2014-07-30 14:30', null, 'Inconcluso', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 9, '2014-07-30 15:30', null, 'Concluído', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 10, '2014-07-30 16:30', null, 'Confirmado', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 11, '2014-07-30 17:30', null, 'Marcado', null, null);

insert into appointments (register_id, doctor_id, patient_id, date_time,
                          text, status, created, updated) values
(4, 3, 12, '2014-07-30 18:30', null, 'Marcado', null, null);


