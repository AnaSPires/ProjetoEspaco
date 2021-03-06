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

	
insert into Usuario values( 1, 'Amanda', '03/05/2009','25632514', '99-99999-9999', 'ana@gmail.com')
update Usuario set telefone = '(99)99999-9999' where Nome = 'Amanda'

go
update Usuario set senha = 'senha123' where CodUsuario = 1
create proc logar_sp @nome varchar(40), @senha varchar(30)
as
begin
 if (Exists(select * from Usuario where nome = @nome and senha = @senha))
    select * from Usuario where nome = @nome and senha = @senha
  else
    return 0
end

logar_sp 'Amanda', 'senha123'

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

delete from Usuario where CodUsuario = 25
select * from Usuario
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

insert into Perguntas values('Qual o maior planeta do sistema solar?', 'Plut�o', 'J�piter', 'Saturno', 'Terra', 'b');
insert into Perguntas values('Qual o menor planeta do sistema solar?', 'Merc�rio', 'Netuno', 'Marte', 'Terra', 'a');
insert into Perguntas values('Qual o planeta mais legal do sistema solar?', 'Plut�o', 'J�piter', 'Saturno', 'Terra', 'd');

update Perguntas set enunciado = 'Existem quantos Planetas no Sistema solar?' where codPergunta = 3
update Perguntas set alternativaA = '5' where codPergunta = 3
update Perguntas set alternativaB = '6' where codPergunta = 3
update Perguntas set alternativaC = '7' where codPergunta = 3
update Perguntas set alternativaD = '8' where codPergunta = 3

update Perguntas set enunciado = 'A partir de 2006, qual destes corpos celestes deixou de ser considerado um Planeta?' where codPergunta = 5

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

---Marte---
update Elementos set descricao = '� o quarto planeta a partir do Sol e o segundo menor planeta do Sistem Solar. Seu nome foi uma homenagem ao deus romano da guerra, � tamb�m conhecido como "Planeta Vermelho", devido � grande quantidade de �xido de ferro(hematita) em sua superf�cie, que lhe d� uma apar�ncia avermelhada. 
 � um Planeta Rochoso, que tem as esta��es do ano similares �s da Terra. Tem 2 Luas conhecidas: Fobos e Deimos, e ao contr�rio de outos planetas, pode ser visto � olho nu da Terra. 
 Possui �gua corrente durante os meses mais quentes, vinda do gelo em seus polos. De sua massa, � estimado que entre 1,5% e 3% sejam de �gua.' where codAcesso = 4
update Elementos set tamanho = '6.779 km' where codAcesso = 4
update Elementos set massa = '6,39 X 10^23 kg' where codAcesso = 4
update Elementos set distancia = 'Do Sol: 230 000 000 km (1,5 UA) - Da Terra: =~ 57,6 milh�es de quil�metros' where codAcesso = 4
update Elementos set periodoOrbital = '687 dias' where codAcesso = 4
update Elementos set periodoRotacao = '24 horas e 37 minutos' where codAcesso = 4
update Elementos set gravidade = '(Equatorial) -- 3.711 m/s� g' where codAcesso = 4
update Elementos set temperatura = '-63�C' where codAcesso = 4
update Elementos set composicao = '95% de di�xido de carbono, 3% nitrog�nio, 1.6% arg�nio e tra�os de oxig�nio, �gua, e metano' where codAcesso = 4
update Elementos set estrutura = '' where codAcesso = 4
---Merc�rio---
update Elementos set descricao = '' where codAcesso = 1
update Elementos set tamanho = '4.879 km' where codAcesso = 1
update Elementos set massa = '200,59 u � 0,02 u ' where codAcesso = 1
update Elementos set distancia = 'Do Sol: 57.910.000 km Da Terra: ' where codAcesso = 1
update Elementos set periodoOrbital = '88 dias' where codAcesso = 1
update Elementos set periodoRotacao = '58,646 dias (?1 407,5?) horas' where codAcesso = 1
update Elementos set gravidade = '3,7 m/s�' where codAcesso = 1
update Elementos set temperatura = '169,35 �C' where codAcesso = 1
update Elementos set composicao = '' where codAcesso = 1
update Elementos set estrutura = '' where codAcesso = 1
---V�nus--
update Elementos set descricao = '' where codAcesso = 2
update Elementos set tamanho = '12.104 km' where codAcesso = 2
update Elementos set massa = '4,8�1020 kg ' where codAcesso = 2
update Elementos set distancia = 'Do Sol: 108.200.000 km  Da Terra: ' where codAcesso = 2
update Elementos set periodoOrbital = '225 dias' where codAcesso = 2
update Elementos set periodoRotacao = '?116d 18h 0m' where codAcesso = 2
update Elementos set gravidade = '8,87 m/s�' where codAcesso = 2
update Elementos set temperatura = '461 �C' where codAcesso = 2
update Elementos set composicao = '' where codAcesso = 2
update Elementos set estrutura = '' where codAcesso = 2

---Terra--
update Elementos set descricao = '' where codAcesso = 3
update Elementos set tamanho = '12.742 km' where codAcesso = 3
update Elementos set massa = '5.9722 � 1024 kg ' where codAcesso = 3
update Elementos set distancia = 'Do Sol: 149.600.000 km  Da Terra: ' where codAcesso = 3
update Elementos set periodoOrbital = '365 dias' where codAcesso = 3
update Elementos set periodoRotacao = '?24h' where codAcesso = 3
update Elementos set gravidade = '9,8m/s�' where codAcesso = 3
update Elementos set temperatura = '14�C' where codAcesso = 3
update Elementos set composicao = '' where codAcesso = 3
update Elementos set estrutura = '' where codAcesso = 3

---Jupiter--
update Elementos set descricao = '' where codAcesso = 5
update Elementos set tamanho = '139.822 km' where codAcesso = 5
update Elementos set massa = '1,8986 � 1027 kg' where codAcesso = 5
update Elementos set distancia = 'Do Sol: 778.500.000 km Da Terra: ' where codAcesso = 5
update Elementos set periodoOrbital = '12 anos' where codAcesso = 5
update Elementos set periodoRotacao = '?0d 9h 56m' where codAcesso = 5
update Elementos set gravidade = '24,79 m/s�' where codAcesso = 5
update Elementos set temperatura = '-108 �C' where codAcesso = 5
update Elementos set composicao = '' where codAcesso = 5
update Elementos set estrutura = '' where codAcesso = 5

---Saturno--
update Elementos set descricao = '' where codAcesso = 6
update Elementos set tamanho = '116.464 km,' where codAcesso = 6
update Elementos set massa = '5,6846 � 1026 kg' where codAcesso = 6
update Elementos set distancia = 'Do Sol: 1,434 � 10^9 km  Da Terra: ' where codAcesso = 6
update Elementos set periodoOrbital = '29 anos' where codAcesso = 6
update Elementos set periodoRotacao = '?0d 10h 42m' where codAcesso = 6
update Elementos set gravidade = '10,44 m/s�' where codAcesso = 6
update Elementos set temperatura = '-139 �C ' where codAcesso = 6
update Elementos set composicao = '' where codAcesso = 6
update Elementos set estrutura = '' where codAcesso = 6

---Urano--
update Elementos set descricao = '' where codAcesso = 7
update Elementos set tamanho = '50.724 km' where codAcesso = 7
update Elementos set massa = '238,02891 u � 0,00003 u' where codAcesso = 7
update Elementos set distancia = 'Do Sol: 2,871 � 10^9 km  Da Terra: ' where codAcesso = 7
update Elementos set periodoOrbital = '84 anos' where codAcesso = 7
update Elementos set periodoRotacao = '?0d 17h 14m' where codAcesso = 7
update Elementos set gravidade = '8,87 m/s�' where codAcesso = 7
update Elementos set temperatura = '�224 �C ' where codAcesso = 7
update Elementos set composicao = '' where codAcesso = 7
update Elementos set estrutura = '' where codAcesso = 7


---Netuno--
update Elementos set descricao = '' where codAcesso = 8
update Elementos set tamanho = '49.244 km' where codAcesso = 8
update Elementos set massa = '237.0482 u' where codAcesso = 8
update Elementos set distancia = 'Do Sol: 4,495 � 10^9 km Da Terra: ' where codAcesso = 8
update Elementos set periodoOrbital = '165 anos' where codAcesso = 8
update Elementos set periodoRotacao = '?0d 16h 6m' where codAcesso = 8
update Elementos set gravidade = '11,15 m/s�' where codAcesso = 8
update Elementos set temperatura = '-210�C' where codAcesso = 8
update Elementos set composicao = '' where codAcesso = 8
update Elementos set estrutura = '' where codAcesso = 8


---Plut�o--
update Elementos set descricao = '' where codAcesso = 9
update Elementos set tamanho = '2.377 km' where codAcesso = 9
update Elementos set massa = '(1,305 � 0,007) � 10^22 kg' where codAcesso = 9
update Elementos set distancia = 'Do Sol: 32,9 UA Da Terra: ' where codAcesso = 9
update Elementos set periodoOrbital = '248 anos' where codAcesso = 9
update Elementos set periodoRotacao = '153 horas' where codAcesso = 9
update Elementos set gravidade = '0,62 m/s�' where codAcesso = 9
update Elementos set temperatura = '-233�C ' where codAcesso = 9
update Elementos set composicao = '' where codAcesso = 9
update Elementos set estrutura = '' where codAcesso = 9

---Sol--
update Elementos set descricao = '' where codAcesso = 10
update Elementos set tamanho = '1.391.016 km ' where codAcesso = 10
update Elementos set massa = '?333000*5.9722 � 1024 kg?' where codAcesso = 10
update Elementos set distancia = ' Da Terra: 149.600.000 km' where codAcesso = 10
update Elementos set periodoOrbital = '' where codAcesso = 10
update Elementos set periodoRotacao = '27 dias no seu Equador e 32 dias nos seus p�los?' where codAcesso = 10
update Elementos set gravidade = '274 m/s�' where codAcesso = 10
update Elementos set temperatura = '6.000�C(parte externa) e 15.000.000� C(no n�cleo)' where codAcesso = 10
update Elementos set composicao = '' where codAcesso = 10
update Elementos set estrutura = '' where codAcesso = 10

update Elementos set descricao = 'Merc�rio � o menor planeta do nosso Sistema Solar e tamb�m o que 
fica mais pr�ximo do Sol. Apesar disso, ele n�o � o mais quente (e sim, V�nus), mas circunda o Sol mais r�pido 
do que todos os outros planetas. Por essa raz�o � que talvez os romanos antigos tenham lhe dado o nome de Merc�rio, que era o deus mensageiro mais veloz.'
where codAcesso = 1

update Elementos set descricao = 'Al�m de ser o segundo planeta do Sistema Solar a partir do Sol, 
V�nus � o segundo objeto mais brilhante no c�u noturno depois da Lua, e em dias bem claros tamb�m � 
poss�vel v�-lo a olho nu. � muitas vezes chamado de irm�o da Terra devido � sua semelhan�a em tamanho 
e massa com o nosso planeta, e existem apenas 638 quil�metros de diferen�a em di�metro entre os dois.' where codAcesso = 2

update Elementos set descricao = 'A Terra � o quinto maior planeta do Sistema Solar e o �nico a ter uma camada 
de gases na atmosfera que garante condi��es para a exist�ncia de vida aqui.Cerca de 70% da superf�cie do planeta � 
coberta por �gua em estado l�quido, elemento essencial para a exist�ncia de formas de vida. Se a Terra n�o girasse, n�o existiria vida. � que o lado do planeta que ficasse voltado para o Sol 
viraria um deserto muito quente e o outro lado ficaria muito escuro e gelado. ' where codAcesso = 3

update Elementos set descricao = 'J�piter � o maior planeta do Sistema Solar e o quinto a partir do Sol. Para fazer jus ao seu tamanho absurdo, ele recebeu o nome do rei dos deuses da mitologia romana � correspondente a Zeus na mitologia grega � e, s� para que voc� tenha uma no��o do tamanho da �crian�a�, mais de 1.300 Terras caberiam em seu interior!

J�piter tamb�m � o planeta mais massivo do Sistema Solar, contando com mais do que o dobro da massa de todos os demais planetas juntos. Al�m disso, se J�piter tivesse 80 vezes mais massa do que tem, ele se tornaria uma estrela em vez de um planeta.' where codAcesso = 5

update Elementos set descricao = 'Depois de J�piter, Saturno � o planeta que gira mais depressa em todo o Sistema Solar, completando uma revolu��o a cada 10,5 horas. Como consequ�ncia disso, esse gigante gasoso conta com os polos mais achatados e o equador mais largo � mais precisamente, a circunfer�ncia em seu equador � 13 mil quil�metros maior do que a circunfer�ncia medida a partir dos polos!' where codAcesso = 6

update Elementos set descricao = 'Urano � o s�timo planeta do Sistema Solar � a partir do Sol � e fica a 2.870.972.200 de quil�metros de dist�ncia da nossa estrela. Al�m disso, ele � o terceiro maior planeta e o quarto com maior massa e, basicamente, pode ser descrito como uma esfera gigantesca de l�quido e g�s. Aproximadamente 80% da massa de Urano � composta por uma mistura fluida de gelos de metano, �gua e am�nia, e em sua atmosfera tamb�m � poss�vel encontrar hidrog�nio e h�lio.' where codAcesso = 7

update Elementos set descricao = 'Netuno � o oitavo planeta do Sistema Solar e se tornou o �ltimo em ordem de afastamento do Sol, desde a reclassifica��o de Plut�o para a categoria de planeta-an�o, em 2006. Ele foi descoberto em 23 de setembro de 1846, mas foi encontrado por uma previs�o matem�tica e n�o atrav�s de uma observa��o.' where codAcesso = 8

update Elementos set descricao = 'Plut�o � um planeta an�o que est� localizado a 5,9 bilh�es de quil�metros distante do Sol.Vale ressaltar que Plut�o n�o � mais considerado um planeta do sistema solar desde 2006. Nesse ano, a Uni�o Astron�mica Internacional o classificou como um "planeta an�o" por conta das novas classifica��es que definiam um corpo celeste como planeta.' where codAcesso = 9

update Elementos set descricao = 'O Sol � puro calor e energia em alt�ssimas escalas. Ele reina absoluto como o maior objeto do nosso sistema. De acordo com dados do Space.com, o astro det�m 99,8% da massa do Sistema Solar, sendo essa 332.900 vezes maior que a da Terra. Para ter uma ideia da sua dimens�o, se o Sol fosse oco, ele poderia ser preenchido com 960 mil Terras esf�ricas!Em se tratando do caldeir�o ardente que o Sol �, a sua parte externa e vis�vel (a fotosfera) emana um calor entre 5.500 a 6 mil graus Celsius, enquanto as temperaturas no n�cleo podem chegar a mais de 15 milh�es de graus Celsius, sendo esse valor impulsionado por rea��es nucleares.' where codAcesso = 10

update Elementos set composicao = 'H�lio, s�dio e oxig�nio' where codAcesso = 1
update Elementos set composicao = 'Di�xido de carbono (96,5%), nitrog�nio (3,5%) e outros gases em menor quantidade (di�xido de enxofre, arg�nio, mon�xido de carbono, vapor de �gua, h�lio, ne�nio).' where codAcesso = 2
update Elementos set composicao = '71% da superf�cie da Terra est� coberta por oceanos de �gua salgada, com o restante consistindo de continentes e ilhas, os quais cont�m muitos lagos e outros corpos de �gua que contribuem para a hidrosfera. ' where codAcesso = 3
update Elementos set composicao = '� composto principalmente de hidrog�nio, sendo um quarto de sua massa composta de h�lio, embora o h�lio corresponda a apenas um d�cimo do n�mero total de mol�culas.' where codAcesso = 5
update Elementos set composicao = '97% de hidrog�nio e 3% de h�lio, com vest�gios de gelo, metano, am�nia, e materiais l�ticos.' where codAcesso = 6
update Elementos set composicao = 'Hidrog�nio e h�lio, cont�m mais "gelos" tais como �gua, am�nia e metano, assim como tra�os de hidrocarbonetos.' where codAcesso = 7
update Elementos set composicao = 'Hidrog�nio (80%), H�lio (19%), Metano (1,5%), Deut�rio (0,019%) e Etano (0,00015%). Por�m, o interior deste planeta � formado basicamente por rochas e gelo.' where codAcesso = 8
update Elementos set composicao = 'Nitrog�nio (90%) e metano mais mon�xido de carbono (10%).' where codAcesso = 9
update Elementos set composicao = 'Hidrog�nio (74% de sua massa, ou 92% de seu volume) e h�lio (24% da massa solar, 7% do volume solar), com tra�os de outros elementos, incluindo ferro, n�quel, oxig�nio, sil�cio, enxofre, magn�sio, n�on, c�lcio e cr�mio.' where codAcesso = 10

alter table Elementos
drop column Estrutura

select * from Elementos

