var database = require("../database/config");

function atualizarDadosFuncionario(nome, sobrenome, cargo, permissao, idFuncionario){
    instrucaoSQL = `
    UPDATE Funcionario 
    SET nome = '${nome}', sobrenome = '${sobrenome}', cargo = '${cargo}', adm = ${permissao} 
    WHERE idFuncionario = '${idFuncionario}'`;
    console.log(instrucaoSQL);
    return database.executar(instrucaoSQL);
}


module.exports = {
    atualizarDadosFuncionario
}