var database = require("../database/config");

function buscarUltimasMedidas(placa) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top ${limite_linhas}
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        momento,
                        FORMAT(momento, 'HH:mm:ss') as momento_grafico
                    from medida
                    where fk_aquario = ${placa}
                    order by id desc`;
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `SELECT temperatura, umidade, dtHora FROM VW_KPI_Atuais WHERE fkCaminhao = '${placa}' AND fkSensor  = (SELECT 
            idSensor
            FROM Sensor WHERE fkCaminhaoSensor = '${placa}')
            ORDER BY idLeitura DESC LIMIT 1`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(placa) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top 1
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        CONVERT(varchar, momento, 108) as momento_grafico, 
                        fk_aquario 
                        from medida where fk_aquario = '${placa}' 
                    order by id desc`;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `SELECT temperatura, umidade, dtHora FROM VW_KPI_Atuais WHERE fkCaminhao = '${placa}' AND fkSensor  = (SELECT 
            idSensor
            FROM Sensor WHERE fkCaminhaoSensor = '${placa}')
            ORDER BY idLeitura DESC LIMIT 7`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasMaximasMinimas(placa) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top 1
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        CONVERT(varchar, momento, 108) as momento_grafico, 
                        fk_aquario 
                        from medida where fk_aquario = '${placa}' 
                    order by id desc`;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `SELECT max(temperatura) as maximo_temperatura, max(umidade) as maximo_umidade , min(temperatura) as minimo_temperatura, min(umidade) as minimo_umidade
         FROM
         VW_KPI_Extremos 
         WHERE fkCaminhao = '${placa}' AND fkSensor = (SELECT 
            idSensor
            FROM Sensor WHERE fkCaminhaoSensor = '${placa}')  order by idLeitura DESC LIMIT 7;`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}



module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    buscarMedidasMaximasMinimas
}
