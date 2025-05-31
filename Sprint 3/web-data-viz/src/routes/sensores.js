var express = require("express");
var router = express.Router();

var sensoresController = require("../controllers/sensoresController");

router.get("/sensoresGrafico/:id", function (req, res) {
	sensoresController.sensoresGrafico(req, res);
});

// router.post("/cadastrar", function (req, res) {
//   aquarioController.cadastrar(req, res);
// })

module.exports = router;
