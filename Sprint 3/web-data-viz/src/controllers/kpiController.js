var kpiModel = require("../models/kpiModel");

function situacaoAtual(req, res) {
	const idRestaurante = req.params.idRestaurante;

	kpiModel
		.situacaoAtual(idRestaurante)
		.then((resultado) => {
			if (resultado.length > 0) {
				res.json({
					mensagem: `Alerta: ${resultado[0].ambiente} (${resultado[0].total_criticos} ocorrências críticas)`,
				});
			} else {
				res.json({
					mensagem: "Nenhuma ocorrência crítica registrada",
				});
			}
		})
		.catch((erro) => {
			res.status(500).json(erro.sqlMessage);
		});
}

function kpisStatus(req, res) {
	const idSensor = req.params.idSensor;

	kpiModel
		.kpisStatus(idSensor)
		.then((resultado) => {
             res.status(200).json(resultado);
			console.log(resultado);
		})
		.catch((erro) => {
			res.status(500).json(erro.sqlMessage);
		});
}

function kpisCritico24(req, res) {
	const idSensor = req.params.idSensor;

	kpiModel
		.kpisCritico24(idSensor)
		.then((resultado) => {
			res.status(200).json(resultado);
			console.log(resultado);
		})
		.catch((erro) => {
			res.status(500).json(erro.sqlMessage);
		});
}

function alertas30dias(req, res) {
	const idSensor = req.params.idSensor;

	kpiModel
		.alertas30dias(idSensor)
		.then((resultado) => {
			res.status(200).json(resultado);
			console.log(resultado);
		})
		.catch((erro) => {
			res.status(500).json(erro.sqlMessage);
		});
}

function ocorrenciasGravesMes(req, res) {
	const idRestaurante = req.params.idRestaurante;

	kpiModel
		.ocorrenciasGravesMes(idRestaurante)
		.then((resultado) => {
			res.json({
				total: resultado[0].total_criticos_mes || 0,
			});
		})
		.catch((erro) => {
			res.status(500).json(erro.sqlMessage);
		});
}

function areaMaisOcorrencias(req, res) {
	const idRestaurante = req.params.idRestaurante;

	kpiModel
		.areaMaisOcorrencias(idRestaurante)
		.then((resultado) => {
			if (resultado.length > 0) {
				res.json({
					sensor: `${resultado[0].sensor} (${resultado[0].ambiente}) - ${resultado[0].total_criticos} ocorrências`,
				});
			} else {
				res.json({
					sensor: "Nenhuma ocorrência crítica este mês",
				});
			}
		})
		.catch((erro) => {
			res.status(500).json(erro.sqlMessage);
		});
}

module.exports = {
	situacaoAtual,
	ocorrenciasGravesMes,
	areaMaisOcorrencias,
	kpisStatus,
	kpisCritico24,
	alertas30dias,
};
