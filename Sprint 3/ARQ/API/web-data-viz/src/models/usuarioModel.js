var database = require("../database/config")

function autenticar(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function autenticar(): ", email, senha)
    var instrucaoSql = `
        SELECT idUsuario, nome, email as empresaId FROM usuario WHERE email = '${email}' AND senha = '${senha}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function cadastrar(nome, email, senha, fkRestaurante) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, email, senha, fkRestaurante);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO usuario (nome, email, senha, fkRestaurante) VALUES ('${nome}', '${email}','${senha}','${fkRestaurante}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function validar(email) {
    var instrucaoSql = `
        SELECT COUNT(email) FROM usuario WHERE email = '${email}';
    `;
    return database.executar(instrucaoSql);
}

function validarCodigo(codigo_ativacao) {
    var instrucaoSql = `
    SELECT codigo_ativacao FROM restaurante WHERE codigo_ativacao = '${codigo_ativacao}'
    `;
    return database.executar(instrucaoSql)

}

module.exports = {
    autenticar,
    cadastrar,
    validar
};