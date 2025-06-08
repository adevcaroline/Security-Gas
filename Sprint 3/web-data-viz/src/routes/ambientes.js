const express = require('express');
const router = express.Router();

const ambienteController = require('../controllers/ambienteController');
router.post('/cadastrar', ambienteController.cadastrarAmbiente);


router.delete("/excluir/:idLocal", function (req, res) {
    ambienteController.excluirAmbiente(req, res);
});

router.get("/listar/:fkRestaurante", function (req, res) {
    ambienteController.listar(req, res);
});

router.get("/historico/:idLocalInstalacao", function (req, res) {
    ambienteController.carregarHistorico(req, res);
});

module.exports = router;