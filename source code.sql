--4
create table simptome(
    id_simptom NUMBER(6,0) primary key,
    nume VARCHAR2(30 BYTE)
    );

create table medic_familie(
    id_medic NUMBER(6,0) primary key,
    nume VARCHAR2(30 BYTE),
    prenume VARCHAR2(30 BYTE),
    bolnavi_in_lista NUMBER(6,0),
    telefon VARCHAR2(30 BYTE)
);

create table comorbiditati(
    id_comorbiditate NUMBER(6,0) primary key,
    nume VARCHAR2(30 BYTE)
);

create table familie(
    id_familie NUMBER(6,0) primary key,
    membri NUMBER(6,0)
);

create table job(
    id_job NUMBER(6,0) primary key
);


create table DSP(
    id_DSP NUMBER(6,0) primary key,
    nr_teste_pozitive NUMBER(6,0),
    nr_teste_negative NUMBER(6,0),
    telefon VARCHAR2(30 BYTE)
);
create table judet(
    id_judet NUMBER(6, 0) primary key,
    nume VARCHAR2(30 BYTE),
    id_DSP NUMBER(6,0),
    foreign key (id_DSP) references DSP(id_DSP) 
);

create table localitate(
    id_localitate NUMBER(6,0) primary key,
    tip VARCHAR2(30 BYTE),
    nume VARCHAR2(30 BYTE),
    id_judet NUMBER(6, 0),
    foreign key(id_judet) references judet(id_judet)
);

create table centru_testare(
    id_centru NUMBER(6,0) primary key,
    id_localitate NUMBER(6,0),
    nume VARCHAR2(30 BYTE),
    numar_teste_pozitive NUMBER(6,0),
    numar_teste_negative NUMBER(6,0),
    foreign key(id_localitate) references localitate(id_localitate)
);

create table pacient(
    id_pacient NUMBER(6,0) primary key,
    nume VARCHAR2(30 BYTE),
    prenume VARCHAR2(30 BYTE),
    sex VARCHAR2(30 BYTE),
    telefon VARCHAR2(30 BYTE),
    mail VARCHAR2(30 BYTE),
    id_familie NUMBER(6,0),
    id_job NUMBER(6,0),
    id_medic NUMBER(6,0),
    id_localitate NUMBER(6,0),  
    data_nasterii DATE,
    foreign key(id_familie) references familie(id_familie), --nu pot sterge o familie
    foreign key(id_job) references job(id_job) on delete set null, --pot exista pacienti fara job
    foreign key(id_medic) references medic_familie(id_medic) on delete set null, --daca medicul de familie dispare, pacientul ramane cu id null -> nu e inregistrat
    foreign key(id_localitate) references localitate(id_localitate),
    constraint gender_ck CHECK(sex in ('BARBAT', 'FEMEIE')) --verific ca sexul pacientului sa fie unul dintre cele doua
);


create table pozitiv(
    id_pacient_p NUMBER(6,0) primary key,
    pana_la_data DATE,
    de_la_data DATE,
    foreign key(id_pacient_p) references pacient(id_pacient) on delete cascade
);


create table negativ(
    id_pacient_n NUMBER(6,0) primary key,
    foreign key(id_pacient_n) references pacient(id_pacient) on delete cascade
);

create table test(
    id_test NUMBER(6,0) primary key,
    id_pacient NUMBER(6,0),
    rezultat VARCHAR2(30 BYTE),
    id_centru NUMBER(6,0),
    data_test DATE,
    foreign key(id_pacient) references pacient(id_pacient) on delete set null, --daca dispare pacientul, inca vreau sa stiu numarul de teste 
    foreign key(id_centru) references centru_testare(id_centru) --centrul nu poate disparea
);


create table job_fizic(
    id_job_f NUMBER(6,0) primary key,
    angajati NUMBER(6,0),
    foreign key(id_job_f) references job(id_job) on delete cascade
);


create table job_remote(
    id_job_r NUMBER(6,0)primary key,
    foreign key(id_job_r) references job(id_job) on delete cascade
);

create table simptome_pacient(
    id_pacient NUMBER(6,0),
    id_simptom NUMBER(6,0),
    primary key(id_simptom, id_pacient),
    foreign key(id_pacient) references pacient(id_pacient) on delete set null, --daca ma intereseaza numarul de pacienti cu respectivul simptom, dupa stergerea lui din BD
    foreign key(id_simptom) references simptome(id_simptom) on delete cascade  --daca un simptom nu mai e considerat relevant, sterg intrarea
);


create table comorbiditati_pacient(
    id_pacient NUMBER(6,0),
    id_comorbiditate NUMBER(6,0),
    primary key(id_comorbiditate, id_pacient),
    foreign key(id_pacient) references pacient(id_pacient) on delete cascade,   --aici, constrangerea e relevanta pentru pacient, nu fac statistici pe comorbiditati
    foreign key(id_comorbiditate) references comorbiditati(id_comorbiditate) on delete cascade 
);

--5 INSERT
create sequence DSP_seq
start with 1 
increment by 1
NOCACHE
NOCYCLE;

insert into DSP values (dsp_seq.nextval, 0, 0, '0258 835 243'); --Alba
insert into DSP values (dsp_seq.nextval, 0, 0, '0257 254 438'); --Arad
insert into DSP values (dsp_seq.nextval, 0, 0, '0248 216 484'); --Arges
insert into DSP values (dsp_seq.nextval, 0, 0, '0234 512 850'); --Bacau
insert into DSP values (dsp_seq.nextval, 0, 0, '0259 434 565'); --Bihor
insert into DSP values (dsp_seq.nextval, 0, 0, '0263 232 601'); --Bistrita-Nasaud
insert into DSP values (dsp_seq.nextval, 0, 0, '0231 513 525'); --Botosani
insert into DSP values (dsp_seq.nextval, 0, 0, '0268 417 049'); --Brasov
insert into DSP values (dsp_seq.nextval, 0, 0, '0239 613 505'); --Braila
insert into DSP values (dsp_seq.nextval, 0, 0, '021 252 7978'); --Bucuresti
insert into DSP values (dsp_seq.nextval, 0, 0, '0238 725 690'); --Buzau
insert into DSP values (dsp_seq.nextval, 0, 0, '0255 214 091'); --Caras-Severin
insert into DSP values (dsp_seq.nextval, 0, 0, '0242 311 462'); --Calarasi
insert into DSP values (dsp_seq.nextval, 0, 0, '0264 433 645'); --Cluj
insert into DSP values (dsp_seq.nextval, 0, 0, '0241 838 330'); --Constanta
insert into DSP values (dsp_seq.nextval, 0, 0, '0267 351 398'); --Covasna
insert into DSP values (dsp_seq.nextval, 0, 0, '0245 214 952'); --Dambovita
insert into DSP values (dsp_seq.nextval, 0, 0, '0251 310 067'); --Dolj
insert into DSP values (dsp_seq.nextval, 0, 0, '0236 463 704'); --Galati
insert into DSP values (dsp_seq.nextval, 0, 0, '0246 214 176'); --Giurgiu
insert into DSP values (dsp_seq.nextval, 0, 0, '0253 210 156'); --Gorj
insert into DSP values (dsp_seq.nextval, 0, 0, '0266 310 423'); --Harghita
insert into DSP values (dsp_seq.nextval, 0, 0, '021 414 4454'); --Hunedoara
insert into DSP values (dsp_seq.nextval, 0, 0, '0243 230 280'); --Ialomita
insert into DSP values (dsp_seq.nextval, 0, 0, '0232 210 900'); --Iasi
insert into DSP values (dsp_seq.nextval, 0, 0, '021 224 4596'); --Ilfov
insert into DSP values (dsp_seq.nextval, 0, 0, '0262 276 501'); --Maramures
insert into DSP values (dsp_seq.nextval, 0, 0, '0214 144 452'); --Mehedinti
insert into DSP values (dsp_seq.nextval, 0, 0, '0265 261 152'); --Mures
insert into DSP values (dsp_seq.nextval, 0, 0, '0233 213 874'); --Neamt
insert into DSP values (dsp_seq.nextval, 0, 0, '0372 394 714'); --Olt
insert into DSP values (dsp_seq.nextval, 0, 0, '0244 543 433'); --Prahova
insert into DSP values (dsp_seq.nextval, 0, 0, '0261 768 101'); --Satu Mare
insert into DSP values (dsp_seq.nextval, 0, 0, '0260 662 550'); --Salaj
insert into DSP values (dsp_seq.nextval, 0, 0, '0269 210 071'); --Sibiu
insert into DSP values (dsp_seq.nextval, 0, 0, '0230 514 557'); --Suceava
insert into DSP values (dsp_seq.nextval, 0, 0, '0247 311 221'); --Teleorman
insert into DSP values (dsp_seq.nextval, 0, 0, '0256 494 680'); --Timis
insert into DSP values (dsp_seq.nextval, 0, 0, '0240 534 134'); --Tulcea
insert into DSP values (dsp_seq.nextval, 0, 0, '0235 312 455'); --Vaslui
insert into DSP values (dsp_seq.nextval, 0, 0, '0250 747 720'); --Valcea
insert into DSP values (dsp_seq.nextval, 0, 0, '0237 225 979');  --Vrancea

drop sequence DSP_seq;
create sequence DSP_seq
start with 1 
increment by 1
NOCACHE
NOCYCLE;

create sequence JUD_seq
start with 1 
increment by 1
NOCACHE
NOCYCLE;

insert into judet values (jud_seq.nextval, 'Alba' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Arad' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Arges' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Bacau' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Bihor' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Bistrita-Nasaud' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Botosani' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Brasov' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Braila' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Bucuresti' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Buzau' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Caras-Severin' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Calarasi' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Cluj' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Constanta' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Covasna' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Dambovita' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Dolj' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Galati' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Giurgiu' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Gorj' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Harghita' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Hunedoara' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Ialomita' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Iasi' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Ilfov' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Maramures' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Mehedinti' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Mures' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Neamt' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Olt' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Prahova' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Satu-Mare' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Salaj' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Sibiu' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Suceava' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Teleroman' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Timis' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Tulcea' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Vaslui' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Valcea' ,dsp_seq.nextval);
insert into judet values (jud_seq.nextval, 'Vrancea' ,dsp_seq.nextval);

select *
from judet;

create sequence localitate_seq
start with 1
increment by 1
nocache
nocycle;

insert into localitate values(localitate_seq.nextval, 'oras', 'Alba Iulia', 1);
insert into localitate values(localitate_seq.nextval, 'sat', 'Albac', 1);
insert into localitate values(localitate_seq.nextval, 'oras', 'Arad', 2);
insert into localitate values(localitate_seq.nextval, 'sat', 'Conop', 2);
insert into localitate values(localitate_seq.nextval, 'oras', 'Pitesti', 3);
insert into localitate values(localitate_seq.nextval, 'sat', 'Albota', 3);
insert into localitate values(localitate_seq.nextval, 'oras', 'Bacau', 4);
insert into localitate values(localitate_seq.nextval, 'sat', 'Buhoci', 4);
insert into localitate values(localitate_seq.nextval, 'oras', 'Oradea', 5);
insert into localitate values(localitate_seq.nextval, 'sat', 'Holod', 5);
insert into localitate values(localitate_seq.nextval, 'oras', 'Bistrita', 6);
insert into localitate values(localitate_seq.nextval, 'sat', 'Nuseni', 6);
insert into localitate values(localitate_seq.nextval, 'oras', 'Botosani', 7);
insert into localitate values(localitate_seq.nextval, 'sat', 'Lunca', 7);
insert into localitate values(localitate_seq.nextval, 'oras', 'Brasov', 8);
insert into localitate values(localitate_seq.nextval, 'sat', 'Moieciu', 8);
insert into localitate values(localitate_seq.nextval, 'oras', 'Braila', 9);
insert into localitate values(localitate_seq.nextval, 'sat', 'Ciuciu', 9);
insert into localitate values(localitate_seq.nextval, 'oras', 'Buzau', 11);
insert into localitate values(localitate_seq.nextval, 'sat', 'Siriu', 11);
insert into localitate values(localitate_seq.nextval, 'oras', 'Focsani', 42);
insert into localitate values(localitate_seq.nextval, 'sat', 'Cotesti', 42);
insert into localitate values(localitate_seq.nextval, 'oras', 'Adjud', 42);
insert into localitate values(localitate_seq.nextval, 'sat', 'Rastoaca', 42);
insert into localitate values(localitate_seq.nextval, 'oras', 'Adjud', 42);

create sequence comorbiditati_seq
start with 1
increment by 1
nocache
nocycle;

insert into comorbiditati values (comorbiditati_seq.nextval, 'Afectiune cardiovasculara');
insert into comorbiditati values (comorbiditati_seq.nextval, 'Diabet zaharat');
insert into comorbiditati values (comorbiditati_seq.nextval, 'Afectiune autoimuna');
insert into comorbiditati values (comorbiditati_seq.nextval, 'Afectiuni pulmonare');
insert into comorbiditati values (comorbiditati_seq.nextval, 'Hipertensiune');
insert into comorbiditati values (comorbiditati_seq.nextval, 'HIV');

create sequence simptome_seq
start with 1
increment by 1
nocache
nocycle;

insert into simptome values (simptome_seq.nextval, 'febra');
insert into simptome values (simptome_seq.nextval, 'tuse seaca');
insert into simptome values (simptome_seq.nextval, 'oboseala');
insert into simptome values (simptome_seq.nextval, 'dureri de cap');
insert into simptome values (simptome_seq.nextval, 'dureri musculare');
insert into simptome values (simptome_seq.nextval, 'durere in gat');
insert into simptome values (simptome_seq.nextval, 'conjunctivita');
insert into simptome values (simptome_seq.nextval, 'pierdere gust');
insert into simptome values (simptome_seq.nextval, 'pierdere miros');
insert into simptome values (simptome_seq.nextval, 'iritatie');
insert into simptome values (simptome_seq.nextval, 'dificultati in respiratie');
insert into simptome values (simptome_seq.nextval, 'dispnee');
insert into simptome values (simptome_seq.nextval, 'durere toracica');

create sequence medic_seq
start with 1
increment by 1
nocache
nocycle;


create sequence job_seq
start with 100
increment by 1
nocache
nocycle;

insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);

select * from localitate
where tip = 'oras';

create sequence centru_seq
start with 1
increment by 1
nocache 
nocycle;

insert into centru_testare values(centru_seq.nextval, 1, 'Synevo', 0, 0);
insert into centru_testare values(centru_seq.nextval, 1, 'Sante', 0, 0);
insert into centru_testare values(centru_seq.nextval, 1, 'SJU Alba Iulia', 0, 0);

insert into centru_testare values(centru_seq.nextval, 3, 'DSP Arad', 0, 0);
insert into centru_testare values(centru_seq.nextval, 3, 'Synevo', 0, 0);
insert into centru_testare values(centru_seq.nextval, 3, 'Alpha', 0, 0);

insert into centru_testare values(centru_seq.nextval, 5, 'SJU Pitesti', 0, 0);

insert into centru_testare values(centru_seq.nextval, 7, 'Sante', 0, 0);
insert into centru_testare values(centru_seq.nextval, 7, 'OncoFort', 0, 0);
insert into centru_testare values(centru_seq.nextval, 7, 'Regina Maria', 0, 0);

insert into centru_testare values(centru_seq.nextval, 9, 'SJU Oradea', 0, 0);

insert into centru_testare values(centru_seq.nextval, 11, 'SJU Bistrita', 0, 0);
insert into centru_testare values(centru_seq.nextval, 11, 'Synevo', 0, 0);

insert into centru_testare values(centru_seq.nextval, 13, 'Ecomed', 0, 0);
insert into centru_testare values(centru_seq.nextval, 13, 'Synevo', 0, 0);

insert into centru_testare values(centru_seq.nextval, 15, 'Regina Maria', 0, 0);
insert into centru_testare values(centru_seq.nextval, 15, ' SJB Infectioase', 0, 0);

insert into centru_testare values(centru_seq.nextval, 17, 'Praxis', 0, 0);

insert into centru_testare values(centru_seq.nextval, 19, ' Synevo', 0, 0);
insert into centru_testare values(centru_seq.nextval, 19, ' Regina Maria', 0, 0);


insert into centru_testare values(centru_seq.nextval, 21, 'Synevo', 0, 0);
insert into centru_testare values(centru_seq.nextval, 21, ' SJU Vrancea', 0, 0);

insert into centru_testare values(centru_seq.nextval, 23, 'Sfanta Maria', 0, 0);

create sequence familie_seq
start with 1
increment by 1
nocycle
nocache;

insert into familie values(familie_seq.nextval, 0);
insert into familie values(familie_seq.nextval, 0);
insert into familie values(familie_seq.nextval, 0);
insert into familie values(familie_seq.nextval, 0);
insert into familie values(familie_seq.nextval, 0);
insert into familie values(familie_seq.nextval, 0);
insert into familie values(familie_seq.nextval, 0);
insert into familie values(familie_seq.nextval, 0);
insert into familie values(familie_seq.nextval, 0);
insert into familie values(familie_seq.nextval, 0);
insert into familie values(familie_seq.nextval, 0);
insert into familie values(familie_seq.nextval, 0);
insert into familie values(familie_seq.nextval, 0);
insert into familie values(familie_seq.nextval, 0);
insert into familie values(familie_seq.nextval, 0);

select *
from job;

create sequence job_fizic_seq
start with 100
increment by 2
nocache
nocycle;

insert into job_fizic values (job_fizic_seq.nextval, 0);
insert into job_fizic values (job_fizic_seq.nextval, 0);
insert into job_fizic values (job_fizic_seq.nextval, 0);
insert into job_fizic values (job_fizic_seq.nextval, 0);
insert into job_fizic values (job_fizic_seq.nextval, 0);
insert into job_fizic values (job_fizic_seq.nextval, 0);
insert into job_fizic values (job_fizic_seq.nextval, 0);
insert into job_fizic values (job_fizic_seq.nextval, 0);

create sequence job_remote_seq
start with 101
increment by 2
nocache 
nocycle;

insert into job_remote values (job_remote_seq.nextval);
insert into job_remote values (job_remote_seq.nextval);
insert into job_remote values (job_remote_seq.nextval);
insert into job_remote values (job_remote_seq.nextval);
insert into job_remote values (job_remote_seq.nextval);
insert into job_remote values (job_remote_seq.nextval);
insert into job_remote values (job_remote_seq.nextval);

select * from job;

create sequence pacient_seq
start with 1
increment by 1
nocache
nocycle;




select * from pacient;

insert into pozitiv values(21,  to_date('14-11-2020', 'DD-MM-YYYY'), to_date('01-11-2020', 'DD-MM-YYYY'));
insert into pozitiv values(24,  to_date('14-11-2020', 'DD-MM-YYYY'), to_date('01-11-2020', 'DD-MM-YYYY'));
insert into pozitiv values(26,  to_date('14-11-2020', 'DD-MM-YYYY'), to_date('01-11-2020', 'DD-MM-YYYY'));
insert into pozitiv values(28,  to_date('14-11-2020', 'DD-MM-YYYY'), to_date('01-11-2020', 'DD-MM-YYYY'));
insert into pozitiv values(30,  to_date('14-11-2020', 'DD-MM-YYYY'), to_date('01-11-2020', 'DD-MM-YYYY'));
insert into pozitiv values(35,  to_date('14-11-2020', 'DD-MM-YYYY'), to_date('01-11-2020', 'DD-MM-YYYY'));
insert into pozitiv values(36,  to_date('14-11-2020', 'DD-MM-YYYY'), to_date('01-11-2020', 'DD-MM-YYYY'));
insert into pozitiv values(38,  to_date('14-11-2020', 'DD-MM-YYYY'), to_date('01-11-2020', 'DD-MM-YYYY'));
insert into pozitiv values(39,  to_date('14-11-2020', 'DD-MM-YYYY'), to_date('01-11-2020', 'DD-MM-YYYY'));
insert into pozitiv values(40,  to_date('14-11-2020', 'DD-MM-YYYY'), to_date('01-11-2020', 'DD-MM-YYYY'));
insert into pozitiv values(25,  to_date('14-11-2020', 'DD-MM-YYYY'), to_date('01-11-2020', 'DD-MM-YYYY'));

select * from pozitiv;

insert into negativ values(22);
insert into negativ values(23);
insert into negativ values(29);
insert into negativ values(31);
insert into negativ values(32);
insert into negativ values(33);
insert into negativ values(34);
insert into negativ values(37);

select * from negativ;

create sequence test_seq
start with 1
increment by 1
nocycle
nocache;

insert into test values(test_seq.nextval, 21, 'pozitiv', 1, to_date('31-10-2020', 'DD-MM-YYYY'));
insert into test values(test_seq.nextval, 24, 'pozitiv', 21, to_date('31-10-2020', 'DD-MM-YYYY'));
insert into test values(test_seq.nextval, 25, 'pozitiv', 21, to_date('31-10-2020', 'DD-MM-YYYY')); 
insert into test values(test_seq.nextval, 26, 'pozitiv', 2, to_date('31-10-2020', 'DD-MM-YYYY'));
insert into test values(test_seq.nextval, 28, 'pozitiv', 2, to_date('31-10-2020', 'DD-MM-YYYY'));
insert into test values(test_seq.nextval, 30, 'pozitiv', 21, to_date('31-10-2020', 'DD-MM-YYYY')); 
insert into test values(test_seq.nextval, 35, 'pozitiv', 8, to_date('31-10-2020', 'DD-MM-YYYY')); 
insert into test values(test_seq.nextval, 36, 'pozitiv', 3, to_date('31-10-2020', 'DD-MM-YYYY'));
insert into test values(test_seq.nextval, 38, 'pozitiv', 8, to_date('31-10-2020', 'DD-MM-YYYY'));
insert into test values(test_seq.nextval, 39, 'pozitiv', 8, to_date('31-10-2020', 'DD-MM-YYYY'));
insert into test values(test_seq.nextval, 40, 'pozitiv', 8, to_date('31-10-2020', 'DD-MM-YYYY'));

insert into test values (test_seq.nextval, 22,'negativ', 3,  to_date('21-10-2020', 'DD-MM-YYYY'));
insert into test values (test_seq.nextval, 23,'negativ', 18, to_date('21-10-2020', 'DD-MM-YYYY'));
insert into test values (test_seq.nextval, 29,'negativ', 16, to_date('21-10-2020', 'DD-MM-YYYY'));
insert into test values (test_seq.nextval, 31,'negativ', 12, to_date('21-10-2020', 'DD-MM-YYYY'));
insert into test values (test_seq.nextval, 32,'negativ', 12, to_date('21-10-2020', 'DD-MM-YYYY'));
insert into test values (test_seq.nextval, 33,'negativ', 12, to_date('21-10-2020', 'DD-MM-YYYY'));
insert into test values (test_seq.nextval, 34,'negativ', 16, to_date('21-10-2020', 'DD-MM-YYYY'));
insert into test values (test_seq.nextval, 37,'negativ', 8, to_date('21-10-2020', 'DD-MM-YYYY'));

select *
from simptome;

insert into simptome_pacient values(21, 8);
insert into simptome_pacient values(21, 9);
insert into simptome_pacient values(21, 1);
insert into simptome_pacient values(24, 8);
insert into simptome_pacient values(24, 9);
insert into simptome_pacient values(24, 3);
insert into simptome_pacient values(25, 8);
insert into simptome_pacient values(25, 4);
insert into simptome_pacient values(25, 4);
insert into simptome_pacient values(26, 8);
insert into simptome_pacient values(26, 9);
insert into simptome_pacient values(26, 5);
insert into simptome_pacient values(26, 6);
insert into simptome_pacient values(28, 8);
insert into simptome_pacient values(28, 9);
insert into simptome_pacient values(28, 1);
insert into simptome_pacient values(30, 8);
insert into simptome_pacient values(30, 9);
insert into simptome_pacient values(35, 1);
insert into simptome_pacient values(35, 8);
insert into simptome_pacient values(35, 9);
insert into simptome_pacient values(36, 8);
insert into simptome_pacient values(39, 8);
insert into simptome_pacient values(39, 9);
insert into simptome_pacient values(39, 1);
insert into simptome_pacient values(38, 8);
insert into simptome_pacient values(38, 9);
insert into simptome_pacient values(38, 1);
insert into simptome_pacient values(40, 9);

select *
from comorbiditati;


insert into comorbiditati_pacient values(21, 3);
insert into comorbiditati_pacient values(25, 1);
insert into comorbiditati_pacient values(25, 6);
insert into comorbiditati_pacient values(26, 4);
insert into comorbiditati_pacient values(28, 1);
insert into comorbiditati_pacient values(28, 5);
insert into comorbiditati_pacient values(35, 6);
insert into comorbiditati_pacient values(36, 2);
insert into comorbiditati_pacient values(36, 1);
insert into comorbiditati_pacient values(38, 1);
insert into comorbiditati_pacient values(38, 3);
insert into comorbiditati_pacient values(39, 2);

declare             --calculez nr de teste pozitive
    v_numar_t_pozitive centru_testare.numar_teste_pozitive%type;
    v_numar_t_negative centru_testare.numar_teste_pozitive%type;
    cursor c_ct is 
    select *
    from centru_testare;

begin
    for centru in c_ct 
    loop
    v_numar_t_pozitive := 0;
    v_numar_t_negative := 0;
    select count(t.id_pacient)
    into v_numar_t_pozitive
    from test t
    where centru.id_centru = t.id_centru
    and t.rezultat = 'pozitiv';
    
    select count(t.id_pacient)
    into v_numar_t_negative
    from test t
    where centru.id_centru = t.id_centru
    and t.rezultat = 'negativ';
    
    update centru_testare
    set
    numar_teste_pozitive = v_numar_t_pozitive
    where id_centru = centru.id_centru;
    update centru_testare
    set
     numar_teste_negative = v_numar_t_negative
    where id_centru = centru.id_centru;
    end loop;
end;

declare         --calculez nr ANGAJATI PE JOB-URI FIZICE
    v_numar_ang job_fizic.angajati%type;
    cursor c_job is
    select *
    from job_fizic;
begin
    for j in c_job
    loop
         v_numar_ang := 0;
        select count(id_pacient)
        into v_numar_ang
        from pacient
        where j.id_job_f = pacient.id_job;
        update job_fizic
        set 
        angajati = v_numar_ang
        where j.id_job_f = id_job_f;
    end loop;
end;

declare         --adaug numarul de membri din fiecare familie
    v_membri_familie familie.membri%type;
    cursor c_fam is
    select *
    from familie;
begin
    for f in c_fam
    loop
        v_membri_familie := 0;
        select count(id_pacient)
        into v_membri_familie
        from pacient
        where f.id_familie = id_familie;
        update familie
        set 
        membri = v_membri_familie
        where f.id_familie = id_familie;
    end loop;
end;

declare         --adaug numarul de testati pozitiv aflati in carantina in lista fiecarui medic
    v_bolnavi familie.membri%type;
    cursor c_mf is
    select *
    from medic_familie;
begin
    for mf in c_mf
    loop
        v_bolnavi := 0;
        select count(p.id_pacient_p)
        into v_bolnavi
        from pozitiv p, pacient pac
        where pac.id_medic = mf.id_medic
        and p.id_pacient_p = pac.id_pacient;
        update medic_familie
        set 
        bolnavi_in_lista =  v_bolnavi
        where mf.id_medic = id_medic;
    end loop;
end;

declare             --calculez nr de teste pozitive si negative pe DSP Judetean
    v_numar_t_pozitive DSP.nr_teste_pozitive%type;
    v_numar_t_negative DSP.nr_teste_pozitive%type;
    cursor c_DSP is 
    select *
    from DSP;

begin
    for d in c_DSP
    loop
    v_numar_t_pozitive := 0;
    v_numar_t_negative := 0;
    select count(t.id_pacient)
    into v_numar_t_pozitive
    from test t, centru_testare ct, localitate l, judet j
    where t.id_centru = ct.id_centru
    and ct.id_localitate = l.id_localitate
    and l.id_judet = j.id_judet
    and j.id_DSP = d.id_DSP
    and t.rezultat = 'pozitiv';
    
     select count(t.id_pacient)
    into v_numar_t_negative
    from test t, centru_testare ct, localitate l, judet j
    where t.id_centru = ct.id_centru
    and ct.id_localitate = l.id_localitate
    and l.id_judet = j.id_judet
    and j.id_DSP = d.id_DSP
    and t.rezultat = 'negativ';
    
    update DSP
    set
    nr_teste_pozitive = v_numar_t_pozitive
    where id_DSP = d.id_DSP;
    update DSP
    set
     nr_teste_negative = v_numar_t_negative
    where id_DSP = d.id_DSP;
    end loop;
end;

--Subrpogram cu un tip de colectie studiat

--insert-uri necesare pentru rezultate relevante 
    insert into simptome values(simptome_seq.nextval, 'stranut');
    insert into simptome values(simptome_seq.nextval, 'nas infundat');
    insert into simptome values(simptome_seq.nextval, 'rinoree');
    insert into simptome_pacient values(22,14);
    insert into simptome_pacient values(23,14);
    insert into simptome_pacient values(22,15);
    insert into simptome_pacient values(29,14);
    insert into simptome_pacient values(31,14);
    insert into simptome_pacient values(33,15);
    insert into simptome_pacient values(31,16);
    insert into simptome_pacient values(33,16);
    
select *
from simptome;


--6
create or replace procedure statistici_simptome
is
    type incidenta_simptome is record (simptom simptome.nume%type, numar NUMBER(6,0));
    type vector_simptome is table of incidenta_simptome index by pls_integer;
    type vector is VARRAY(100) of incidenta_simptome;
    v_1 incidenta_simptome;
    v_2 incidenta_simptome;
    v_3 incidenta_simptome;
    tb vector := vector();
    t vector_simptome;
    t_negativ vector_simptome;
    v_nume simptome.nume%type;
    v_numar NUMBER(6,0);
    v_c NUMBER(6,0);
begin
    select count(id_simptom)        --a
    into v_c
    from simptome;
    for i in 1..v_c loop
        v_nume := '';
        v_numar := 0;
        select count(s.id_pacient)
        into v_numar
        from simptome_pacient s
        where s.id_simptom = i
        and exists (select id_pacient
                    from test
                    where rezultat = 'pozitiv'
                    and id_pacient = s.id_pacient);
        select nume
        into v_nume
        from simptome s
        where s.id_simptom = i;
        t(i).simptom := v_nume;
        t(i).numar := v_numar;
    end loop;
    
    dbms_output.put_line('Simptomele pacientilor pozitivi: ');
    for i in 1..v_c loop    --a
        dbms_output.put_line(i||'. ' || t(i).simptom|| ' ' || t(i).numar);
    end loop;
    
    for i in 1..v_c loop
        v_nume := '';
        v_numar := 0;
        select count(s.id_pacient)
        into v_numar
        from simptome_pacient s
        where s.id_simptom = i
        and exists (select t.id_pacient
                    from test t
                    where t.rezultat = 'pozitiv'
                    and t.id_pacient = s.id_pacient
                    and exists (select id_pacient
                                from comorbiditati_pacient
                                where t.id_pacient = id_pacient));
        select nume
        into v_nume
        from simptome s
        where s.id_simptom = i;
        tb.extend();
        tb(i).simptom := v_nume;
        tb(i).numar := v_numar;
         end loop;  
         dbms_output.new_line();
    dbms_output.new_line();
        dbms_output.put_line('Simptomele pacientilor pozitivi cu comorbiditati: ');
    for i in 1..v_c loop    --b
        dbms_output.put_line(i||'. ' || tb(i).simptom|| ' ' || tb(i).numar);
    end loop;
 
    for i in 1..v_c loop
        v_nume := '';
        v_numar := 0;
        select count(s.id_pacient)
        into v_numar
        from simptome_pacient s
        where s.id_simptom = i
        and exists (select id_pacient
                    from test
                    where rezultat = 'negativ'
                    and id_pacient = s.id_pacient);
        select nume
        into v_nume
        from simptome s
        where s.id_simptom = i;
        t_negativ(i).simptom := v_nume;
        t_negativ(i).numar := v_numar;
    end loop;
    
    v_1.numar := 0; v_1.simptom := '';
    v_2.numar := 0; v_2.simptom := '';
    v_3.numar := 0; v_3.simptom := '';
    
    for i in 1..v_c loop
        if (t_negativ(i).numar - t(i).numar) >= v_1.numar then
            v_3.numar := v_2.numar;
            v_3.simptom := v_2.simptom;
            v_2.numar := v_1.numar;
            v_2.simptom := v_1.simptom;
            v_1.numar := t_negativ(i).numar;
            v_1.simptom := t_negativ(i).simptom;
        elsif (t_negativ(i).numar - t(i).numar) >= v_2.numar then
            v_3.numar := v_2.numar;
            v_3.simptom := v_2.simptom;
            v_2.numar := t_negativ(i).numar;
            v_2.simptom := t_negativ(i).simptom;
        else if  (t_negativ(i).numar - t(i).numar) >= v_3.numar then
            v_3.numar :=  t_negativ(i).numar;
            v_3.simptom := t_negativ(i).simptom;
        end if;
        end if;        
    end loop;
    dbms_output.new_line();
    dbms_output.new_line();
        dbms_output.put_line('Simptomele inselatoare cele mai des intalnite sunt: ');
        dbms_output.put_line('1. ' || v_1.simptom);
        dbms_output.put_line('2. ' || v_2.simptom);
        dbms_output.put_line('3. ' || v_3.simptom);

end statistici_simptome;
/
execute statistici_simptome;

--7
create or replace procedure info_contacti 
is
    cursor c_pacienti is
    select *
    from pacient p, pozitiv po
    where p.id_pacient = po.id_pacient_p;

    cursor c_contact(v_job pacient.id_job%type, v_fam pacient.id_familie%type, v_pac pacient.id_pacient%type)
        is select nume, prenume, id_pacient
        from pacient 
        where id_pacient != v_pac
        and (id_familie = v_fam
        or (id_job = v_job and exists (select id_job_f 
                                            from job_fizic
                                            where id_job_f = v_job)));
    cursor c_familie(v_f pacient.id_familie%type, v_p pacient.id_pacient%type)
        is select nume, prenume, id_pacient
        from pacient
        where id_pacient != v_p
        and id_familie = v_f;
        
    cursor c_job(v_j pacient.id_job%type, v_p pacient.id_pacient%type)
        is select nume, prenume, id_pacient
        from pacient
        where id_pacient != v_p
        and  (id_job = v_j and exists (select id_job_f 
                                            from job_fizic
                                            where id_job_f = v_j));
    i NUMBER := 0; --numarul de legaturi
    j NUMBER := 0; --numar legaturi familie
    k NUMBER := 0; --numar legaturi job
    v_numar_pozitiv NUMBER := 0;
    v_numar NUMBER := 0; 
    v_data_pacient_curent test.data_test%type;
    v_stat_poz_munca NUMBER := 0;
    v_stat_poz_familie NUMBER := 0;
    d1 NUMBER := 0;
    d2 NUMBER := 0;
begin
    for pac in c_pacienti loop
        v_data_pacient_curent := pac.de_la_data;
        v_numar_pozitiv:= 0;
        dbms_output.put_line('Lista contactilor pacientului ' || pac.nume || ' ' || pac.prenume);
        i := 0; j:= 0;
        for c in c_contact(pac.id_job, pac.id_familie,pac.id_pacient) loop
            i := i + 1; v_numar := 0;
            dbms_output.put_line(i || '. ' ||c.nume || ' ' || c.prenume);
            select 1
            into v_numar
            from test
            where id_pacient = c.id_pacient
            and rezultat = 'pozitiv'
            and abs(data_test - v_data_pacient_curent) <= 14;
            v_numar_pozitiv := v_numar_pozitiv + 1;
        end loop;
        if (i = 0) then
            dbms_output.put_line('Nu are contacti directi');
            dbms_output.new_line();
            dbms_output.new_line();
        else
            dbms_output.new_line();
            dbms_output.put_line('Contacti familie:');
            for f in c_familie(pac.id_familie, pac.id_pacient)
            loop
                j := j + 1; d2 := 0;
                dbms_output.put_line(j || '. ' ||f.nume || ' ' || f.prenume);
                select 1 
                into d2
                from test
                where id_pacient = f.id_pacient
                and rezultat = 'pozitiv'
                and abs(data_test - v_data_pacient_curent) <= 14;
                 v_stat_poz_familie :=  v_stat_poz_familie + d2;
            end loop;
            if (j = 0) then
                dbms_output.put_line('Nu are contacti posibili in familie.');
            end if;
            dbms_output.new_line();
            dbms_output.put_line('Contacti job: ');
            k := 0;
            for jc in c_job(pac.id_job, pac.id_pacient) 
            loop
                k := k + 1; d1 := 0;
                dbms_output.put_line(k || '. ' || jc.nume ||' '||jc.prenume);
                select 1 
                into d1 
                from test
                where id_pacient = jc.id_pacient
                and rezultat = 'pozitiv'
                and abs(data_test - v_data_pacient_curent) <= 14;
                 v_stat_poz_munca :=  v_stat_poz_munca + d1;
            end loop;
             if (k = 0) then
                dbms_output.put_line('Nu are contacti posibili la locul de munca.');
            end if;
        dbms_output.new_line();
        dbms_output.put_line('Rata posibila de transmisie a bolii este ' || v_numar_pozitiv/i*100 || ' %');
        
        end if;
        dbms_output.put_line('------------------------------------------------------------------');
        dbms_output.new_line();
    end loop;
    if (v_stat_poz_munca > v_stat_poz_familie) then
        dbms_output.put_line('Conform datelor inregistrate, raspandirea mai mare se realizeaza la munca');
    elsif (v_stat_poz_munca < v_stat_poz_familie) then
        dbms_output.put_line('Conform datelor inregistrate, raspandirea mai mare se realizeaza in familie');
    else
        dbms_output.put_line('Datele sunt inconcludente, nu exista nicio diferenta');
    end if;
    
end info_contacti;
/

execute info_contacti;  
    
--8
create or replace function simptome_pacienti_medic (v_nume medic_familie.nume%type)
return NUMBER is
rezultat NUMBER(6,0);
v_id_medic medic_familie.id_medic%type;
cursor grav_bolnavi (id_m pacient.id_medic %type)
is
    select *
    from pacient p
    where p.id_medic = id_m
    and exists(select id_simptom
                from simptome_pacient
                where id_pacient = p.id_pacient
                and id_simptom in (11,12,13));
cursor moderat_bolnavi (id_m pacient.id_medic %type)
is
    select *
    from pacient p
    where p.id_medic = id_m
    and exists (select id_simptom
                from simptome_pacient
                where id_pacient = p.id_pacient
                and id_simptom = 1
               )
    and not exists (select id_simptom
                    from simptome_pacient
                    where id_pacient = p.id_pacient
                    and id_simptom not in (11,12,13));
cursor usor_bolnavi (id_m pacient.id_medic %type)
is
    select *
    from pacient p
    where p.id_medic = id_m
    and not exists(select id_simptom
                from simptome_pacient
                where id_pacient = p.id_pacient
                and id_simptom in (1,11,12,13));
i NUMBER(6,0) := 0;
j NUMBER(6,0) := 0; 
k NUMBER(6,0) := 0; 
begin
    select id_medic
    into v_id_medic
    from medic_familie
    where nume = v_nume;
  
    for gb in grav_bolnavi(v_id_medic)
    loop
        if (i = 0) then
            dbms_output.put_line('Bolnavi grav');
            dbms_output.put_line('-------------------');   
        end if;
        i := i + 1;
        dbms_output.put_line(i || '. ' || gb.nume ||  ' ' || gb.prenume || ' ' || gb.data_nasterii || ' ' || gb.sex);
        dbms_output.put_line('Date contact: ' || gb.telefon || ' ' || gb.mail);
    end loop;

    if i = 0 then
        dbms_output.put_line('Nu exista grav bolnavi');
    end if;
  
    for mb in moderat_bolnavi(v_id_medic)
    loop
         if (j = 0) then
              dbms_output.put_line('Bolnavi moderat');
                dbms_output.put_line('-------------------');
        end if;
        j := j + 1;
        dbms_output.put_line(j || '. ' || mb.nume ||  ' ' || mb.prenume || ' ' || mb.data_nasterii || ' ' || mb.sex);
        dbms_output.put_line('Date contact: ' || mb.telefon || ' ' || mb.mail);
    end loop;
    
    if j = 0 then
        dbms_output.put_line('Nu exista bolnavi moderat');
    end if;
  
    for ub in usor_bolnavi(v_id_medic)
    loop
         if (k = 0) then
                dbms_output.put_line('Bolnavi usor sau asimptomatici');
                dbms_output.put_line('-------------------');
        end if;
        k := k + 1;
        dbms_output.put_line(k || '. ' || ub.nume ||  ' ' || ub.prenume || ' ' || ub.data_nasterii || ' ' || ub.sex);
        dbms_output.put_line('Date contact: ' || ub.telefon || ' ' || ub.mail);
    end loop;
      if k = 0 then
        dbms_output.put_line('Nu exista bolnavi usor sau asimptomatici');
    end if;
    rezultat := i;
    return rezultat;
exception
    when NO_DATA_FOUND then
        dbms_output.put_line('Nu exista medic cu numele dat.');
        return -1;
    when TOO_MANY_ROWS then
        dbms_output.put_line('Exista mai multi medici cu numele dat');
        return -1;
    when OTHERS then
        dbms_output.put_line('Alta eroare');
        return -1;
end simptome_pacienti_medic;
/

BEGIN
      DBMS_OUTPUT.PUT_LINE('Numarul de grav bolnavi din lista medicului e: '|| simptome_pacienti_medic('Voicu'));
END;
/

BEGIN
      DBMS_OUTPUT.PUT_LINE('Numarul de grav bolnavi din lista medicului e: '|| simptome_pacienti_medic('A'));
END;
/

BEGIN
      DBMS_OUTPUT.PUT_LINE('Numarul de grav bolnavi din lista medicului e: '|| simptome_pacienti_medic('Stefanoiu'));
END;
/

BEGIN
      DBMS_OUTPUT.PUT_LINE('Numarul de grav bolnavi din lista medicului e: '|| simptome_pacienti_medic('Gabor'));
END;
/

BEGIN
      DBMS_OUTPUT.PUT_LINE('Numarul de grav bolnavi din lista medicului e: '|| simptome_pacienti_medic('Comeaga'));
END;
/

insert into medic_familie values(medic_seq.nextval,'Voicu', 'Mihai', 0, '0211 234 231');
insert into simptome_pacient values(21, 12);

--pentru sortare cu SQL
create type sortable_t is object(
    nr_teste NUMBER(6,0),
    nume VARCHAR2(30 BYTE)
);
/

create type sortable_table_t is table of sortable_t;
/

--9
create or replace procedure statistici_judete(introdus judet.nume%type, zi VARCHAR2)
is
    type tab_rez is record(nr_teste NUMBER(6,0),nume localitate.nume%type);
    type tabel is table of tab_rez index by PLS_INTEGER;
    type array_zile is varray(7) of varchar2(30);
    t tabel;
    swap_helper tab_rez;
    zile array_zile := array_zile('duminica', 'luni', 'marti', 'miercuri', 'joi', 'vineri', 'sambata');
    sorted sortable_table_t := sortable_table_t();
    cursor c_localitate(id_jud judet.id_judet%type)
    is
    select *
    from localitate 
    where id_judet = id_jud;
    
    cursor c_centru(id_loc localitate.id_localitate%type)
    is 
    select *
    from centru_testare
    where id_localitate= id_loc;
    
    t_pe_centru NUMBER(6,0):= 0;
    t_pe_localitate NUMBER(6,0) := 0;
    t_pe_judet NUMBER(6,0) := 0;
    
    j NUMBER(6,0) := 0;
    i NUMBER(6,0) := 0;
    k NUMBER(6,0) := 0;
    v_cod judet.id_judet%type;
    v_id_DSP DSP.id_DSP%type;
    v_nrp DSP.nr_teste_pozitive%type;
    v_nrn DSP.nr_teste_negative%type;
    v_tel DSP.telefon%type;
    v_id_zi NUMBER := 0;
    teste_totale NUMBER(6,0) := 0;
    v_test DATE;
    e exception;
begin
    select id_judet, j.id_DSP, d.nr_teste_pozitive, d.nr_teste_negative, d.telefon
    into v_cod, v_id_DSP, v_nrp, v_nrn, v_tel  --a
    from judet j, dsp d
    where j.nume = introdus
    and j.id_DSP = d.id_DSP;
    
    for i in 1..7
    loop
        if lower(zi) = zile(i) then
            v_id_zi := i;
        end if;
    end loop;
    
    if v_id_zi = 0 then
        raise e;
    end if;
    
    i := 0;
        
    for loc in c_localitate(v_cod) loop
        t_pe_localitate := 0;
        i := i + 1;
        select count(*)
        into t_pe_localitate
        from test t, centru_testare c
        where t.rezultat = 'pozitiv'
        and to_char(t.data_test, 'D') = v_id_zi
        and c.id_centru = t.id_centru
        and c.id_localitate = loc.id_localitate;

        teste_totale := teste_totale + t_pe_localitate;
        
        t(i).nr_teste := t_pe_localitate;
        t(i).nume := loc.nume;
    end loop;
    
    dbms_output.put_line('Datele DSP care se ocupa de judetul ' || introdus || ' sunt: ');
    dbms_output.put_line('ID: ' || v_id_DSP);
    dbms_output.put_line('Numarul de teste pozitive: ' || v_nrp);
    dbms_output.put_line('Numarul de teste negative: ' || v_nrn);
    dbms_output.put_line('Numarul de telefon: ' || v_tel);
    
    for j in 1..i loop
        sorted.extend(1);
        sorted(sorted.last) := new sortable_t(t(j).nr_teste, t(j).nume);
    end loop;
    
    select cast (multiset (select *
                            from table(sorted)
                            order by 1 desc)
                  as sortable_table_t)
    into sorted 
    from dual;
    --Sort1
    for j in 1..(i - 1) loop
        for k in j + 1.. i loop
            if t(j).nr_teste < t(k).nr_teste then
                swap_helper := t(j);
                t(j) := t(k);
                t(k) := swap_helper;
            end if;
        end loop;
    end loop;
    
    for j in 1..i loop
        dbms_output.put_line(j || '. ' || t(j).nume || ' : ' || t(j).nr_teste);
    end loop;
    dbms_output.new_line();
    dbms_output.put_line('Cealalta varianta de sortare');
    --Sort2
    for j in sorted.first..sorted.last loop
        dbms_output.put_line(j || '. ' || sorted(j).nume || ' : ' || sorted(j).nr_teste);
    end loop;
exception
    when no_data_found then
        dbms_output.put_line('Judetul introdus nu exista');
    when too_many_rows then
        dbms_output.put_line('Doua judete cu acelasi nume');
    when e then
        dbms_output.put_line('Textul introdus nu e o zi valida a saptamanii');
        
end statistici_judete;
/

begin
statistici_judete('Alba', 'Azi'); --nu exista ziua
end;
/
begin
statistici_judete('A', 'Miercuri'); --nu exista judetul
end;
/
begin
statistici_judete('Alba', 'Sambata');
end;
/
begin
statistici_judete('Vrancea', 'Sambata');
end;
/

--10
create or replace procedure insert_test(t_id_pacient test.id_pacient%type, din test.data_test%type, t_id_centru test.id_test%type, t_rezultat test.rezultat%type)
is
    v_DSP DSP.id_DSP%type;
    v_medic pacient.id_medic%type;
    V number := 0;
begin
    select j.id_DSP     --TODO:fix eroare aici
    into v_DSP
    from centru_testare c, localitate l, judet j
    where c.id_centru = t_id_centru
    and l.id_localitate = c.id_localitate
    and l.id_judet = j.id_judet;
    V := 1;
    if t_rezultat = 'pozitiv' then
        update centru_testare ct
        set 
        ct.numar_teste_pozitive = ct.numar_teste_pozitive + 1
        where ct.id_centru = t_id_centru;
        
        update DSP d
        set d.nr_teste_pozitive = d.nr_teste_pozitive + 1
        where d.id_DSP = v_DSP;
        
        insert into pozitiv values(t_id_pacient, din + 1, din + 14);
        
        select p.id_medic
        into v_medic
        from pacient p
        where p.id_pacient = t_id_pacient;
        
        update medic_familie
        set 
        bolnavi_in_lista = bolnavi_in_lista + 1
        where id_medic = v_medic;
    else
        update centru_testare ct
        set 
        ct.numar_teste_negative = ct.numar_teste_negative + 1
        where ct.id_centru = t_id_centru;
        
        update DSP d
        set d.nr_teste_negative = d.nr_teste_negative + 1
        where d.id_DSP = v_DSP;
        
        insert into negativ values(t_id_pacient);
    end if;
exception
    when no_data_found then
        dbms_output.put_line('Nu exista un centru cu acest ID');
    when too_many_rows then
        dbms_output.put_line(V || 'Prea multe centre cu acest ID');
end insert_test;
/

create or replace procedure update_test(t_id_pacient test.id_pacient%type, di test.data_test%type, t_id_centru test.id_centru%type, rezultat_vechi test.rezultat%type, rezultat_nou test.rezultat%type)
is
    v_DSP DSP.id_DSP%type;
    v_medic pacient.id_medic%type;
begin
            select p.id_medic 
            into v_medic
            from pacient p
            where p.id_pacient = t_id_pacient;
            
            select d.id_DSP
            into v_DSP
            from centru_testare c, localitate l, judet j, DSP d
            where c.id_centru = t_id_centru
            and l.id_localitate = c.id_localitate
            and l.id_judet = j.id_judet
            and j.id_DSP =d.id_DSP;

    if rezultat_nou != rezultat_vechi then
        if rezultat_nou = 'pozitiv' then
            delete from negativ n
            where n.id_pacient_n = t_id_pacient;
            insert into pozitiv 
            values(t_id_pacient, di + 14, di + 1);
         
            update medic_familie
            set bolnavi_in_lista = bolnavi_in_lista + 1
            where id_medic = v_medic;
            
            update centru_testare ct
            set ct.numar_teste_pozitive = ct.numar_teste_pozitive + 1,
                ct.numar_teste_negative = ct.numar_teste_negative - 1
            where t_id_centru = ct.id_centru;
            
            update DSP d
            set d.nr_teste_pozitive = d.nr_teste_pozitive + 1,
                d.nr_teste_negative = d.nr_teste_negative - 1
            where d.id_DSP = v_DSP;
        else
            delete from pozitiv p
            where p.id_pacient_p = t_id_pacient;
            insert into negativ n 
            values (t_id_pacient);
            
            update medic_familie
            set bolnavi_in_lista = bolnavi_in_lista - 1
            where id_medic = v_medic;
            
            update centru_testare ct
            set ct.numar_teste_negative = ct.numar_teste_negative + 1,
                ct.numar_teste_pozitive = ct.numar_teste_pozitive - 1
            where t_id_centru = ct.id_centru;
            
            update DSP d
            set d.nr_teste_pozitive = d.nr_teste_pozitive - 1,
                d.nr_teste_negative = d.nr_teste_negative + 1
            where d.id_DSP = v_DSP;
        end if;
    end if;
end update_test;
/
create or replace trigger trigger_update_test
    before update or insert or delete on test
    for each row
begin
    if deleting then
        raise_application_error(-20001,  'Nu puteti sterge un test din baza de date');  
    elsif updating then
        update_test(:NEW.id_pacient, :OLD.data_test, :OLD.id_centru, :OLD.rezultat, :NEW.rezultat);
    elsif inserting then
        insert_test(:NEW.id_pacient, :NEW.data_test, :NEW.id_centru, :NEW.rezultat);
        end if;
end;
/

select * from test;

delete from test
where id_pacient = 21;

select id_centru
from centru_testare c, pacient p
where p.id_pacient = 23
and c.id_localitate = p.id_localitate;

insert into test values(test_seq.nextval, 23, 'pozitiv', 18, '06-JAN-21');
rollback;

update test
set rezultat = 'negativ'
where id_pacient = 23;

--11
create or replace trigger restrictii_simptome
    before insert or delete or update on simptome
begin
    if(to_char(sysdate, 'dd') != 1 or to_char(sysdate, 'hh24') not between 10 and 11 or user != upper('diana')) then
        RAISE_APPLICATION_ERROR(-20001,'tabelul nu poate fi actualizat acum');
    end if;
end;
/
insert into simptome values(simptome_seq.nextval, 'durere de stomac');

--12
create table TABEL_COMENZI(utilizator VARCHAR2(30 BYTE),
                           nume_bd VARCHAR2(50 BYTE),
                           eveniment VARCHAR2(20 BYTE),
                           nume_obiect VARCHAR2(30 BYTE),
                           data DATE,
                           tip_obiect VARCHAR2(30 BYTE),
                           owner_obiect VARCHAR2(30 BYTE)
                           );
                           
create table TABEL_ERORI(user_id VARCHAR2(30),
 nume_bd VARCHAR2(50 BYTE),
 erori VARCHAR2(30 BYTE),
 data DATE);
 

create or replace trigger audit_bd
    after create or drop or alter on schema
begin
    insert into tabel_comenzi 
    values (sys.login_user, sys.database_name, sys.sysevent, sys.dictionary_obj_name, sysdate, sys.dictionary_obj_type, sys.dictionary_obj_owner);
    insert into tabel_erori
    values (sys.login_user, sys.database_name, dbms_utility.format_error_stack, sysdate);
end;
/

create index ind_1 on DSP(telefon);
select *
from tabel_comenzi; drop index ind_1;
drop trigger audit_bd;
select *
from tabel_erori;

--13
create or replace package obiecte_proiect
is
    procedure statistici_simptome;
    procedure info_contacti;
    function simptome_pacienti_medic(v_nume medic_familie.nume%type) return NUMBER;
    procedure statistici_judete(introdus judet.nume%type, zi VARCHAR2);
    procedure insert_test(t_id_pacient test.id_pacient%type, din test.data_test%type, t_id_centru test.id_test%type, t_rezultat test.rezultat%type);
    procedure update_test(t_id_pacient test.id_pacient%type, di test.data_test%type, t_id_centru test.id_centru%type, rezultat_vechi test.rezultat%type, rezultat_nou test.rezultat%type);
end;
/

create or replace package body obiecte_proiect as
    procedure statistici_simptome
is
    type incidenta_simptome is record (simptom simptome.nume%type, numar NUMBER(6,0));
    type vector_simptome is table of incidenta_simptome index by pls_integer;
    type vector is VARRAY(100) of incidenta_simptome;
    v_1 incidenta_simptome;
    v_2 incidenta_simptome;
    v_3 incidenta_simptome;
    tb vector := vector();
    t vector_simptome;
    t_negativ vector_simptome;
    v_nume simptome.nume%type;
    v_numar NUMBER(6,0);
    v_c NUMBER(6,0);
begin
    select count(id_simptom)        --a
    into v_c
    from simptome;
    for i in 1..v_c loop
        v_nume := '';
        v_numar := 0;
        select count(s.id_pacient)
        into v_numar
        from simptome_pacient s
        where s.id_simptom = i
        and exists (select id_pacient
                    from test
                    where rezultat = 'pozitiv'
                    and id_pacient = s.id_pacient);
        select nume
        into v_nume
        from simptome s
        where s.id_simptom = i;
        t(i).simptom := v_nume;
        t(i).numar := v_numar;
    end loop;
    
    dbms_output.put_line('Simptomele pacientilor pozitivi: ');
    for i in 1..v_c loop    --a
        dbms_output.put_line(i||'. ' || t(i).simptom|| ' ' || t(i).numar);
    end loop;
    
    for i in 1..v_c loop
        v_nume := '';
        v_numar := 0;
        select count(s.id_pacient)
        into v_numar
        from simptome_pacient s
        where s.id_simptom = i
        and exists (select t.id_pacient
                    from test t
                    where t.rezultat = 'pozitiv'
                    and t.id_pacient = s.id_pacient
                    and exists (select id_pacient
                                from comorbiditati_pacient
                                where t.id_pacient = id_pacient));
        select nume
        into v_nume
        from simptome s
        where s.id_simptom = i;
        tb.extend();
        tb(i).simptom := v_nume;
        tb(i).numar := v_numar;
         end loop;  
         dbms_output.new_line();
    dbms_output.new_line();
        dbms_output.put_line('Simptomele pacientilor pozitivi cu comorbiditati: ');
    for i in 1..v_c loop    --b
        dbms_output.put_line(i||'. ' || tb(i).simptom|| ' ' || tb(i).numar);
    end loop;
 
    for i in 1..v_c loop
        v_nume := '';
        v_numar := 0;
        select count(s.id_pacient)
        into v_numar
        from simptome_pacient s
        where s.id_simptom = i
        and exists (select id_pacient
                    from test
                    where rezultat = 'negativ'
                    and id_pacient = s.id_pacient);
        select nume
        into v_nume
        from simptome s
        where s.id_simptom = i;
        t_negativ(i).simptom := v_nume;
        t_negativ(i).numar := v_numar;
    end loop;
    
    v_1.numar := 0; v_1.simptom := '';
    v_2.numar := 0; v_2.simptom := '';
    v_3.numar := 0; v_3.simptom := '';
    
    for i in 1..v_c loop
        if (t_negativ(i).numar - t(i).numar) >= v_1.numar then
            v_3.numar := v_2.numar;
            v_3.simptom := v_2.simptom;
            v_2.numar := v_1.numar;
            v_2.simptom := v_1.simptom;
            v_1.numar := t_negativ(i).numar;
            v_1.simptom := t_negativ(i).simptom;
        elsif (t_negativ(i).numar - t(i).numar) >= v_2.numar then
            v_3.numar := v_2.numar;
            v_3.simptom := v_2.simptom;
            v_2.numar := t_negativ(i).numar;
            v_2.simptom := t_negativ(i).simptom;
        else if  (t_negativ(i).numar - t(i).numar) >= v_3.numar then
            v_3.numar :=  t_negativ(i).numar;
            v_3.simptom := t_negativ(i).simptom;
        end if;
        end if;        
    end loop;
    dbms_output.new_line();
    dbms_output.new_line();
        dbms_output.put_line('Simptomele inselatoare cele mai des intalnite sunt: ');
        dbms_output.put_line('1. ' || v_1.simptom);
        dbms_output.put_line('2. ' || v_2.simptom);
        dbms_output.put_line('3. ' || v_3.simptom);

end statistici_simptome;

procedure info_contacti 
is
    cursor c_pacienti is
    select *
    from pacient p, pozitiv po
    where p.id_pacient = po.id_pacient_p;

    cursor c_contact(v_job pacient.id_job%type, v_fam pacient.id_familie%type, v_pac pacient.id_pacient%type)
        is select nume, prenume, id_pacient
        from pacient 
        where id_pacient != v_pac
        and (id_familie = v_fam
        or (id_job = v_job and exists (select id_job_f 
                                            from job_fizic
                                            where id_job_f = v_job)));
    cursor c_familie(v_f pacient.id_familie%type, v_p pacient.id_pacient%type)
        is select nume, prenume, id_pacient
        from pacient
        where id_pacient != v_p
        and id_familie = v_f;
        
    cursor c_job(v_j pacient.id_job%type, v_p pacient.id_pacient%type)
        is select nume, prenume, id_pacient
        from pacient
        where id_pacient != v_p
        and  (id_job = v_j and exists (select id_job_f 
                                            from job_fizic
                                            where id_job_f = v_j));
    i NUMBER := 0; --numarul de legaturi
    j NUMBER := 0; --numar legaturi familie
    k NUMBER := 0; --numar legaturi job
    v_numar_pozitiv NUMBER := 0;
    v_numar NUMBER := 0; 
    v_data_pacient_curent test.data_test%type;
    v_stat_poz_munca NUMBER := 0;
    v_stat_poz_familie NUMBER := 0;
    d1 NUMBER := 0;
    d2 NUMBER := 0;
begin
    for pac in c_pacienti loop
        v_data_pacient_curent := pac.de_la_data;
        v_numar_pozitiv:= 0;
        dbms_output.put_line('Lista contactilor pacientului ' || pac.nume || ' ' || pac.prenume);
        i := 0; j:= 0;
        for c in c_contact(pac.id_job, pac.id_familie,pac.id_pacient) loop
            i := i + 1; v_numar := 0;
            dbms_output.put_line(i || '. ' ||c.nume || ' ' || c.prenume);
            select 1
            into v_numar
            from test
            where id_pacient = c.id_pacient
            and rezultat = 'pozitiv'
            and abs(data_test - v_data_pacient_curent) <= 14;
            v_numar_pozitiv := v_numar_pozitiv + 1;
        end loop;
        if (i = 0) then
            dbms_output.put_line('Nu are contacti directi');
            dbms_output.new_line();
            dbms_output.new_line();
        else
            dbms_output.new_line();
            dbms_output.put_line('Contacti familie:');
            for f in c_familie(pac.id_familie, pac.id_pacient)
            loop
                j := j + 1; d2 := 0;
                dbms_output.put_line(j || '. ' ||f.nume || ' ' || f.prenume);
                select 1 
                into d2
                from test
                where id_pacient = f.id_pacient
                and rezultat = 'pozitiv'
                and abs(data_test - v_data_pacient_curent) <= 14;
                 v_stat_poz_familie :=  v_stat_poz_familie + d2;
            end loop;
            if (j = 0) then
                dbms_output.put_line('Nu are contacti posibili in familie.');
            end if;
            dbms_output.new_line();
            dbms_output.put_line('Contacti job: ');
            k := 0;
            for jc in c_job(pac.id_job, pac.id_pacient) 
            loop
                k := k + 1; d1 := 0;
                dbms_output.put_line(k || '. ' || jc.nume ||' '||jc.prenume);
                select 1 
                into d1 
                from test
                where id_pacient = jc.id_pacient
                and rezultat = 'pozitiv'
                and abs(data_test - v_data_pacient_curent) <= 14;
                 v_stat_poz_munca :=  v_stat_poz_munca + d1;
            end loop;
             if (k = 0) then
                dbms_output.put_line('Nu are contacti posibili la locul de munca.');
            end if;
        dbms_output.new_line();
        dbms_output.put_line('Rata posibila de transmisie a bolii este ' || v_numar_pozitiv/i*100 || ' %');
        
        end if;
        dbms_output.put_line('------------------------------------------------------------------');
        dbms_output.new_line();
    end loop;
    if (v_stat_poz_munca > v_stat_poz_familie) then
        dbms_output.put_line('Conform datelor inregistrate, raspandirea mai mare se realizeaza la munca');
    elsif (v_stat_poz_munca < v_stat_poz_familie) then
        dbms_output.put_line('Conform datelor inregistrate, raspandirea mai mare se realizeaza in familie');
    else
        dbms_output.put_line('Datele sunt inconcludente, nu exista nicio diferenta');
    end if;
    
end info_contacti;

function simptome_pacienti_medic (v_nume medic_familie.nume%type)
return NUMBER is
rezultat NUMBER(6,0);
v_id_medic medic_familie.id_medic%type;
cursor grav_bolnavi (id_m pacient.id_medic %type)
is
    select *
    from pacient p
    where p.id_medic = id_m
    and exists(select id_simptom
                from simptome_pacient
                where id_pacient = p.id_pacient
                and id_simptom in (11,12,13));
cursor moderat_bolnavi (id_m pacient.id_medic %type)
is
    select *
    from pacient p
    where p.id_medic = id_m
    and exists (select id_simptom
                from simptome_pacient
                where id_pacient = p.id_pacient
                and id_simptom = 1
               )
    and not exists (select id_simptom
                    from simptome_pacient
                    where id_pacient = p.id_pacient
                    and id_simptom not in (11,12,13));
cursor usor_bolnavi (id_m pacient.id_medic %type)
is
    select *
    from pacient p
    where p.id_medic = id_m
    and not exists(select id_simptom
                from simptome_pacient
                where id_pacient = p.id_pacient
                and id_simptom in (1,11,12,13));
i NUMBER(6,0) := 0;
j NUMBER(6,0) := 0; 
k NUMBER(6,0) := 0; 
begin
    select id_medic
    into v_id_medic
    from medic_familie
    where nume = v_nume;
  
    for gb in grav_bolnavi(v_id_medic)
    loop
        if (i = 0) then
            dbms_output.put_line('Bolnavi grav');
            dbms_output.put_line('-------------------');   
        end if;
        i := i + 1;
        dbms_output.put_line(i || '. ' || gb.nume ||  ' ' || gb.prenume || ' ' || gb.data_nasterii || ' ' || gb.sex);
        dbms_output.put_line('Date contact: ' || gb.telefon || ' ' || gb.mail);
    end loop;

    if i = 0 then
        dbms_output.put_line('Nu exista grav bolnavi');
    end if;
  
    for mb in moderat_bolnavi(v_id_medic)
    loop
         if (j = 0) then
              dbms_output.put_line('Bolnavi moderat');
                dbms_output.put_line('-------------------');
        end if;
        j := j + 1;
        dbms_output.put_line(j || '. ' || mb.nume ||  ' ' || mb.prenume || ' ' || mb.data_nasterii || ' ' || mb.sex);
        dbms_output.put_line('Date contact: ' || mb.telefon || ' ' || mb.mail);
    end loop;
    
    if j = 0 then
        dbms_output.put_line('Nu exista bolnavi moderat');
    end if;
  
    for ub in usor_bolnavi(v_id_medic)
    loop
         if (k = 0) then
                dbms_output.put_line('Bolnavi usor sau asimptomatici');
                dbms_output.put_line('-------------------');
        end if;
        k := k + 1;
        dbms_output.put_line(k || '. ' || ub.nume ||  ' ' || ub.prenume || ' ' || ub.data_nasterii || ' ' || ub.sex);
        dbms_output.put_line('Date contact: ' || ub.telefon || ' ' || ub.mail);
    end loop;
      if k = 0 then
        dbms_output.put_line('Nu exista bolnavi usor sau asimptomatici');
    end if;
    rezultat := i;
    return rezultat;
exception
    when NO_DATA_FOUND then
        dbms_output.put_line('Nu exista medic cu numele dat.');
        return -1;
    when TOO_MANY_ROWS then
        dbms_output.put_line('Exista mai multi medici cu numele dat');
        return -1;
    when OTHERS then
        dbms_output.put_line('Alta eroare');
        return -1;
end simptome_pacienti_medic;

procedure statistici_judete(introdus judet.nume%type, zi VARCHAR2)
is
    type tab_rez is record(nr_teste NUMBER(6,0),nume localitate.nume%type);
    type tabel is table of tab_rez index by PLS_INTEGER;
    type array_zile is varray(7) of varchar2(30);
    t tabel;
    swap_helper tab_rez;
    zile array_zile := array_zile('duminica', 'luni', 'marti', 'miercuri', 'joi', 'vineri', 'sambata');
    sorted sortable_table_t := sortable_table_t();
    cursor c_localitate(id_jud judet.id_judet%type)
    is
    select *
    from localitate 
    where id_judet = id_jud;
    
    cursor c_centru(id_loc localitate.id_localitate%type)
    is 
    select *
    from centru_testare
    where id_localitate= id_loc;
    
    t_pe_centru NUMBER(6,0):= 0;
    t_pe_localitate NUMBER(6,0) := 0;
    t_pe_judet NUMBER(6,0) := 0;
    
    j NUMBER(6,0) := 0;
    i NUMBER(6,0) := 0;
    k NUMBER(6,0) := 0;
    v_cod judet.id_judet%type;
    v_id_DSP DSP.id_DSP%type;
    v_nrp DSP.nr_teste_pozitive%type;
    v_nrn DSP.nr_teste_negative%type;
    v_tel DSP.telefon%type;
    v_id_zi NUMBER := 0;
    teste_totale NUMBER(6,0) := 0;
    v_test DATE;
    e exception;
begin
    select id_judet, j.id_DSP, d.nr_teste_pozitive, d.nr_teste_negative, d.telefon
    into v_cod, v_id_DSP, v_nrp, v_nrn, v_tel  --a
    from judet j, dsp d
    where j.nume = introdus
    and j.id_DSP = d.id_DSP;
    
    for i in 1..7
    loop
        if lower(zi) = zile(i) then
            v_id_zi := i;
        end if;
    end loop;
    
    if v_id_zi = 0 then
        raise e;
    end if;
    
    i := 0;
        
    for loc in c_localitate(v_cod) loop
        t_pe_localitate := 0;
        i := i + 1;
        select count(*)
        into t_pe_localitate
        from test t, centru_testare c
        where t.rezultat = 'pozitiv'
        and to_char(t.data_test, 'D') = v_id_zi
        and c.id_centru = t.id_centru
        and c.id_localitate = loc.id_localitate;

        teste_totale := teste_totale + t_pe_localitate;
        
        t(i).nr_teste := t_pe_localitate;
        t(i).nume := loc.nume;
    end loop;
    
    dbms_output.put_line('Datele DSP care se ocupa de judetul ' || introdus || ' sunt: ');
    dbms_output.put_line('ID: ' || v_id_DSP);
    dbms_output.put_line('Numarul de teste pozitive: ' || v_nrp);
    dbms_output.put_line('Numarul de teste negative: ' || v_nrn);
    dbms_output.put_line('Numarul de telefon: ' || v_tel);
    
    for j in 1..i loop
        sorted.extend(1);
        sorted(sorted.last) := new sortable_t(t(j).nr_teste, t(j).nume);
    end loop;
    
    select cast (multiset (select *
                            from table(sorted)
                            order by 1 desc)
                  as sortable_table_t)
    into sorted 
    from dual;
    --Sort1
    for j in 1..(i - 1) loop
        for k in j + 1.. i loop
            if t(j).nr_teste < t(k).nr_teste then
                swap_helper := t(j);
                t(j) := t(k);
                t(k) := swap_helper;
            end if;
        end loop;
    end loop;
    
    for j in 1..i loop
        dbms_output.put_line(j || '. ' || t(j).nume || ' : ' || t(j).nr_teste);
    end loop;
    dbms_output.new_line();
    dbms_output.put_line('Cealalta varianta de sortare');
    --Sort2
    for j in sorted.first..sorted.last loop
        dbms_output.put_line(j || '. ' || sorted(j).nume || ' : ' || sorted(j).nr_teste);
    end loop;
exception
    when no_data_found then
        dbms_output.put_line('Judetul introdus nu exista');
    when too_many_rows then
        dbms_output.put_line('Doua judete cu acelasi nume');
    when e then
        dbms_output.put_line('Textul introdus nu e o zi valida a saptamanii');
        
end statistici_judete;

procedure insert_test(t_id_pacient test.id_pacient%type, din test.data_test%type, t_id_centru test.id_test%type, t_rezultat test.rezultat%type)
is
    v_DSP DSP.id_DSP%type;
    v_medic pacient.id_medic%type;
    V number := 0;
begin
    select j.id_DSP     --TODO:fix eroare aici
    into v_DSP
    from centru_testare c, localitate l, judet j
    where c.id_centru = t_id_centru
    and l.id_localitate = c.id_localitate
    and l.id_judet = j.id_judet;
    V := 1;
    if t_rezultat = 'pozitiv' then
        update centru_testare ct
        set 
        ct.numar_teste_pozitive = ct.numar_teste_pozitive + 1
        where ct.id_centru = t_id_centru;
        
        update DSP d
        set d.nr_teste_pozitive = d.nr_teste_pozitive + 1
        where d.id_DSP = v_DSP;
        
        insert into pozitiv values(t_id_pacient, din + 1, din + 14);
        
        select p.id_medic
        into v_medic
        from pacient p
        where p.id_pacient = t_id_pacient;
        
        update medic_familie
        set 
        bolnavi_in_lista = bolnavi_in_lista + 1
        where id_medic = v_medic;
    else
        update centru_testare ct
        set 
        ct.numar_teste_negative = ct.numar_teste_negative + 1
        where ct.id_centru = t_id_centru;
        
        update DSP d
        set d.nr_teste_negative = d.nr_teste_negative + 1
        where d.id_DSP = v_DSP;
        
        insert into negativ values(t_id_pacient);
    end if;
exception
    when no_data_found then
        dbms_output.put_line('Nu exista un centru cu acest ID');
    when too_many_rows then
        dbms_output.put_line(V || 'Prea multe centre cu acest ID');
end insert_test;

procedure update_test(t_id_pacient test.id_pacient%type, di test.data_test%type, t_id_centru test.id_centru%type, rezultat_vechi test.rezultat%type, rezultat_nou test.rezultat%type)
is
    v_DSP DSP.id_DSP%type;
    v_medic pacient.id_medic%type;
begin
            select p.id_medic 
            into v_medic
            from pacient p
            where p.id_pacient = t_id_pacient;
            
            select d.id_DSP
            into v_DSP
            from centru_testare c, localitate l, judet j, DSP d
            where c.id_centru = t_id_centru
            and l.id_localitate = c.id_localitate
            and l.id_judet = j.id_judet
            and j.id_DSP =d.id_DSP;

    if rezultat_nou != rezultat_vechi then
        if rezultat_nou = 'pozitiv' then
            delete from negativ n
            where n.id_pacient_n = t_id_pacient;
            insert into pozitiv 
            values(t_id_pacient, di + 14, di + 1);
         
            update medic_familie
            set bolnavi_in_lista = bolnavi_in_lista + 1
            where id_medic = v_medic;
            
            update centru_testare ct
            set ct.numar_teste_pozitive = ct.numar_teste_pozitive + 1,
                ct.numar_teste_negative = ct.numar_teste_negative - 1
            where t_id_centru = ct.id_centru;
            
            update DSP d
            set d.nr_teste_pozitive = d.nr_teste_pozitive + 1,
                d.nr_teste_negative = d.nr_teste_negative - 1
            where d.id_DSP = v_DSP;
        else
            delete from pozitiv p
            where p.id_pacient_p = t_id_pacient;
            insert into negativ n 
            values (t_id_pacient);
            
            update medic_familie
            set bolnavi_in_lista = bolnavi_in_lista - 1
            where id_medic = v_medic;
            
            update centru_testare ct
            set ct.numar_teste_negative = ct.numar_teste_negative + 1,
                ct.numar_teste_pozitive = ct.numar_teste_pozitive - 1
            where t_id_centru = ct.id_centru;
            
            update DSP d
            set d.nr_teste_pozitive = d.nr_teste_pozitive - 1,
                d.nr_teste_negative = d.nr_teste_negative + 1
            where d.id_DSP = v_DSP;
        end if;
    end if;
end update_test;
end obiecte_proiect;
/

begin
obiecte_proiect.statistici_simptome;
end;
/

begin
obiecte_proiect.info_contacti;
end;
/

BEGIN
      DBMS_OUTPUT.PUT_LINE('Numarul de grav bolnavi din lista medicului e: '|| obiecte_proiect.simptome_pacienti_medic('Voicu'));
END;
/
BEGIN
      DBMS_OUTPUT.PUT_LINE('Numarul de grav bolnavi din lista medicului e: '|| obiecte_proiect.simptome_pacienti_medic('A'));
END;
/
BEGIN
      DBMS_OUTPUT.PUT_LINE('Numarul de grav bolnavi din lista medicului e: '|| obiecte_proiect.simptome_pacienti_medic('Stefanoiu'));
END;
/
BEGIN
      DBMS_OUTPUT.PUT_LINE('Numarul de grav bolnavi din lista medicului e: '|| obiecte_proiect.simptome_pacienti_medic('Gabor'));
END;
/
BEGIN
      DBMS_OUTPUT.PUT_LINE('Numarul de grav bolnavi din lista medicului e: '|| obiecte_proiect.simptome_pacienti_medic('Comeaga'));
END;
/

begin
obiecte_proiect.statistici_judete('Alba', 'Azi'); --nu exista ziua
end;
/
begin
obiecte_proiect.statistici_judete('A', 'Miercuri'); --nu exista judetul
end;
/
begin
obiecte_proiect.statistici_judete('Alba', 'Sambata');
end;
/
begin
obiecte_proiect.statistici_judete('Vrancea', 'Sambata');
end;
/

--14
create table programari (nume VARCHAR2(30 BYTE), prenume VARCHAR2(30 BYTE));
create or replace package gestionare_programari
is
    procedure adauga_pacient(v_nume pacient.nume%type, v_prenume pacient.prenume%type,
    v_sex pacient.sex%type, v_telefon pacient.telefon%type, v_mail pacient.mail%type, v_familie pacient.id_familie%type, 
    v_job pacient.id_job%type, v_tip CHAR, v_medic pacient.id_medic%type, v_localitate pacient.id_localitate%type, v_data pacient.data_nasterii%type);
    --done
    procedure add_new_data_for_test; --done
    front NUMBER(6,0) := 1;
    rear NUMBER(6,0) := 1;
    type coada is VARRAY(300) of NUMBER(6,0);
    q coada := coada();
    procedure push(id_curent pacient.id_pacient%type);
    procedure pop;
    function first return number;
    function empty return number;
    procedure rezolvare;
    procedure get_file_content; --done
    procedure put_file_content; --done
    type tip_programare is record (nume_programare pacient.nume%type, prenume_programare pacient.prenume%type);
    type vector_citire is table of tip_programare index by PLS_INTEGER;
    programare vector_citire;
    function get_cod(v_nume pacient.nume%type, v_prenume pacient.prenume%type) return NUMBER; --done
end;
/

create or replace package body gestionare_programari
is
    procedure adauga_pacient(v_nume pacient.nume%type, v_prenume pacient.prenume%type,
    v_sex pacient.sex%type, v_telefon pacient.telefon%type, v_mail pacient.mail%type, v_familie pacient.id_familie%type, 
    v_job pacient.id_job%type, v_tip CHAR, v_medic pacient.id_medic%type, v_localitate pacient.id_localitate%type, v_data pacient.data_nasterii%type)
    is
    begin
        insert into pacient values(pacient_seq.nextval, v_nume, v_prenume, v_sex, v_telefon, v_mail, v_familie, v_job,
        v_medic, v_localitate, v_data);
        
        update familie
        set membri = membri + 1
        where id_familie = v_familie;
        
        if v_tip = 'f' then
            update job_fizic
            set 
            angajati = angajati + 1
            where id_job_f = v_job;
            end if;
    end adauga_pacient;
   
   procedure add_new_data_for_test
   is begin

    adauga_pacient('Grigore', 'Mitrita', 'FEMEIE', '0752 129 333', 'GD@test.com', 16, 116, 'r', 18, 21, to_date('12-01-2000', 'DD-MM-YYYY'));
    adauga_pacient('Apostu', 'Lucia', 'FEMEIE', '0752 133 333', 'AL@test.com', 17, 117, 'f', 18, 21, to_date('22-10-1971', 'DD-MM-YYYY'));
  
   end add_new_data_for_test;
   
   function get_cod(v_nume pacient.nume%type, v_prenume pacient.prenume%type)
   return NUMBER IS v_cod NUMBER(6,0);
   v_c NUMBER(6,0);
   begin
    v_c := 0;
    select id_pacient
    into v_c
    from pacient
    where nume = v_nume and prenume = v_prenume;
    return v_c;
   exception
   when no_data_found then
        dbms_output.put_line('Nu am gasit pacienti cu acest nume');
    when too_many_rows then
        dbms_output.put_line('Prea multi pacienti cu acest nume');
   end get_cod;
   
   procedure push(id_curent pacient.id_pacient%type) is
   BEGIN
        q.extend;
        q(rear) := id_curent;
        rear := rear + 1;

   END push;
   
   procedure pop is
        i NUMBER(6,0);
   BEGIN
        q.extend;
        q(rear) := 0;
        for i in 1..rear - 1 loop
            q(i) := q(i + 1);
        end loop;
        rear := rear - 1;
   END pop;
   
   function first
   return NUMBER is
        v_primul NUMBER(6,0);
    begin
        v_primul := 0;
        v_primul := q(front);
        return v_primul;
    end first;
    
    function empty
    return NUMBER is
        check1 NUMBER(6,0);
    begin
        if rear = 0 then
            check1 := 1;
        else 
            check1 := 0;
        end if;
        return check1;
    end empty;
   procedure get_file_content is
    l_file utl_file.file_type;
    l_text VARCHAR2(32767);
    l_cnt NUMBER;
    begin
        l_file := utl_file.fopen('UTL_FILE_DIR', 'programari.txt', 'R', 32767);
    loop
        utl_file.get_line(l_file, l_text, 32767);
        insert into programari(nume, prenume)
            values (regexp_substr(l_text, '[^,]+', 1,1),
                    regexp_substr(l_text, '[^,]+', 1,2));
    end loop;
    utl_file.fclose(l_file);
    exception
        when no_data_found then
            dbms_output.put_line('Nu s-a gasit nimic');
    end get_file_content;
    
    procedure put_file_content is
    v_file utl_file.file_type;
    cursor c is select * from test where id_centru = 21;
    begin
         v_file := utl_file.fopen('UTL_FILE_DIR', 'programari_output.txt', 'W');
         for ins in c loop
            utl_file.new_line(v_file);
            utl_file.put(v_file, ins.id_test);
            utl_file.put(v_file, '. pacient ');
            utl_file.put(v_file, ins.id_pacient);
            utl_file.put(v_file, ':  ');
            utl_file.put(v_file, ins.rezultat);
            utl_file.put(v_file, ' efectuat la centrul ');
            utl_file.put(v_file, ins.id_centru);
            utl_file.put(v_file, ' pe data de ');
            utl_file.put(v_file, ins.data_test);
         end loop;
         utl_file.fclose(v_file);
         exception
            when others then
                utl_file.fclose(v_file);
                raise;
    end put_file_content;
    
    procedure rezolvare is
    cursor c_programari is select * from programari;
    v_cod NUMBER(6,0);
    i NUMBER(6,0);
    current NUMBER(6,0);
    ok NUMBER(6,0);
    begin
        for prog in c_programari loop
            v_cod := get_cod(prog.nume, prog.prenume);
            push(v_cod);
        end loop;
        ok := empty(); current := first(); 
        while ok = 0 and current != 0
        loop
           
            dbms_output.put_line(current);
            pop();
            insert into test values(test_seq.nextval, current, 'pozitiv', 21, to_date(sysdate, 'DD-MM-YYYY'));
            ok := empty();
            current := first();
            end loop;
    end rezolvare;
end;
/

select * from test;

begin
    gestionare_programari.add_new_data_for_test;
end;
/
SELECT * FROM programari;
delete from programari;
begin
    gestionare_programari.get_file_content;
end;
/
begin
    gestionare_programari.rezolvare;
end;
/
begin
    gestionare_programari.put_file_content;
end;
/



select * from programari;
insert into familie values(familie_seq.nextval, 0);
insert into familie values(familie_seq.nextval, 0);
insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);
insert into job values(job_seq.nextval);
insert into job_fizic values(115, 0);
insert into job_fizic values(117, 0);
insert into job_remote values(116);
insert into job_remote values(118);
