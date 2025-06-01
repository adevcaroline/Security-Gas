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

function listar(fkRestaurante) {
    var instrucaoSql = `
    SELECT idLocal_instalacao, nome_local
    FROM local_instalacao
    WHERE fkRestaurante = ${fkRestaurante};
`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    inserirAmbiente,
    excluirAmbiente,
    listar
};
