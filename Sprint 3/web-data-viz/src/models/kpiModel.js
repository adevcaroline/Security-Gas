var database = require("../database/config");

// situação Atual
function situacaoAtual(idRestaurante) {
    var instrucao = `
        SELECT 
            li.nome_local AS ambiente,
            COUNT(*) AS total_criticos
        FROM leitura_sensor ls
        JOIN sensor s ON ls.fkSensor = s.idSensor
        JOIN local_instalacao li ON s.fkLocal_instalacao = li.idLocal_instalacao
        JOIN alerta a ON ls.fkAlerta = a.idAlerta
        WHERE a.nivel_alerta = 'Crítico'
        AND li.fkRestaurante = ${idRestaurante}
        GROUP BY li.nome_local
        ORDER BY total_criticos DESC
        LIMIT 1;
    `;
    return database.executar(instrucao);
}

// ocorrências graves no mês
function ocorrenciasGravesMes(idRestaurante) {
    var instrucao = `
        SELECT 
            COUNT(*) AS total_criticos_mes
        FROM leitura_sensor ls
        JOIN sensor s ON ls.fkSensor = s.idSensor
        JOIN local_instalacao li ON s.fkLocal_instalacao = li.idLocal_instalacao
        JOIN alerta a ON ls.fkAlerta = a.idAlerta
        WHERE a.nivel_alerta = 'Crítico'
        AND li.fkRestaurante = ${idRestaurante}
        AND MONTH(ls.data_hora) = MONTH(CURRENT_DATE())
        AND YEAR(ls.data_hora) = YEAR(CURRENT_DATE());
    `;
    return database.executar(instrucao);
}

// área com mais ocorrências no mês
function areaMaisOcorrencias(idRestaurante) {
    var instrucao = `
        SELECT 
            s.nome_sensor AS sensor,
            li.nome_local AS ambiente,
            COUNT(*) AS total_criticos
        FROM leitura_sensor ls
        JOIN sensor s ON ls.fkSensor = s.idSensor
        JOIN local_instalacao li ON s.fkLocal_instalacao = li.idLocal_instalacao
        JOIN alerta a ON ls.fkAlerta = a.idAlerta
        WHERE a.nivel_alerta = 'Crítico'
        AND li.fkRestaurante = ${idRestaurante}
        AND MONTH(ls.data_hora) = MONTH(CURRENT_DATE())
        AND YEAR(ls.data_hora) = YEAR(CURRENT_DATE())
        GROUP BY s.nome_sensor, li.nome_local
        ORDER BY total_criticos DESC
        LIMIT 1;
    `;
    return database.executar(instrucao);
}

module.exports = {
    situacaoAtual,
    ocorrenciasGravesMes,
    areaMaisOcorrencias,
};