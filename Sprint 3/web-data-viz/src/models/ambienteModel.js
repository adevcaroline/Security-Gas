var database = require("../database/config")

var database = require("../database/config")

function inserirAmbiente(nomeAmbiente, fkRestaurante) {
    var instrucaoSql = `
    INSERT INTO local_instalacao (nome_local, fkRestaurante)
    VALUES ('${nomeAmbiente}', ${fkRestaurante});
`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [nomeAmbiente, fkRestaurante]);
}

function excluirAmbiente(idLocal) {
    var instrucaoSql = `
        DELETE FROM local_instalacao WHERE idLocal_instalacao = ${idLocal};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// function listar(fkRestaurante) {
//     var instrucaoSql = `
//     SELECT idLocal_instalacao, nome_local
//     FROM local_instalacao
//     WHERE fkRestaurante = ${fkRestaurante};
// `;
//     console.log("Executando a instrução SQL: \n" + instrucaoSql);
//     return database.executar(instrucaoSql);
// }

function listar(fkRestaurante) {

    var instrucaoSql = `
    SELECT idLocal_instalacao, nome_local
    FROM local_instalacao
    WHERE fkRestaurante = ${fkRestaurante};
`;

   console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);

}

function carregarHistorico(idLocalInstalacao) {
    var instrucaoSql = `
     SELECT
        loc.nome_local AS nome_local,
        sen.nome_sensor AS nome_sensor,
        lei.data_hora AS data_hora,
        alerta.nivel_alerta AS nivel_alerta
        FROM leitura_sensor AS lei
        JOIN sensor AS sen ON lei.fkSensor = sen.idSensor
        JOIN local_instalacao AS loc ON sen.fkLocal_instalacao = loc.idLocal_instalacao
        JOIN alerta ON lei.fkAlerta = alerta.idAlerta
        WHERE alerta.nivel_alerta IN ('Crítico', 'Alerta')
        AND loc.idLocal_instalacao = ${idLocalInstalacao}
        ORDER BY lei.data_hora DESC;

`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    inserirAmbiente,
    excluirAmbiente,
    listar,
    carregarHistorico
};
