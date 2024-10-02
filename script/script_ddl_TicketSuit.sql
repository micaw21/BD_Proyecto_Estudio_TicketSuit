-- SCRIPT TEMA "TicketSuit"
-- DEFINNICIÓN DEL MODELO DE DATOS

CREATE DATABASE Cine;

USE Cine;

CREATE TABLE Cine
(
  id_cine INT NOT NULL,
  nombre VARCHAR(200) NOT NULL,
  direccion VARCHAR(200) NOT NULL,
  CONSTRAINT PK_cine PRIMARY KEY (id_cine)
);

CREATE TABLE Sala
(
  id_sala INT NOT NULL,
  nombre VARCHAR(200) NOT NULL,
  capacidad INT NOT NULL,
  id_cine INT NOT NULL,
  CONSTRAINT PK_sala PRIMARY KEY (id_sala),
  CONSTRAINT FK_sala_cine FOREIGN KEY (id_cine) REFERENCES Cine(id_cine)
);

CREATE TABLE Asiento
(
  id_asiento INT NOT NULL,
  letra_fila VARCHAR(2) NOT NULL,
  numero_columna INT NOT NULL,
  id_sala INT NOT NULL,
  CONSTRAINT PK_asiento PRIMARY KEY (id_asiento, id_sala),
  CONSTRAINT FK_asiento_sala FOREIGN KEY (id_sala) REFERENCES Sala(id_sala)
);

CREATE TABLE Perfil
(
  id_perfil INT NOT NULL,
  nombre VARCHAR(200) NOT NULL,
  CONSTRAINT PK_perfil PRIMARY KEY (id_perfil)
);

CREATE TABLE TipoFuncion
(
  id_tipoFuncion INT NOT NULL,
  descripcion VARCHAR(200) NOT NULL,
  precio FLOAT NOT NULL,
  CONSTRAINT PK_tipoFuncion PRIMARY KEY (id_tipoFuncion)
);

CREATE TABLE Clasificacion
(
  id_clasificacion INT NOT NULL,
  descripcion VARCHAR(200) NOT NULL,
  nombre VARCHAR(4) NOT NULL,
  CONSTRAINT PK_clasificacion PRIMARY KEY (id_clasificacion)
);

CREATE TABLE Director
(
  id_director INT NOT NULL,
  nombre VARCHAR(200) NOT NULL,
  CONSTRAINT PK_director PRIMARY KEY (id_director)
);

CREATE TABLE Genero
(
  id_genero INT NOT NULL,
  descripcion VARCHAR(200) NOT NULL,
  CONSTRAINT PK_genero PRIMARY KEY (id_genero)
);

CREATE TABLE Usuario
(
  id_usuario INT IDENTITY(1,1),
  nombre VARCHAR(200) NOT NULL,
  password VARCHAR(200) NOT NULL,
  estado INT NOT NULL,
  id_perfil INT NOT NULL,
  id_cine INT NOT NULL,
  CONSTRAINT PK_usuario PRIMARY KEY (id_usuario),
  CONSTRAINT FK_usuario_perfil FOREIGN KEY (id_perfil) REFERENCES Perfil(id_perfil),
  CONSTRAINT FK_usuario_cine FOREIGN KEY (id_cine) REFERENCES Cine(id_cine)
);


CREATE TABLE Pelicula
(
  id_pelicula INT NOT NULL,
  nombre VARCHAR(200) NOT NULL,
  duracion INT NOT NULL,
  id_clasificacion INT NOT NULL,
  id_director INT NOT NULL,
  sinopsis VARCHAR (350) NOT NULL,
  imagen VARCHAR (350),
  nacionalidad VARCHAR (100),
  CONSTRAINT PK_pelicula PRIMARY KEY (id_pelicula),
  CONSTRAINT FK_pelicula_clasificacion FOREIGN KEY (id_clasificacion) REFERENCES Clasificacion(id_clasificacion),
  CONSTRAINT FK_pelicula_director FOREIGN KEY (id_director) REFERENCES Director(id_director),
);

CREATE TABLE Compra
(
  id_compra INT NOT NULL,
  subtotal FLOAT NOT NULL,
  fecha DATE NOT NULL,
  cantidad INT NOT NULL,
  id_usuario INT NOT NULL,
  CONSTRAINT PK_compra PRIMARY KEY (id_compra),
  CONSTRAINT FK_compra_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Funcion
(
  id_funcion INT NOT NULL,
  hora_inicio VARCHAR(6) NOT NULL,
  hora_final VARCHAR(6) NOT NULL,
  fecha DATE NOT NULL,
  id_pelicula INT NOT NULL,
  id_tipoFuncion INT NOT NULL,
  CONSTRAINT PK_funcion PRIMARY KEY (id_funcion),
  CONSTRAINT FK_funcion_pelicula FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula),
  CONSTRAINT FK_funcion_tipoFuncion FOREIGN KEY (id_tipoFuncion) REFERENCES TipoFuncion(id_tipoFuncion)
);

CREATE TABLE Sala_Funcion
(
  id_funcion INT NOT NULL,
  id_sala INT NOT NULL,
  CONSTRAINT PK_sala_funcion PRIMARY KEY (id_funcion, id_sala),
  CONSTRAINT FK_sala_funcion_funcion FOREIGN KEY (id_funcion) REFERENCES Funcion(id_funcion),
  CONSTRAINT FK_sala_funcion_sala FOREIGN KEY (id_sala) REFERENCES Sala(id_sala)
);

CREATE TABLE Ticket
(
  id_ticket INT NOT NULL,
  id_funcion INT NOT NULL,
  id_sala INT NOT NULL,
  id_asiento INT NOT NULL,
  id_compra INT NOT NULL,
  CONSTRAINT PK_ticket PRIMARY KEY (id_ticket),
  CONSTRAINT FK_ticket_sala_funcion FOREIGN KEY (id_funcion, id_sala) REFERENCES Sala_Funcion(id_funcion, id_sala),
  CONSTRAINT FK_ticket_asiento FOREIGN KEY (id_asiento, id_sala) REFERENCES Asiento(id_asiento, id_sala),
  CONSTRAINT FK_ticket_compra FOREIGN KEY (id_compra) REFERENCES Compra(id_compra)
);

CREATE TABLE Genero_Pelicula
(
  id_pelicula INT NOT NULL,
  id_genero INT NOT NULL,
  CONSTRAINT PK_genero_pelicula PRIMARY KEY (id_pelicula, id_genero),
  CONSTRAINT FK_genero_pelicula_pelicula FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula),
  CONSTRAINT FK_genero_pelicula_genero FOREIGN KEY (id_genero) REFERENCES Genero(id_genero)
);
