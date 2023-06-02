var database = require("../database/config");

function buscarUltimasMedidas(placa, limite_linhas) {
    instrucaoSql = `select * from VW_Grafico where placa = '${placa}' order by idLeitura desc limit ${limite_linhas};`;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(placa) {
    instrucaoSql = `select * from VW_Grafico where placa = '${placa}' order by idLeitura desc limit 2;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}
