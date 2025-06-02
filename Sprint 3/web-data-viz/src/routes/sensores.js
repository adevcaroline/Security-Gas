var express = require("express");
var router = express.Router();

var sensoresController = require("../controllers/sensoresController");

router.get("/sensoresGrafico/:id", function (req, res) {
	sensoresController.sensoresGrafico(req, res);
});


router.get("/listarSensores/:id", function (req, res) {
    sensoresController.listarSensores(req, res);
});

// router.post("/cadastrar", function (req, res) {
//   aquarioController.cadastrar(req, res);
// })

router.post("/sensor/adicionar", function (req, res) {
    sensoresController.adicionarSensor(req, res);
});

router.delete("/sensor/excluir/:idSensor", function (req, res) {
    sensoresController.excluirSensor(req, res);
});

module.exports = router;
