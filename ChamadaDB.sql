-- drop database chamada_db;
create database chamada_db;
use chamada_db;
CREATE TABLE perfil(
  perfilID INTEGER primary KEY,
  nome TEXT,
  email TEXT,
  senha TEXT
);

CREATE TABLE disciplina(
  disciplinaID INTEGER PRIMARY KEY,
  nome TEXT,
  perfilID INTEGER,
  CONSTRAINT DISCIPLINA_PERFIL FOREIGN KEY (perfilID) REFERENCES perfil(perfilID)
);

CREATE TABLE aluno(
  alunoID INTEGER PRIMARY KEY,
  nome TEXT
);

CREATE TABLE aluno_disciplina(
  aluno_disciplinaID INTEGER PRIMARY KEY,
  alunoID INTEGER,
  disciplinaID INTEGER,
  CONSTRAINT AD_ALUNO FOREIGN KEY (alunoID) REFERENCES aluno(alunoID),
  CONSTRAINT AD_DISCIPLINA FOREIGN KEY (disciplinaID) REFERENCES disciplina(disciplinaID)
);

CREATE TABLE presenca(
  presencaID INTEGER PRIMARY KEY,
  data DATETIME,
  aluno_disciplinaID INTEGER,
  CONSTRAINT PRESENCA_AD FOREIGN KEY (aluno_disciplinaID) REFERENCES aluno_disciplina(aluno_disciplinaID)
);
