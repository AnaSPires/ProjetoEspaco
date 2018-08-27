create table Usuario(
CodUsuario int primary key,
Nome varchar(30),
dataNascimento datetime,
senha  varbinary(10))

create table Acesso(
codAcesso int primary key,
codUsuario int not null,
dataAcesso datetime not null,
horaAcesso datetime not null,
constraint fkUsuario foreign key(codUsuario) references Usuario(CodUsuario)
)
   

create table Respostas(
codResposta ntext primary key,
pontuacao int not null
)
                 
create table Quiz(
codPergunta ntext primary key,
codResposta ntext not null,
constraint fkRespostas foreign key(codRespostas) references Respostas(codRespostas)
)
