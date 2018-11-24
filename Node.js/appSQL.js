var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var porta = 3000; //porta padrão
var sql = require('mssql');
var conexaoStr = "Server=regulus;Database=PR118201;User Id=PR118201;Password=PR118201;";

//conexao com BD
sql.connect(conexaoStr)
   .then(conexao => global.conexao = conexao)
   .catch(erro => console.log(erro));

// configurando o body parser para pegar POSTS mais tarde
app.use(bodyParser.urlencoded({ extended: true}));
app.use(bodyParser.json());
/////////////////////////////////
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});
/////////////////////////////////

//definindo as rotas
const rota = express.Router();
rota.get('/', (requisicao, resposta) => resposta.json({ mensagem: 'Funcionando!'}));
app.use('/', rota);

//inicia servidor
app.listen(porta);
console.log('API Funcionando!');

function execSQL(sql, resposta) {
  global.conexao.request()
    .query(sql)
    .then(resultado => resposta.json(resultado.recordset))
    .catch(erro => resposta.json(erro));
}

rota.get('/perguntas', (requisicao, resposta) =>{
execSQL('SELECT * FROM Perguntas', resposta);
})

//o simbolo ? indica que id na rota abaixo é opcional
rota.get('/perguntas/:id?', (requisicao, resposta) => {
let filtro = '';
if (requisicao.params.id)
filtro = ' WHERE codPergunta=' + parseInt(requisicao.params.id);
execSQL('SELECT * from Perguntas' + filtro, resposta);
})

rota.get('/elementos', (requisicao, resposta) =>{
execSQL('SELECT * FROM Elementos', resposta);
})

//o simbolo ? indica que id na rota abaixo é opcional
rota.get('/elementos/:id?', (requisicao, resposta) => {
let filtro = '';
if (requisicao.params.id)
filtro = ' WHERE codAcesso=' + parseInt(requisicao.params.id);
execSQL('SELECT * from Elementos' + filtro, resposta);
})
/////////////////////////////////////////////////////
/*
//cadastro
rota.post('/UsuarioCadastra', (requisicao, resposta) =>{
  const nome = requisicao.body.user;
  const email = requisicao.body.email;
  const data = requisicao.body.aniversario;
  const senha = requisicao.body.senha;
  const telefone = requisicao.body.tel;

  console.log("AQUI: " + data);

  let dataArray = data.split('-');
  let inverseData = dataArray[2] + '/' + dataArray[1] + '/' + dataArray[0];
  console.log(inverseData);
  execSQL(`Inserir_sp @nome = '${nome}', @email = '${email}', @telefone = '${telefone}', @data = '${inverseData}', @senha = '${senha}'`, resposta);
  //execSQL(`insert into Usuario(Nome,Data, Senha,Telefone, Email) values(${nome}, ${email}, ${telefone}, ${data}, ${senha}`, resposta);
  //resposta.end(resposta.json({ mensagem: 'Incluído!'}));
})


//login
rota.get('/Usuario', (requisicao, resposta) =>{
    const nome = requisicao.body.usu.substring(0,40);
    const senha = requisicao.body.senhaa.substring(0,20);
    execSQL(`logar_sp @nome = ${nome}, @senha = ${senha}`, resposta);
    console.log("aqui era pra ter saido");
    resposta.end('resposta');
})

//quiz
rota.get('/perguntas/:id?', (requisicao, resposta) => {
let filtro = '';
if (requisicao.params.id)
filtro = ' WHERE codPergunta=' + parseInt(requisicao.params.id);
execSQL('SELECT * from Perguntas' + filtro, resposta);
})*/

//rota.get('/usuario', (requisicao, resposta) =>{
//execSQL('SELECT * FROM Usuario', resposta);
//})


rota.get('/Usuario', (requisicao, resposta) =>{
    const nome = requisicao.body.usu.substring(0,40);
    const senha = requisicao.body.senhaa.substring(0,20);
    execSQL(`logar_sp @nome = ${nome}, @senha = ${senha}`, resposta);
    console.log("aqui era pra ter saido");
    resposta.end('resposta');
})


rota.post('/UsuarioCadastra', (requisicao, resposta) =>{
  const nome = requisicao.body.user;
  const email = requisicao.body.email;
  const data = requisicao.body.aniversario;
  const senha = requisicao.body.senha;
  const telefone = requisicao.body.tel;

  console.log("AQUI: " + data);

  let dataArray = data.split('-');
  let inverseData = dataArray[2] + '/' + dataArray[1] + '/' + dataArray[0];
  console.log(inverseData);
  execSQL(`Inserir_sp @nome = '${nome}', @email = '${email}', @telefone = '${telefone}', @data = '${inverseData}', @senha = '${senha}'`, resposta);
  //execSQL(`insert into Usuario(Nome,Data, Senha,Telefone, Email) values(${nome}, ${email}, ${telefone}, ${data}, ${senha}`, resposta);
  //resposta.end(resposta.json({ mensagem: 'Incluído!'}));
})
