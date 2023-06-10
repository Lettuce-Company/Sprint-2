var express = require("express");
var router = express.Router();

var funcionarioController = require("../controllers/funcionarioController");

router.post("/atualizarDadosFuncionario", function (req, res) {
    funcionarioController.atualizarDadosFuncionario(req, res);
});

module.exports = router;