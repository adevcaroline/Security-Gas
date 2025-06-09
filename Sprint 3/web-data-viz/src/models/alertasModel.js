var database = require("../database/config")

// function listarUltimasLeiturasTodosSensores() {
function listarAlertasSensores() {
    
    const instrucao = `
        SELECT 
            s.idSensor,
            s.nome_sensor,
            l.nome_local,
            ls.porcentagem_captada
        FROM sensor s
        JOIN local_instalacao l ON s.fkLocal_instalacao = l.idLocal_instalacao
        JOIN leitura_sensor ls ON s.idSensor = ls.fkSensor
        WHERE ls.idLeitura IN (
            SELECT MAX(idLeitura)
            FROM leitura_sensor
            GROUP BY fkSensor
        );
    `;
    return database.executar(instrucao);
}

module.exports = {
    listarAlertasSensores 
};