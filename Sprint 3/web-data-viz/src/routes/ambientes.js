const express = require('express');
const router = express.Router();
const ambienteController = require('../controllers/ambienteController');
router.post('/cadastrar', ambienteController.cadastrarAmbiente);

module.exports = router;