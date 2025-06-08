const alertaModel = require('../models/alertaModel');

function listarAlertasSensores(req, res) {
    sensoresModel.listarUltimasLeiturasTodosSensores()
        .then(resultado => {
            res.status(200).json(resultado);
        })
        .catch(erro => {
            console.error("Erro ao listar alertas dos sensores:", erro);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    listarAlertasSensores 
};