var usuarioModel = require("../models/usuarioModel");

var sessoes = [];

function testar(req, res) {
    console.log("ENTRAMOS NA usuarioController");
    res.json("ESTAMOS FUNCIONANDO!");
}

function listar(req, res) {
    usuarioModel.listar()
        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado!")
            }
        }).catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao realizar a consulta! Erro: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function entrar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está indefinida!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.entrar(email, senha)
            .then(
                function (resultado) {
                    console.log(`\nResultados encontrados: ${resultado.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultado)}`); // transforma JSON em String

                    if (resultado.length == 1) {
                        console.log(resultado);
                        res.json(resultado[0]);
                    } else if (resultado.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html

    var nome = req.body.nomeServer;
    var sobrenome = req.body.sobrenomeServer;
    var cpf = req.body.cpfServer;
    var cargo = req.body.cargoServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;
    var nomeEmpr = req.body.nomeEmprServer;
    var cnpj = req.body.cnpjServer;
    var telefone = req.body.telefoneServer;

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("O nome está indefinido!");
    } else if (sobrenome == undefined) {
        res.status(400).send("O sobrenome está indefinido!");
    } else if (cpf == undefined) {
        res.status(400).send("O responsável está indefinido!");
    } else if (cargo == undefined) {
        res.status(400).send("O cargo está indefinido!");
    } else if (email == undefined) {
        res.status(400).send("O email está indefinido!");
    } else if (senha == undefined) {
        res.status(400).send("A senha está indefinida!");
    } else if (nomeEmpr == undefined) {
        res.status(400).send("O nome da empresa está indefinido!");
    } else if (cnpj == undefined) {
        res.status(400).send("O cnpj está indefinido!");
    } else if (telefone == undefined) {
        res.status(400).send("O telefone está indefinido!");
    }
    else {

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrar(nome, sobrenome, cpf, cargo, email, senha, nomeEmpr, cnpj, telefone)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

function cadastrarFunc(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html

    var nome = req.body.nomeServer;
    var sobrenome = req.body.sobrenomeServer;
    var cpf = req.body.cpfServer;
    var cargo = req.body.cargoServer;
    var telefone = req.body.telefoneServer;
    var email = req.body.emailServer;
    var dtNasc = req.body.dtNascServer
    var permissao = req.body.permissaoServer;
    var responsavel = req.body.responsavelServer;
    var senha = req.body.senhaServer;


    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("O nome está indefinido!");
    } else if (sobrenome == undefined) {
        res.status(400).send("O sobrenome está indefinido!");
    } else if (cpf == undefined) {
        res.status(400).send("O responsavel está indefinido!");
    } else if (cargo == undefined) {
        res.status(400).send("O cargo está indefinido!");
    } else if (telefone == undefined) {
        res.status(400).send("O telefone está indefinido!");
    }
    else if (email == undefined) {
        res.status(400).send("O email está indefinido!");
    }
    else if (dtNasc == undefined) {
        res.status(400).send("A data de nascimento está indefinida!");

    } else if (permissao == undefined) {
        res.status(400).send("A permissão está indefinida!");
    }
    else if (responsavel == undefined) {
        res.status(400).send("O responsável está indefinido!");
    }
    else if (senha == undefined) {
        res.status(400).send("A senha está indefinida!");
    }




    else {

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrarFunc(nome, sobrenome, cpf, cargo, telefone, email, dtNasc, permissao, responsavel, senha)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro do Funcionário! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

module.exports = {
    entrar,
    cadastrar,
    cadastrarFunc,
    listar,
    testar
    
}