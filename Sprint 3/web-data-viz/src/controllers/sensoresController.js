var sensoresModel = require("../models/sensoresModel");

function sensoresGrafico(req, res) {
	const idSensor = req.params.id;

	console.log(idSensor);

	sensoresModel
		.sensoresGrafico(idSensor)
		.then(function (resposta) {
			res.status(200).json(resposta);
		})
		.catch(function (erro) {
			console.log(erro);
			console.log(
				"\nHouve um erro ao realizar o login! Erro: ",
				erro.sqlMessage
			);
			res.status(500).json(erro.sqlMessage);
		});
}

// function cadastrar(req, res) {
// 	console.log("req.body recebido:", req.body);
// 	// Crie uma variável que vá recuperar os valores do arquivo cadastro.html
// 	var nome = req.body.nomeServer;
// 	var email = req.body.emailServer;
// 	var senha = req.body.senhaServer;
// 	var fkRestaurante = req.body.idRestauranteVincularServer;

// 	// Faça as validações dos valores
// 	if (nome == undefined) {
// 		res.status(400).send("Seu nome está undefined!");
// 	} else if (email == undefined) {
// 		res.status(400).send("Seu email está undefined!");
// 	} else if (senha == undefined) {
// 		res.status(400).send("Sua senha está undefined!");
// 	} else if (fkRestaurante == undefined) {
// 		res.status(400).send("Sua unidade a vincular está undefined!");
// 	} else {
// 		usuarioModel.validar(email).then(function (resultado) {
// 			var usuarioExiste = resultado[0]["COUNT(email)"];

// 			if (usuarioExiste > 0) {
// 				res.status(403).send("Já existe um usuário com esse email!");
// 			} else {
// 				usuarioModel
// 					.cadastrar(nome, email, senha, fkRestaurante)
// 					.then(function (resultado) {
// 						res.json(resultado);
// 					})
// 					.catch(function (erro) {
// 						console.log(erro);
// 						console.log(
// 							"\nHouve um erro ao realizar o cadastro! Erro: ",
// 							erro.sqlMessage
// 						);
// 						res.status(500).json(erro.sqlMessage);
// 					});
// 			}
// 		});
// 		// Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
// 	}
// }

module.exports = {
	sensoresGrafico,
};
