var database = require("../database/config")

function listar() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()");
    var instrucao = `
        SELECT * FROM usuario;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function entrar(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucao = `
    SELECT * FROM Funcionario join Empresa on fkEmpresa = cnpj WHERE funcionario.email = '${email}' AND funcionario.senha = sha2('${senha}',256) and fkEmpresa = (SELECT fkEmpresa where funcionario.email = '${email}');`;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

// Coloque os mesmos parâmetros aqui. Vá para a var instrucao
function cadastrar(nome, sobrenome, cpf, cargo, email, senha, nomeEmpr, cnpj, telefone, telefoneFunc, dtNasc) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, sobrenome, cpf, cargo, email, senha, nomeEmpr, cnpj, telefone, telefoneFunc, dtNasc);
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucao = `INSERT INTO Empresa (nomeEmpr, cnpj, telefone) VALUES ('${nomeEmpr}','${cnpj}', '${telefone}');`;
    var instrucao2 = `INSERT INTO Funcionario (nome, sobrenome, adm, cpf, dtNasc, cargo, telefone, email, senha, fkEmpresa) VALUES ('${nome}', '${sobrenome}', true, '${cpf}', '${dtNasc}', '${cargo}', '${telefoneFunc}', '${email}', sha2('${senha}',256), '${cnpj}');`;

    console.log("Executando a instrução SQL: \n" + instrucao + instrucao2);
    database.executar(instrucao);
    return database.executar(instrucao2);
}

function cadastrarFuncionario(nomeFunc, sobrenomeFunc, permissaoFunc, cpfFunc, dtNascFunc, cargoFunc, telefoneFunc, emailFunc, senhaFunc, empresaFunc, responsavelFunc) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nomeFunc, sobrenomeFunc, permissaoFunc, cpfFunc, dtNascFunc, cargoFunc, telefoneFunc, emailFunc, senhaFunc, empresaFunc, responsavelFunc);
    var instrucao = `INSERT INTO Funcionario (nome, sobrenome, adm, cpf, dtNasc, cargo, telefone, email, senha, fkEmpresa, fkChefe) VALUES ('${nomeFunc}', '${sobrenomeFunc}', '${permissaoFunc}', '${cpfFunc}', '${dtNascFunc}','${cargoFunc}', '${telefoneFunc}', '${emailFunc}', sha2('${senhaFunc}',256), '${empresaFunc}', '${responsavelFunc}');`;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function cadastrarCaminhao(placa, empresa){
    var instrucao = `INSERT INTO Caminhao (placa, fkEmpresa) VALUES ('${placa}', '${empresa}');`;
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", placa, empresa);
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function cadastrarCarga(carga, caminhao){
    var instrucao = `INSERT INTO Carga (produto, dt, fkCaminhao) VALUES ('${carga}', default, '${caminhao}');`;
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", carga, caminhao);
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}


module.exports = {
    entrar,
    cadastrar,
    listar,
    cadastrarFuncionario,
    cadastrarCaminhao,
    cadastrarCarga
};