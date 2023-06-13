var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:placa", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real-KPIS/:placa", function (req, res) {
    medidaController.buscarMedidasEmTempoRealKPIS(req, res);
})

router.get("/tempo-real-Graficos/:placa", function (req, res) {
    medidaController.buscarMedidasEmTempoRealGraficos(req, res);
})


router.get("/maximas-minimas/:placa", function (req, res) {
    medidaController.buscarMedidasMaximasMinimas(req, res);
})

router.get("/DadosRegistroAlerta/:cnpj_empresa", function (req, res) {
    medidaController.buscarDadosRegistroAlerta(req, res);
})

router.post("/RegistrarAlerta", function (req, res) {
    medidaController.RegistrarAlerta(req, res);
})

module.exports = router;