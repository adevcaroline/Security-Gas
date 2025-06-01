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

module.exports = router;
