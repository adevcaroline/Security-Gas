var express = require("express");
var router = express.Router();
var kpiController = require("../controllers/kpiController");

router.get("/situacao-atual/:idRestaurante", kpiController.situacaoAtual);
router.get("/ocorrencias-mes/:idRestaurante", kpiController.ocorrenciasGravesMes);
router.get("/sensor-critico/:idRestaurante", kpiController.areaMaisOcorrencias);

module.exports = router;