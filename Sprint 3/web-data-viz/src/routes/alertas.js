var express = require("express");
var router = express.Router();

var alertasController = require("../controllers/alertasController");

router.get("/sensores", function (req, res) {
    alertasController.listarAlertasSensores(req, res);
})

module.exports = router;