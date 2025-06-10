var express = require("express");
var router = express.Router();
var kpiController = require("../controllers/kpiController");

router.get("/situacao-atual/:idRestaurante", kpiController.situacaoAtual);

router.get("/ocorrencias-mes/:idRestaurante", kpiController.ocorrenciasGravesMes);

router.get("/sensor-critico/:idRestaurante", kpiController.areaMaisOcorrencias);

router.get("/kpisStatus/:idSensor", kpiController.kpisStatus);

router.get("/kpisCritico24/:idSensor", kpiController.kpisCritico24);

router.get("/alertas30dias/:idSensor", kpiController.alertas30dias);


module.exports = router;