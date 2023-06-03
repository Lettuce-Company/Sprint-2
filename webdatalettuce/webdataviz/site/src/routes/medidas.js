var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:placa", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:placa", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

router.get("/maximas-minimas/:placa", function (req, res) {
    medidaController.buscarMedidasMaximasMinimas(req, res);
})

module.exports = router;