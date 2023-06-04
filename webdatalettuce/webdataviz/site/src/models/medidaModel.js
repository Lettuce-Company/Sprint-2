var database = require("../database/config");

function buscarUltimasMedidas(placa, limite_linhas) {
    instrucaoSql = `select * from VW_Grafico where placa = '${placa}' order by idLeitura desc limit ${limite_linhas};`;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoRealKPIS(placa) {

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

function buscarMedidasEmTempoRealGraficos(placa) {

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
        instrucaoSql = `select * from VW_Grafico where placa = '${placa}' order by idLeitura desc limit 2;`;
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
        instrucaoSql = `SELECT
    MAX(leitura.temperatura) AS maximo_temperatura,
    MAX(leitura.umidade) AS maximo_umidade,
    MIN(leitura.temperatura) AS minimo_temperatura,
    MIN(leitura.umidade) AS minimo_umidade
FROM
    VW_KPI_Extremos leitura
    JOIN (
        SELECT idLeitura
        FROM VW_KPI_Extremos
        WHERE
            fkCaminhao = '${placa}'
            AND fkSensor = (
                SELECT idSensor FROM Sensor WHERE fkCaminhaoSensor = '${placa}'
            )
        ORDER BY idLeitura DESC
        LIMIT 7
    ) AS subquery ON leitura.idLeitura = subquery.idLeitura`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}



module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoRealKPIS,
    buscarMedidasEmTempoRealGraficos,
    buscarMedidasMaximasMinimas
}
