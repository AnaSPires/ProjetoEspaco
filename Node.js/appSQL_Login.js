var express = require('express');//biblioteca
var app = express();//inicia o express
var bodyParser = require('body-parser');//bibliotaca
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
rota.get('/usuario/:CodUsuario?', (requisicao, resposta) => {
  //let filtro = '';
  // (requisicao.params.id) 
    //filtro = ' WHERE CodUsuario=' + parseInt(requisicao.params.id);
  //execSQL('if((select nome from Usuario where senha = ${senha}) = ${nome}' + filtro, resposta);
})

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
    const telefone = requisicao.body.tel;
    const data = requisicao.body.aniversario;
    const senha = requisicao.body.senha;
   // console.log(requisicao.body);
    console.log(requisicao.body);
   // console.log(email);
   // console.log(telefone);
    execSQL(`Inserir_sp @nome = ${nome}, @email = ${email}, @telefone = ${telefone}, @data = ${data}, @senha = ${senha}`, resposta);
    //execSQL(`insert into Usuario(Nome,Data, Senha,Telefone, Email) values(${nome}, ${email}, ${telefone}, ${data}, ${senha}`, resposta);
    resposta.end(resposta.json({mensagem: requisicao.body}));
})

/*

rota.post('/clientes', (requisicao, resposta) =>{
    const id = parseInt(requisicao.body.id);
    const nome = requisicao.body.nome.substring(0,150);
    const cpf = requisicao.body.cpf.substring(0,11);
    execSQL(`INSERT INTO Clientes(ID, Nome, CPF) VALUES(${id},'${nome}','${cpf}')`, resposta);
    resposta.end(resposta.json({ mensagem: 'Incluído!'}));    
})


*/