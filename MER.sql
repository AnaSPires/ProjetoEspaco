create table Usuario(
CodUsuario int primary key,
Nome varchar(30),
dataNascimento datetime,
senha  varbinary(10))

create table Acesso(
codAcesso int primary key,
codUsuario int,
dataAcesso datetime,
horaAcesso datetime,
constraint fkUsuario foreign key(codUsuario) references Usuario(CodUsuario)
)
