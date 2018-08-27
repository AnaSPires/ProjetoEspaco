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

create table Arquivos(

)
create table SistemaSolar(
codSistema int primary key,
descricao ntext)

create table Elementos(
codAcesso int not null,
nome varchar(30) not null,
descricao ntext,
tamanho varchar(15),
massa varchar(15),
distancia varchar(15),
periodoOrbital varchar(15),
periodoRotacao varchar(15),
gravidade varchar(15),
temperatura varchar(15),
composicao varchar(30),
estrutura varchar(15))
