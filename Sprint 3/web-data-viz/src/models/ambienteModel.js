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

module.exports = {
    inserirAmbiente
};
