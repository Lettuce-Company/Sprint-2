var funcionarioModel = require("../models/funcionarioModel");

function atualizarDadosFuncionario(req, res){
    var idFuncionario = req.body.idFuncionario;
    var nome = req.body.nomeFuncionario;
    var sobrenome = req.body.sobrenomeFuncionario;
    var cargo = req.body.cargoFuncionario;
    var permissao = req.body.permissaoFuncionario;

    
    if(nome == undefined){
        res.status(400).send("O nome está indefinido!");
    }else if(cargo == undefined){
        res.status(400).send("O cargo está indefinido!");
    }else if(permissao == undefined){
        res.status(400).send("A permissão está indefinida!");
}
    funcionarioModel.atualizarDadosFuncionario(nome, sobrenome, cargo, permissao, idFuncionario)
    .then( function(resultado){ 
        res.json(resultado);
    }
    ).catch(
        function(erro){
            console.log(erro);
            console.log(
                "\nHouve um erro ao realizar o cadastro! Erro:  ", 
                erro.sqlMessage
            );
            re(500).json(erro.sqlMessage);
        })}          

module.exports = {
    atualizarDadosFuncionario
}