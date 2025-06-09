const alertasModel = require('../models/alertasModel');

function listarAlertasSensores(req, res) {
    alertasModel.listarAlertasSensores()
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