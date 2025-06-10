var database = require("../database/config");

// function autenticar(email, senha) {
//     console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function autenticar(): ", email, senha)
//     var instrucaoSql = `
//         SELECT idUsuario, nome, email as empresaId FROM usuario WHERE email = '${email}' AND senha = '${senha}';
//     `;
//     console.log("Executando a instrução SQL: \n" + instrucaoSql);
//     return database.executar(instrucaoSql);
// }

// // Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
// function cadastrar(nome, email, senha, fkRestaurante) {
//     console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, email, senha, fkRestaurante);

//     // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
//     //  e na ordem de inserção dos dados.
//     var instrucaoSql = `
//         INSERT INTO usuario (nome, email, senha, fkRestaurante) VALUES ('${nome}', '${email}','${senha}','${fkRestaurante}');
//     `;
//     console.log("Executando a instrução SQL: \n" + instrucaoSql);
//     return database.executar(instrucaoSql);
// }

// function validar(email) {
//     var instrucao = `
//         SELECT COUNT(email) FROM usuario WHERE email = '${email}';
//     `;
//     return database.executar(instrucao);
// }

function sensoresGrafico(idSensor) {
	var instrucao = `
SELECT 
    lei.idLeitura,
    lei.fkAlerta,
    lei.fkSensor,
    lei.porcentagem_captada,
    DATE_FORMAT(lei.data_hora, '%d/%m/%Y %h:%m:%s') as data_hora,
    sen.idSensor,
    sen.nome_sensor,
    sen.statusAtivacao,
    sen.fkLocal_instalacao,
    loc.idLocal_instalacao,
    loc.nome_local,
    loc.fkRestaurante
FROM leitura_sensor AS lei
INNER JOIN sensor AS sen
    ON lei.fkSensor = sen.idSensor
INNER JOIN local_instalacao AS loc
    ON sen.fkLocal_instalacao = loc.idLocal_instalacao
WHERE lei.fkSensor = ${idSensor} 
ORDER BY lei.idLeitura DESC 
LIMIT 10;

    `;
	return database.executar(instrucao);
}

function listarSensores(idAmbiente) {
	var instrucao = `

	    select * from sensor as s
	    join local_instalacao as l
	    on l.idLocal_instalacao = s.fkLocal_instalacao
	    where l.idLocal_instalacao = ${idAmbiente};

	`;

	// var instrucao = `

	//     select * from leitura_sensor as ls
	//     join sensor as s
	//     on s.idSensor = ls.fkSensor
	//     join local_instalacao as li
	//     on li.idLocal_instalacao = s.fkLocal_instalacao
	//     where li.idLocal_instalacao = ${idAmbiente};

	// `;
	return database.executar(instrucao);
}

function corSensor(idSensor) {
	var instrucao = `
		select fkAlerta as leitura from leitura_sensor
		where fkSensor = ${idSensor}
		order by idLeitura desc
		limit 1;                                    	
    `;

	console.log("Executando a instrução SQL: \n" + instrucao);
	return database.executar(instrucao);
}


//ADICIONAR SENSOR NOVO
function adicionarSensor(nome_sensor, fkLocal_instalacao) {
	var instrucao = `
        INSERT INTO sensor (nome_sensor, statusAtivacao, fkLocal_instalacao)
        VALUES ('${nome_sensor}', 1, ${fkLocal_instalacao});
    `;

	console.log("Executando a instrução SQL: \n" + instrucao);
	return database.executar(instrucao);
}

//EXLUIR SENSOR
function excluirSensor(idSensor) {
	var instrucao = `
        DELETE FROM sensor WHERE idSensor = ${idSensor};
    `;
	console.log("Executando a instrução SQL: \n" + instrucao);
	return database.executar(instrucao);
}

module.exports = {
	sensoresGrafico,
	listarSensores,
	adicionarSensor,
	excluirSensor,
	corSensor,
	// autenticar,
	// cadastrar,
	// validar
};
