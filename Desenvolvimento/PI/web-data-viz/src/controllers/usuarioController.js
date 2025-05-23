var usuarioModel = require("../models/usuarioModel");
// var aquarioModel = require("../models/aquarioModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.autenticar(email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                    if (resultadoAutenticar.length == 1) {
                        console.log(resultadoAutenticar);

                        res.json({
                            idUsuario: resultadoAutenticar[0].idUsuario,
                            nome: resultadoAutenticar[0].nome,
                            email: resultadoAutenticar[0].email,
                        });

                        //     aquarioModel.buscarAquariosPorEmpresa(resultadoAutenticar[0].empresaId)
                        //         .then((resultadoAquarios) => {
                        //             if (resultadoAquarios.length > 0) {
                        //                 res.json({
                        //                     id: resultadoAutenticar[0].id,
                        //                     email: resultadoAutenticar[0].email,
                        //                     nome: resultadoAutenticar[0].nome,
                        //                     senha: resultadoAutenticar[0].senha,
                        //                     cpf: resultadoAutenticar[0].cpf,
                        //                     aquarios: resultadoAquarios
                        //                 });
                        //             } else {
                        //                 res.status(204).json({ aquarios: [] });
                        //             }
                        //         })
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function cadastrar(req, res) {

    console.log("req.body recebido:", req.body);
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var nome = req.body.nomeServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;
    var fkRestaurante = req.body.idRestauranteVincularServer;

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else if (fkRestaurante == undefined) {
        res.status(400).send("Sua unidade a vincular está undefined!");
    } else {
        usuarioModel.validar(email)
            .then(
                function (resultado) {
                    var usuarioExiste = resultado[0]['COUNT(email)']

                    if (usuarioExiste > 0) {
                        res.status(403).send("Já existe um usuário com esse email!");
                    } else {
                        usuarioModel.cadastrar(nome, email, senha, fkRestaurante)
                            .then(
                                function (resultado) {
                                    res.json(resultado);
                                }
                            ).catch(
                                function (erro) {
                                    console.log(erro);
                                    console.log(
                                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                                        erro.sqlMessage
                                    );
                                    res.status(500).json(erro.sqlMessage);
                                }
                            );
                    }
                }
            )
        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js

    }
}

module.exports = {
    autenticar,
    cadastrar
}