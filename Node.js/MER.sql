create table Usuario(
CodUsuario int primary key,
Nome varchar(30),
dataNascimento datetime,
senha  varchar(30)
)

alter table Usuario
add telefone varchar(20)

alter table Usuario
add email varchar(40)

alter table Usuario
alter column senha varchar(30)

select * from Usuario
insert into Usuario values( 1, 'Amanda', '03/05/2009','25632514', '99-99999-9999', 'ana@gmail.com')

go

create proc logar_sp @nome varchar(40), @senha varchar(30)
as
begin
 if (Exists(select * from Usuario where nome = @nome and senha = @senha))
    select * from Usuario where nome = @nome and senha = @senha
  else
    return 0
end

logar_sp 'Amanda', '25632514'

create proc Inserir_sp 
@nome ntext,
@email ntext,
@telefone ntext,
@data datetime,
@senha varchar(30)
as
begin
  declare @codigo int
  set @codigo = (select COUNT(CodUsuario) from Usuario) + 1

  insert into Usuario values (@codigo, @nome, @data, @senha, @telefone, @email)

  select * from Usuario where CodUsuario = @codigo
end

Inserir_sp @nome='Teste', @email ='@', @telefone='43241', @data = '12/12/12', @senha='12345678'
Inserir_sp @nome = ${nome}, @email = ${email}, @telefone = ${telefone}, @data = ${data}, @senha = ${senha}

delete from Usuario where CodUsuario = 4
select * from 
sp_help Usuario

-------------------------------------------------------------------------------------------------------
create table Acesso(
codAcesso int primary key,
codUsuario int not null,
dataAcesso datetime not null,
horaAcesso datetime not null,
constraint fkUsuario foreign key(codUsuario) references Usuario(CodUsuario)
)
   
   select COUNT(CodUsuario) from Usuario

select * from Acesso


-------------------------------------------------------------------------------------------------------
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

insert into Perguntas values('Qual o maior planeta do sistema solar?', 'Plutão', 'Júpiter', 'Saturno', 'Terra', 'b');
insert into Perguntas values('Qual o menor planeta do sistema solar?', 'Mercúrio', 'Netuno', 'Marte', 'Terra', 'a');
insert into Perguntas values('Qual o planeta mais legal do sistema solar?', 'Plutão', 'Júpiter', 'Saturno', 'Terra', 'd');

update Perguntas set enunciado = 'Existem quantos Planetas no Sistema solar?' where codPergunta = 3
update Perguntas set alternativaA = '5' where codPergunta = 3
update Perguntas set alternativaB = '6' where codPergunta = 3
update Perguntas set alternativaC = '7' where codPergunta = 3
update Perguntas set alternativaD = '8' where codPergunta = 3

insert into Perguntas values('Existem quantos "planetas anões", no Sistema Solar?', '1', '3', '5', '4', 'c')

insert into Perguntas values('A partir de 2006, qual destes planetas deixou de ser considerado um Planeta?', 'Mercúrio', 'Plutão', 'Vênus', 'Netuno', 'b')

insert into Perguntas values('Qual o planeta que está mais próximo do Sol?', 'Terra', 'Urano', 'Vênus', 'Mercúrio', 'd')
insert into Perguntas values('O Planeta Terra tem aproximadamente quantos bilhões de anos ?', '4,5', '5,5', '6,6', '5,6', 'a')
insert into Perguntas values('Quais são os planetas telúricos do sistema solar?', 'Urano, Marte, Plutão e Mercúrio', '
Terra, Saturno, Vênus e Marte', '
Mercúrio, Vênus, Terra e Marte', 'Plutão, Vênus, Júpiter e Mercúrio', 'c')

update Perguntas set enunciado = 'Qual é a maior estrela do sistema solar?' where codPergunta = 9
update Perguntas set alternativaA = 'Rigel' where codPergunta = 9
update Perguntas set alternativaB = 'Polaris' where codPergunta = 9
update Perguntas set alternativaC = 'Deneb' where codPergunta = 9
update Perguntas set alternativaD = 'Sol' where codPergunta = 9
update Perguntas set correta = 'd' where codPergunta = 9

insert into Perguntas values('Qual é o planeta que é composto por 75% de água?', 'Terra', 'Urano', 'Netuno', 'Mercúrio', 'a')

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

alter table Elementos
alter column descricao ntext

alter table Elementos
alter column distancia ntext

alter table Elementos
alter column periodoRotacao ntext

alter table Elementos
alter column periodoOrbital ntext

alter table Elementos
alter column gravidade ntext

alter table Elementos
alter column composicao ntext

alter table Elementos
alter column estrutura ntext

alter table Elementos
alter column temperatura ntext
 
select * from Elementos

insert into Elementos values(1, 'Mercúrio', 'Mais perto do sol', 'Mercúrio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(2, 'Vênus', 'Mais perto do sol', 'Mercúrio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(3, 'Terra', 'Mais perto do sol', 'Mercúrio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(4, 'Marte', 'Mais perto do sol', 'Mercúrio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(5, 'Júpiter', 'Mais perto do sol', 'Mercúrio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(6, 'Saturno', 'Mais perto do sol', 'Mercúrio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(7, 'Urano', 'Mais perto do sol', 'Mercúrio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(8, 'Netuno', 'Mais perto do sol', 'Mercúrio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(9, 'Plutão', 'Mais perto do sol', 'Mercúrio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')
insert into Elementos values(10, 'Sol', 'Mais perto do sol', 'Mercúrio', 'Menor do sistema', 'fds', 'ds', 'fd', 'fd','fd','s','dd')

---Marte---
update Elementos set descricao = 'É o quarto planeta a partir do Sol e o segundo menor planeta do Sistem Solar. Seu nome foi uma homenagem ao deus romano da guerra, é também conhecido como "Planeta Vermelho", devido à grande quantidade de óxido de ferro(hematita) em sua superfície, que lhe dá uma aparência avermelhada. 
 É um Planeta Rochoso, que tem as estações do ano similares às da Terra. Tem 2 Luas conhecidas: Fobos e Deimos, e ao contrário de outos planetas, pode ser visto à olho nu da Terra. 
 Possui água corrente durante os meses mais quentes, vinda do gelo em seus polos. De sua massa, é estimado que entre 1,5% e 3% sejam de água.' where codAcesso = 4
update Elementos set tamanho = '6.779 km' where codAcesso = 4
update Elementos set massa = '6,39 X 10^23 kg' where codAcesso = 4
update Elementos set distancia = 'Do Sol: 230 000 000 km (1,5 UA) - Da Terra: =~ 57,6 milhões de quilômetros' where codAcesso = 4
update Elementos set periodoOrbital = '687 dias' where codAcesso = 4
update Elementos set periodoRotacao = '24 horas e 37 minutos' where codAcesso = 4
update Elementos set gravidade = '(Equatorial) -- 3.711 m/s² g' where codAcesso = 4
update Elementos set temperatura = '-63°C' where codAcesso = 4
update Elementos set composicao = '95% de dióxido de carbono, 3% nitrogênio, 1.6% argônio e traços de oxigênio, água, e metano' where codAcesso = 4
update Elementos set estrutura = '' where codAcesso = 4
---Mercúrio---
update Elementos set descricao = '' where codAcesso = 1
update Elementos set tamanho = '4.879 km' where codAcesso = 1
update Elementos set massa = '200,59 u ± 0,02 u ' where codAcesso = 1
update Elementos set distancia = 'Do Sol: 57.910.000 km Da Terra: ' where codAcesso = 1
update Elementos set periodoOrbital = '88 dias' where codAcesso = 1
update Elementos set periodoRotacao = '58,646 dias (?1 407,5?) horas' where codAcesso = 1
update Elementos set gravidade = '3,7 m/s²' where codAcesso = 1
update Elementos set temperatura = '169,35 °C' where codAcesso = 1
update Elementos set composicao = '' where codAcesso = 1
update Elementos set estrutura = '' where codAcesso = 1
---Vênus--
update Elementos set descricao = '' where codAcesso = 2
update Elementos set tamanho = '12.104 km' where codAcesso = 2
update Elementos set massa = '4,8×1020 kg ' where codAcesso = 2
update Elementos set distancia = 'Do Sol: 108.200.000 km  Da Terra: ' where codAcesso = 2
update Elementos set periodoOrbital = '225 dias' where codAcesso = 2
update Elementos set periodoRotacao = '?116d 18h 0m' where codAcesso = 2
update Elementos set gravidade = '8,87 m/s²' where codAcesso = 2
update Elementos set temperatura = '461 ºC' where codAcesso = 2
update Elementos set composicao = '' where codAcesso = 2
update Elementos set estrutura = '' where codAcesso = 2

---Terra--
update Elementos set descricao = '' where codAcesso = 3
update Elementos set tamanho = '12.742 km' where codAcesso = 3
update Elementos set massa = '5.9722 × 1024 kg ' where codAcesso = 3
update Elementos set distancia = 'Do Sol: 149.600.000 km  Da Terra: ' where codAcesso = 3
update Elementos set periodoOrbital = '365 dias' where codAcesso = 3
update Elementos set periodoRotacao = '?24h' where codAcesso = 3
update Elementos set gravidade = '9,8m/s²' where codAcesso = 3
update Elementos set temperatura = '14°C' where codAcesso = 3
update Elementos set composicao = '' where codAcesso = 3
update Elementos set estrutura = '' where codAcesso = 3

---Jupiter--
update Elementos set descricao = '' where codAcesso = 5
update Elementos set tamanho = '139.822 km' where codAcesso = 5
update Elementos set massa = '1,8986 × 1027 kg' where codAcesso = 5
update Elementos set distancia = 'Do Sol: 778.500.000 km Da Terra: ' where codAcesso = 5
update Elementos set periodoOrbital = '12 anos' where codAcesso = 5
update Elementos set periodoRotacao = '?0d 9h 56m' where codAcesso = 5
update Elementos set gravidade = '24,79 m/s²' where codAcesso = 5
update Elementos set temperatura = '-108 ºC' where codAcesso = 5
update Elementos set composicao = '' where codAcesso = 5
update Elementos set estrutura = '' where codAcesso = 5

---Saturno--
update Elementos set descricao = '' where codAcesso = 6
update Elementos set tamanho = '116.464 km,' where codAcesso = 6
update Elementos set massa = '5,6846 × 1026 kg' where codAcesso = 6
update Elementos set distancia = 'Do Sol: 1,434 × 10^9 km  Da Terra: ' where codAcesso = 6
update Elementos set periodoOrbital = '29 anos' where codAcesso = 6
update Elementos set periodoRotacao = '?0d 10h 42m' where codAcesso = 6
update Elementos set gravidade = '10,44 m/s²' where codAcesso = 6
update Elementos set temperatura = '-139 ºC ' where codAcesso = 6
update Elementos set composicao = '' where codAcesso = 6
update Elementos set estrutura = '' where codAcesso = 6

---Urano--
update Elementos set descricao = '' where codAcesso = 7
update Elementos set tamanho = '50.724 km' where codAcesso = 7
update Elementos set massa = '238,02891 u ± 0,00003 u' where codAcesso = 7
update Elementos set distancia = 'Do Sol: 2,871 × 10^9 km  Da Terra: ' where codAcesso = 7
update Elementos set periodoOrbital = '84 anos' where codAcesso = 7
update Elementos set periodoRotacao = '?0d 17h 14m' where codAcesso = 7
update Elementos set gravidade = '8,87 m/s²' where codAcesso = 7
update Elementos set temperatura = '–224 °C ' where codAcesso = 7
update Elementos set composicao = '' where codAcesso = 7
update Elementos set estrutura = '' where codAcesso = 7


---Netuno--
update Elementos set descricao = '' where codAcesso = 8
update Elementos set tamanho = '49.244 km' where codAcesso = 8
update Elementos set massa = '237.0482 u' where codAcesso = 8
update Elementos set distancia = 'Do Sol: 4,495 × 10^9 km Da Terra: ' where codAcesso = 8
update Elementos set periodoOrbital = '165 anos' where codAcesso = 8
update Elementos set periodoRotacao = '?0d 16h 6m' where codAcesso = 8
update Elementos set gravidade = '11,15 m/s²' where codAcesso = 8
update Elementos set temperatura = '-210°C' where codAcesso = 8
update Elementos set composicao = '' where codAcesso = 8
update Elementos set estrutura = '' where codAcesso = 8


---Plutão--
update Elementos set descricao = '' where codAcesso = 9
update Elementos set tamanho = '2.377 km' where codAcesso = 9
update Elementos set massa = '?(1,305 ± 0,007) × 10^22 kg' where codAcesso = 9
update Elementos set distancia = 'Do Sol: 32,9 UA Da Terra: ' where codAcesso = 9
update Elementos set periodoOrbital = '248 anos' where codAcesso = 9
update Elementos set periodoRotacao = '153 horas?' where codAcesso = 9
update Elementos set gravidade = '0,62 m/s²' where codAcesso = 9
update Elementos set temperatura = '-233ºC ' where codAcesso = 9
update Elementos set composicao = '' where codAcesso = 9
update Elementos set estrutura = '' where codAcesso = 9

---Sol--
update Elementos set descricao = '' where codAcesso = 10
update Elementos set tamanho = '1.391.016 km ' where codAcesso = 10
update Elementos set massa = '?333000*5.9722 × 1024 kg?' where codAcesso = 10
update Elementos set distancia = ' Da Terra: 149.600.000 km' where codAcesso = 10
update Elementos set periodoOrbital = '' where codAcesso = 10
update Elementos set periodoRotacao = '27 dias no seu Equador e 32 dias nos seus pólos?' where codAcesso = 10
update Elementos set gravidade = '274 m/s²' where codAcesso = 10
update Elementos set temperatura = '6.000°C(parte externa) e 15.000.000° C(no núcleo)' where codAcesso = 10
update Elementos set composicao = '' where codAcesso = 10
update Elementos set estrutura = '' where codAcesso = 10

select * from Elementos