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
        SELECT * FROM Funcionario WHERE email = '${email}' AND senha = '${senha}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

// Coloque os mesmos parâmetros aqui. Vá para a var instrucao
function cadastrar(nome, sobrenome, cpf, cargo, email, senha, nomeEmpr, cnpj, telefone) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, sobrenome, cpf, cargo, email, senha, nomeEmpr, cnpj, telefone);
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucao = `INSERT INTO Empresa (nomeEmpr, cnpj, telefone) VALUES ('${nomeEmpr}','${cnpj}', '${telefone}');`;
    var instrucao2= `INSERT INTO Funcionario (nome, sobrenome, adm, cpf, cargo, email, senha, fkEmpresa) VALUES ('${nome}', '${sobrenome}', true, '${cpf}', '${cargo}', '${email}', '${senha}', '${cnpj}');`; 

    console.log("Executando a instrução SQL: \n" + instrucao + instrucao2);
    database.executar(instrucao);
    return database.executar(instrucao2);
}

function funccadastro(nomeFunc, sobrenomeFunc, permissaoFunc, cpfFunc, dtNascFunc, cargoFunc, telefoneFunc, emailFunc, senhaFunc, empresaFunc, responsavelFunc) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nomeFunc, sobrenomeFunc, permissaoFunc, cpfFunc, dtNascFunc, cargoFunc, telefoneFunc, emailFunc, senhaFunc, empresaFunc, responsavelFunc);
       var instrucao = `INSERT INTO Funcionario (nome, sobrenome, adm, cpf, dtNasc, cargo, telefone, email, senha, fkEmpresa, fkChefe) VALUES ('${nomeFunc}', '${sobrenomeFunc}', '${permissaoFunc}', '${cpfFunc}', '${dtNascFunc}','${cargoFunc}', '${telefoneFunc}', '${emailFunc}', '${senhaFunc}', '${empresaFunc}', '${responsavelFunc}');`;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

module.exports = {
    entrar,
    cadastrar,
    listar,
    funccadastro
    
};