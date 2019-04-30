import 'package:archimedes/dao/VisaoProdutoDAO.dart';
import 'package:archimedes/model/VisaoProduto.dart';
import 'package:flutter/material.dart';

class VisaoProdutoPage extends StatefulWidget {
  int projetoId;

  VisaoProdutoPage({Key key, this.projetoId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VisaoProdutoPageState();
}

class _VisaoProdutoPageState extends State<VisaoProdutoPage> {
  VisaoProdutoDAO dao = VisaoProdutoDAO();

  int visaoProdutoId;
  bool loaded = false;

  FocusNode focusNodeProblema;
  FocusNode focusNodeNome;
  FocusNode focusNodeCategoria;
  FocusNode focusNodeBeneficio;
  FocusNode focusNodeConcorrencia;
  FocusNode focusNodeDiferenca;

  TextEditingController editingControllerCliente;
  TextEditingController editingControllerProblema;
  TextEditingController editingControllerNome;
  TextEditingController editingControllerCategoria;
  TextEditingController editingControllerBeneficio;
  TextEditingController editingControllerConcorrencia;
  TextEditingController editingControllerDiferenca;

  @override
  void initState() {
    super.initState();

    focusNodeProblema = FocusNode();
    focusNodeNome = FocusNode();
    focusNodeCategoria = FocusNode();
    focusNodeBeneficio = FocusNode();
    focusNodeConcorrencia = FocusNode();
    focusNodeDiferenca = FocusNode();

    editingControllerCliente = TextEditingController();
    editingControllerProblema = TextEditingController();
    editingControllerNome = TextEditingController();
    editingControllerCategoria = TextEditingController();
    editingControllerBeneficio = TextEditingController();
    editingControllerConcorrencia = TextEditingController();
    editingControllerDiferenca = TextEditingController();
  }

  @override
  void dispose() {
    focusNodeProblema.dispose();
    focusNodeNome.dispose();
    focusNodeCategoria.dispose();
    focusNodeBeneficio.dispose();
    focusNodeConcorrencia.dispose();
    focusNodeDiferenca.dispose();

    editingControllerCliente.dispose();
    editingControllerProblema.dispose();
    editingControllerNome.dispose();
    editingControllerCategoria.dispose();
    editingControllerBeneficio.dispose();
    editingControllerConcorrencia.dispose();
    editingControllerDiferenca.dispose();

    super.dispose();
  }

  void _focusProblema() {
    setState(() {
      FocusScope.of(context).requestFocus(focusNodeProblema);
    });
  }

  void _focusNome() {
    setState(() {
      FocusScope.of(context).requestFocus(focusNodeNome);
    });
  }

  void _focusCategoria() {
    setState(() {
      FocusScope.of(context).requestFocus(focusNodeCategoria);
    });
  }

  void _focusBeneficio() {
    setState(() {
      FocusScope.of(context).requestFocus(focusNodeBeneficio);
    });
  }

  void _focusConcorrencia() {
    setState(() {
      FocusScope.of(context).requestFocus(focusNodeConcorrencia);
    });
  }

  void _focusDiferenca() {
    setState(() {
      FocusScope.of(context).requestFocus(focusNodeDiferenca);
    });
  }

  void _load() async {
    await dao.read(widget.projetoId).then((VisaoProduto result) {
      visaoProdutoId = result.visaoProdutoId;
      editingControllerCliente.text = result.cliente;
      editingControllerProblema.text = result.problema;
      editingControllerNome.text = result.nome;
      editingControllerCategoria.text = result.categoria;
      editingControllerBeneficio.text = result.beneficio;
      editingControllerConcorrencia.text = result.concorrencia;
      editingControllerDiferenca.text = result.diferenca;
      loaded = true;
    });
  }

  void _salvar() async {
    int rowsAffected = visaoProdutoId == null
        ? await dao.create(VisaoProduto(
            projetoId: widget.projetoId,
            cliente: editingControllerCliente.text,
            problema: editingControllerProblema.text,
            nome: editingControllerNome.text,
            categoria: editingControllerCategoria.text,
            beneficio: editingControllerBeneficio.text,
            concorrencia: editingControllerConcorrencia.text,
            diferenca: editingControllerDiferenca.text))
        : await dao.update(VisaoProduto(
            visaoProdutoId: visaoProdutoId,
            projetoId: widget.projetoId,
            cliente: editingControllerCliente.text,
            problema: editingControllerProblema.text,
            nome: editingControllerNome.text,
            categoria: editingControllerCategoria.text,
            beneficio: editingControllerBeneficio.text,
            concorrencia: editingControllerConcorrencia.text,
            diferenca: editingControllerDiferenca.text));

    if (rowsAffected >= 1) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext buildContext) {
            return AlertDialog(
              title: Text('Salvo com successo'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return AlertDialog(
              title: Text('Erro ao salvar'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) _load();
    return Scaffold(
      appBar: AppBar(
        title: Text('Visão do produto'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Salvar',
            icon: Icon(Icons.save),
            onPressed: _salvar,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                  'A visão do produto ajuda a trilhar o caminho inicial. Ela define a essência do seu valor de negócio e deve refletir uma mensagem clara e convincente para seus clientes.',
                  style: Theme.of(context).textTheme.subhead),
              SizedBox(height: 24),
              TextField(
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Para',
                    hintText: 'Jogadores de poker',
                    helperText: 'Cliente final'),
                controller: editingControllerCliente,
                onEditingComplete: () {
                  _focusProblema();
                },
              ),
              SizedBox(height: 16),
              TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Cujo(a)',
                    hintText: 'Falta de amigos para jogar',
                    helperText: 'Problema que precisa ser resolvido'),
                controller: editingControllerProblema,
                focusNode: focusNodeProblema,
                onEditingComplete: () {
                  _focusNome();
                },
              ),
              SizedBox(height: 16),
              TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'O(a)',
                    hintText: 'Naipe',
                    helperText: 'Nome do produto'),
                controller: editingControllerNome,
                focusNode: focusNodeNome,
                onEditingComplete: () {
                  _focusCategoria();
                },
              ),
              SizedBox(height: 16),
              TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'É um(a)',
                    hintText: 'Rede Social',
                    helperText: 'Categoria do produto'),
                controller: editingControllerCategoria,
                focusNode: focusNodeCategoria,
                onEditingComplete: () {
                  _focusBeneficio();
                },
              ),
              SizedBox(height: 16),
              TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Que',
                    hintText: 'Cria campeonatos de poker',
                    helperText: 'Benefício-chave, razão para adquiri-lo(a)'),
                controller: editingControllerBeneficio,
                focusNode: focusNodeBeneficio,
                onEditingComplete: () {
                  _focusConcorrencia();
                },
              ),
              SizedBox(height: 16),
              TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Diferentemente da(o)',
                    hintText: 'Sete Copas',
                    helperText: 'Alternativa da concorrência'),
                controller: editingControllerConcorrencia,
                focusNode: focusNodeConcorrencia,
                onEditingComplete: () {
                  _focusDiferenca();
                },
              ),
              SizedBox(height: 16),
              TextField(
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'O nosso produto',
                    hintText: 'Tem sistema de apostas',
                    helperText: 'Diferença-chave'),
                controller: editingControllerDiferenca,
                focusNode: focusNodeDiferenca,
                onEditingComplete: _salvar,
              )
            ],
          ),
        ),
      ),
    );
  }
}
