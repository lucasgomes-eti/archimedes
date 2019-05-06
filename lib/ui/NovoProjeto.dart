import 'package:archimedes/dao/ProjetoDAO.dart';
import 'package:archimedes/model/Projeto.dart';
import 'package:flutter/material.dart';

class NovoProjeto extends StatefulWidget {
  final String title;
  final bool editing;
  final int projetoId;
  String nomeProjeto;
  String descricaoProjeto;

  NovoProjeto(
      {Key key,
      this.title,
      this.editing,
      this.projetoId,
      this.nomeProjeto,
      this.descricaoProjeto})
      : super(key: key);

  @override
  _NovoProjetoState createState() => _NovoProjetoState();
}

class _NovoProjetoState extends State<NovoProjeto> {
  get dao => ProjetoDAO();

  FocusNode focusNodeDescricao;
  TextEditingController editingControllerNome;
  TextEditingController editingControllerDescricao;

  @override
  void initState() {
    super.initState();

    focusNodeDescricao = FocusNode();
    editingControllerNome = TextEditingController();
    editingControllerDescricao = TextEditingController();

    editingControllerNome.text = widget.editing ? widget.nomeProjeto : null;
    editingControllerDescricao.text =
        widget.editing ? widget.descricaoProjeto : null;
  }

  void _focusDescricao() {
    setState(() {
      FocusScope.of(context).requestFocus(focusNodeDescricao);
    });
  }

  void _salvarProjeto() async {
    int rowsAffected = widget.editing
        ? await dao.update(Projeto(
            projetoId: widget.projetoId,
            nome: editingControllerNome.text.isNotEmpty
                ? editingControllerNome.text
                : 'Projeto sem nome',
            descricao: editingControllerDescricao.text.isNotEmpty
                ? editingControllerDescricao.text
                : '-'))
        : await dao.create(Projeto(
            nome: editingControllerNome.text.isNotEmpty
                ? editingControllerNome.text
                : 'Projeto sem nome',
            descricao: editingControllerDescricao.text.isNotEmpty
                ? editingControllerDescricao.text
                : '-'));
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
  void dispose() {
    focusNodeDescricao.dispose();
    editingControllerNome.dispose();
    editingControllerDescricao.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
            tooltip: 'Fechar',
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _salvarProjeto();
              },
              tooltip: 'Salvar',
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    labelText: 'Nome do Projeto',
                    hintText: 'Arma X',
                    helperText: 'Pode ser o nome do produto',
                    border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
                autofocus: !widget.editing,
                onEditingComplete: () {
                  _focusDescricao();
                },
                onChanged: (String text) {
                  widget.nomeProjeto = text;
                },
                controller: editingControllerNome,
              ),
              SizedBox(height: 8),
              TextField(
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    labelText: 'Descrição',
                    hintText: 'Ser a arma perfeita',
                    helperText:
                        'Um breve resumo do principal objetivo do seu produto',
                    border: OutlineInputBorder()),
                onChanged: (String text) {
                  widget.descricaoProjeto = text;
                },
                onEditingComplete: () {
                  _salvarProjeto();
                },
                controller: editingControllerDescricao,
                focusNode: focusNodeDescricao,
              ),
            ],
          ),
        ));
  }
}