create table Usuario(
CodUsuario int primary key,
Nome varchar(30),
dataNascimento datetime,
senha  varchar(10))

drop table Usuario
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

select * from Perguntas

insert into Perguntas values('Qual o maior planeta do sistema solar?', 'Plut�o', 'J�piter', 'Saturno', 'Terra', 'b');
insert into Perguntas values('Qual o menor planeta do sistema solar?', 'Merc�rio', 'Netuno', 'Marte', 'Terra', 'a');
insert into Perguntas values('Qual o planeta mais legal do sistema solar?', 'Plut�o', 'J�piter', 'Saturno', 'Terra', 'd');

update Perguntas set enunciado = 'Existem quantos Planetas no Sistema solar?' where codPergunta = 3
update Perguntas set alternativaA = '5' where codPergunta = 3
update Perguntas set alternativaB = '6' where codPergunta = 3
update Perguntas set alternativaC = '7' where codPergunta = 3
update Perguntas set alternativaD = '8' where codPergunta = 3

insert into Perguntas values('Existem quantos "planetas an�es", no Sistema Solar?', '1', '3', '5', '4', 'c')

insert into Perguntas values('A partir de 2006, qual destes planetas deixou de ser considerado um Planeta?', 'Merc�rio', 'Plut�o', 'V�nus', 'Netuno', 'b')

insert into Perguntas values('Qual o planeta que est� mais pr�ximo do Sol?', 'Terra', 'Urano', 'V�nus', 'Merc�rio', 'd')
insert into Perguntas values('O Planeta Terra tem aproximadamente quantos bilh�es de anos ?', '4,5', '5,5', '6,6', '5,6', 'a')
insert into Perguntas values('Quais s�o os planetas tel�ricos do sistema solar?', 'Urano, Marte, Plut�o e Merc�rio', '
Terra, Saturno, V�nus e Marte', '
Merc�rio, V�nus, Terra e Marte', 'Plut�o, V�nus, J�piter e Merc�rio', 'c')

update Perguntas set enunciado = 'Qual � a maior estrela do sistema solar?' where codPergunta = 9
update Perguntas set alternativaA = 'Rigel' where codPergunta = 9
update Perguntas set alternativaB = 'Polaris' where codPergunta = 9
update Perguntas set alternativaC = 'Deneb' where codPergunta = 9
update Perguntas set alternativaD = 'Sol' where codPergunta = 9
update Perguntas set correta = 'd' where codPergunta = 9

insert into Perguntas values('Qual � o planeta que � composto por 75% de �gua?', 'Terra', 'Urano', 'Netuno', 'Merc�rio', 'a')


create table Arquivos(
imagens varchar(30),
sons varchar(30),
videos varchar(30)
)

select * from Arquivos

create table SistemaSolar(
codSistema int primary key,
descricao ntext)

select * from SistemaSolar

create table Elementos(
codAcesso int not null,
nome varchar(30) not null,
descricao varchar(30),
tamanho varchar(45),
massa varchar(45),
distancia varchar(15),
periodoOrbital varchar(15),
periodoRotacao varchar(15),
gravidade varchar(15),
temperatura varchar(15),
composicao varchar(30),
estrutura varchar(15)
)
 
select * from Elementos

insert into Elementos values(1, 'Merc�rio', 'Mais perto do sol', 'Merc�rio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(2, 'V�nus', 'Mais perto do sol', 'Merc�rio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(3, 'Terra', 'Mais perto do sol', 'Merc�rio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(4, 'Marte', 'Mais perto do sol', 'Merc�rio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(5, 'J�piter', 'Mais perto do sol', 'Merc�rio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(6, 'Saturno', 'Mais perto do sol', 'Merc�rio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(7, 'Urano', 'Mais perto do sol', 'Merc�rio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(8, 'Netuno', 'Mais perto do sol', 'Merc�rio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(9, 'Plut�o', 'Mais perto do sol', 'Merc�rio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(10, 'Sol', 'Mais perto do sol', 'Merc�rio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')


