create database Tarefa02BD_Maternidade_Ex1
go 
use Tarefa02BD_Maternidade_Ex1
go
Create Table Mae (
ID_mae			int				not null	identity(1001, 1),
nome			varchar(60)		not null,
End_logradouro	varchar(100)	not null,
End_num			integer			not null	check(End_num >=0),
End_CEP			char(8)			not null	check(Len(End_CEP) = 8),
End_complemento	varchar(200)	not null,
telefone		char(10)		not null	check(Len(telefone) = 10),
data_nasc		date			not null
Primary key (ID_mae)
)
go
Create Table Medico (
CRM_numero		int				not null,
CRM_UF			char(2)			not null,
nome			varchar(60)		not null,
telefone		char(11)		not null	check(Len(telefone) = 11) Unique,
especialidade	varchar(30)		not null
Primary key (CRM_numero, CRM_UF)
)
go
Create Table Bebe (
ID_bebe			int				not null	identity(1, 1),
nome			varchar(60)		not null,
data_nasc		date			not null	default('2023-10-17'),
altura			decimal(7, 2)	not null	check(altura >= 0),
peso			decimal(4, 3)	not null	check(peso >= 0),
ID_mae			int				not null
Primary key (ID_bebe)
Foreign key (ID_mae) references Mae(ID_mae)
)
Create Table Bebe_Medico (
ID_bebe			int				not null,
CRM_numero		int				not null,
CRM_UF			char(2)			not null
Primary key (ID_bebe, CRM_numero, CRM_UF)
Foreign key (ID_bebe) references Bebe(ID_bebe),
Foreign key (CRM_numero, CRM_UF) references Medico(CRM_numero, CRM_UF)
)

-- TESTANDO MAE

-- Inserir um registro válido
INSERT INTO Mae VALUES 
('Maria Silva', 'Rua A', 123, '12345678', 'Apartamento 101', '1234567890', '1990-01-01'),
('Joana Santos', 'Rua B', -5, '87654321', 'Casa 202', '9876543210', '1985-05-15'), -- Tentar inserir um registro com End_num < 0 (violando a restrição)
('Ana Oliveira', 'Rua C', 456, '12345', 'Sala 303', '1357924680', '1978-09-20'); -- Tentar inserir um registro com End_CEP com comprimento diferente de 8 (violando a restrição)

INSERT INTO Mae VALUES 
('Kelly Cristina', 'Av. Cangaiba', 1153, '03711003', 'Apartamento 12', '1196457213', '1973-04-24');

select * from Mae

-- TESTANDO MEDICO

INSERT INTO Medico VALUES
(12345, 'SP', 'Dr. Silva', '11987654321', 'Cardiologia'),
(67890, 'RJ', 'Dra. Oliveira', '21987654321', 'Pediatria'),
(13579, 'MG', 'Dr. Rodrigues', '1198765432', 'Ortopedia'), -- Tentar inserir um registro com telefone com comprimento diferente de 11 (violando a restrição)
(24680, 'SP', 'Dra. Pereira', '11987654321', 'Oftalmologia'); -- Tentar inserir um registro com telefone já existente (violando a restrição Unique)

select * from Medico

-- TESTANDO BEBE

INSERT INTO Bebe VALUES 
('Bebê A', '2023-10-15', 50.5, 3.2, 1001),
('Bebê B', '2023-10-16', -10.0, 3.5, 1002), -- Tentar inserir um registro com altura < 0 (violando a restrição)
('Bebê C', '2023-10-18', 45.0, -2.0, 1003) -- Tentar inserir um registro com peso < 0 (violando a restrição)

select * from Bebe

Insert into Bebe (nome, altura, peso, ID_mae) values
('Gustavo', 46.0, 2.2, 1004)
