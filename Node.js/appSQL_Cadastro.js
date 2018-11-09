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

rota.get('/usuario', (requisicao, resposta) =>{
execSQL('SELECT * FROM Usuario', resposta);
})
//Deletar
rota.get('/usuario/:id?', (requisicao, resposta) => {
  let filtro = '';
  if (requisicao.params.id) 
    filtro = ' WHERE ID=' + parseInt(requisicao.params.id);
  execSQL('SELECT * from Usuario' + filtro, resposta);
})

// testar no POSTMAN
rota.delete('/usuario/:id', (requisicao, resposta) =>{
  execSQL('DELETE Usuario WHERE ID=' + parseInt(requisicao.params.CodUsuario), resposta);
  resposta.end(resposta.json({ mensagem: 'Deletado!'}));
})



rota.get('/usuario', (requisicao, resposta) =>{
    const nome = requisicao.body.nome.substring(0,40);
    const email = requisicao.body.email.substring(0,40);
    const data = requisicao.body.dataNascimento.substring(0,11);
    const senha = requisicao.body.Senha.substring(0,20);
    const telefone = requisicao.body.telefone.substring(0,20);
    execSQL(`Inserir_sp @nome = ${nome}, @email = ${email}, @telefone = ${telefone}, @data = ${data}, @senha = ${senha})`, resposta);
    resposta.end(resposta.json({ mensagem: 'Incluído!'}));    
})
