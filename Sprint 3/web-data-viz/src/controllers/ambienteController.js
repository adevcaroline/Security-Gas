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

module.exports = {
  cadastrarAmbiente
};
