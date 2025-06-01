const ambienteModel = require('../models/ambienteModel');

async function cadastrarAmbiente(req, res) {
  console.log("Dados recebidos:", req.body);  // <<< Adicione aqui

  const { nome_local, fkRestaurante } = req.body;

  if (!nome_local || !fkRestaurante) {
    return res.status(400).json({ erro: 'Dados incompletos!' });
  }

  try {
    await ambienteModel.inserirAmbiente(nome_local, fkRestaurante);
    res.status(201).json({ mensagem: 'Ambiente inserido com sucesso!' });
  } catch (erro) {
    console.error('Erro ao inserir ambiente:', erro);
    res.status(500).json({ erro: 'Erro interno no servidor.' });
  }
}

function excluirAmbiente(req, res) {
    var idLocal = req.params.idLocal;

    ambienteModel.excluirAmbiente(idLocal)
        .then(resultado => {
            res.status(200).json({ mensagem: "Ambiente excluído com sucesso!" });
        })
        .catch(erro => {
            console.error("Erro ao excluir ambiente:", erro);
            res.status(500).json({ erro: "Erro ao excluir ambiente." });
        });
}

function listar(req, res) {
    var fkRestaurante = req.params.fkRestaurante;

    ambienteModel.listar(fkRestaurante)
        .then(resultado => {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum ambiente encontrado.");
            }
        })
        .catch(erro => {
            console.error("Erro ao listar ambientes:", erro);
            res.status(500).json({ erro: "Erro ao listar ambientes." });
        });
}


module.exports = {
  cadastrarAmbiente,
  excluirAmbiente,
  listar
};
