var express = require("express");
var router = express.Router();

var alertaController = require("../controllers/alertaController");

router.get("/alertas", sensoresController.listarAlertasSensores);