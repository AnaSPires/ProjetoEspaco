create table Usuario(
CodUsuario int primary key,
Nome varchar(30),
dataNascimento datetime,
senha  varbinary(10))

select * from Usuario
insert into Usuario values( 1, 'Amanda', '03/05/2009',25632514)

create table Acesso(
codAcesso int primary key,
codUsuario int not null,
dataAcesso datetime not null,
horaAcesso datetime not null,
constraint fkUsuario foreign key(codUsuario) references Usuario(CodUsuario)
)
   
select * from Acesso

create table Perguntas(
codPergunta int identity(1, 1) primary key not null, 
enunciado ntext not null,
alternativaA ntext not null,
alternativaB ntext not null,
alternativaC ntext not null,
alternativaD ntext not null,
correta char not null
)

insert into Perguntas values();

create table Arquivos(
imagens varchar(30),
sons varchar(30),
videos varchar(30)
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
estrutura varchar(15)
)


