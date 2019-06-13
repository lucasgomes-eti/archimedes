import 'package:archimedes/dao/FuncionalidadeDAO.dart';
import 'package:archimedes/model/Funcionalidade.dart';
import 'package:flutter/material.dart';

class NovaFuncionalidadePage extends StatefulWidget {
  int projetoId;
  Funcionalidade funcionalidade;
  bool editing;

  NovaFuncionalidadePage(
      {Key key, this.projetoId, this.funcionalidade, this.editing})
      : super(key: key);

  @override
  createState() => _NovaFuncionalidadeState();
}

class _NovaFuncionalidadeState extends State<NovaFuncionalidadePage> {
  final dao = FuncionalidadeDAO();

  FocusNode focusNodeDescricao;
  TextEditingController editingControllerDescricao;
  TextEditingController editingControllerTempo;

  @override
  void initState() {
    super.initState();

    editingControllerDescricao = TextEditingController();
    editingControllerTempo = TextEditingController();

    editingControllerDescricao.text =
        widget.editing ? widget.funcionalidade.descricao : null;

    _entendimentoNegocioGroupValue = widget.editing
        ? nivelToValue(widget.funcionalidade.entendimentoNegocio)
        : 0;

    _certezaTecnicaGroupValue =
        widget.editing ? nivelToValue(widget.funcionalidade.certezaTecnica) : 0;

    _esforcoDevGroupValue = widget.editing
        ? nivelToValue(widget.funcionalidade.esforcoDesenvolvimento)
        : 0;

    _valorNegocioGroupValue =
        widget.editing ? nivelToValue(widget.funcionalidade.valorNegocio) : 0;

    editingControllerTempo.text =
        widget.editing ? widget.funcionalidade.tempoDesenvolvimento : null;
  }

  @override
  void dispose() {
    editingControllerDescricao.dispose();
    editingControllerTempo.dispose();

    super.dispose();
  }

  int _entendimentoNegocioGroupValue = 0;

  void _handleEntendimentoNegocioValueChanged(int value) {
    setState(() {
      _entendimentoNegocioGroupValue = value;
    });
  }

  int _certezaTecnicaGroupValue = 0;

  void _handleCertezaTecnicaValueChanged(int value) {
    setState(() {
      _certezaTecnicaGroupValue = value;
    });
  }

  int _esforcoDevGroupValue = 0;

  void _handleEsforcoDevValueChanged(int value) {
    setState(() {
      _esforcoDevGroupValue = value;
    });
  }

  int _valorNegocioGroupValue = 0;

  void _handleValorNegocioValueChanged(int value) {
    setState(() {
      _valorNegocioGroupValue = value;
    });
  }

  void _salvarFuncionalidade() async {
    var data = Funcionalidade(
        funcionalidadeId:
            widget.editing ? widget.funcionalidade.funcionalidadeId : null,
        projetoId: widget.projetoId,
        descricao: editingControllerDescricao.text,
        entendimentoNegocio: valueToNivel(_entendimentoNegocioGroupValue),
        certezaTecnica: valueToNivel(_certezaTecnicaGroupValue),
        esforcoDesenvolvimento: valueToNivel(_esforcoDevGroupValue),
        valorNegocio: valueToNivel(_valorNegocioGroupValue),
        tempoDesenvolvimento: editingControllerTempo.text);

    int rowsAffected =
        widget.editing ? await dao.update(data) : await dao.create(data);

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
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.funcionalidade == null
              ? 'Nova Funcionalidade'
              : widget.funcionalidade.descricao),
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
                _salvarFuncionalidade();
              },
              tooltip: 'Salvar',
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    labelText: 'Descrição',
                    hintText: 'Criar tabela de usuários',
                    helperText: 'Um breve resumo da funcionalidade',
                    border: OutlineInputBorder()),
                controller: editingControllerDescricao,
              ),
              SizedBox(height: 16),
              Text('Entendimento do negócio'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Radio(
                    value: 0,
                    groupValue: _entendimentoNegocioGroupValue,
                    onChanged: (int value) {
                      _handleEntendimentoNegocioValueChanged(value);
                    },
                  ),
                  Text('Baixo'),
                  Radio(
                    value: 1,
                    groupValue: _entendimentoNegocioGroupValue,
                    onChanged: (int value) {
                      _handleEntendimentoNegocioValueChanged(value);
                    },
                  ),
                  Text('Médio'),
                  Radio(
                    value: 2,
                    groupValue: _entendimentoNegocioGroupValue,
                    onChanged: (int value) {
                      _handleEntendimentoNegocioValueChanged(value);
                    },
                  ),
                  Text('Alto'),
                ],
              ),
              SizedBox(height: 16),
              Text('Certeza técnica'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Radio(
                    value: 0,
                    groupValue: _certezaTecnicaGroupValue,
                    onChanged: (int value) {
                      _handleCertezaTecnicaValueChanged(value);
                    },
                  ),
                  Text('Baixo'),
                  Radio(
                    value: 1,
                    groupValue: _certezaTecnicaGroupValue,
                    onChanged: (int value) {
                      _handleCertezaTecnicaValueChanged(value);
                    },
                  ),
                  Text('Médio'),
                  Radio(
                    value: 2,
                    groupValue: _certezaTecnicaGroupValue,
                    onChanged: (int value) {
                      _handleCertezaTecnicaValueChanged(value);
                    },
                  ),
                  Text('Alto'),
                ],
              ),
              SizedBox(height: 16),
              Text('Esforço de desenvolvimento'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Radio(
                    value: 0,
                    groupValue: _esforcoDevGroupValue,
                    onChanged: (int value) {
                      _handleEsforcoDevValueChanged(value);
                    },
                  ),
                  Text('Baixo'),
                  Radio(
                    value: 1,
                    groupValue: _esforcoDevGroupValue,
                    onChanged: (int value) {
                      _handleEsforcoDevValueChanged(value);
                    },
                  ),
                  Text('Médio'),
                  Radio(
                    value: 2,
                    groupValue: _esforcoDevGroupValue,
                    onChanged: (int value) {
                      _handleEsforcoDevValueChanged(value);
                    },
                  ),
                  Text('Alto'),
                ],
              ),
              SizedBox(height: 16),
              Text('Valor de negócio'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Radio(
                    value: 0,
                    groupValue: _valorNegocioGroupValue,
                    onChanged: (int value) {
                      _handleValorNegocioValueChanged(value);
                    },
                  ),
                  Text('Alto'),
                  Radio(
                    value: 1,
                    groupValue: _valorNegocioGroupValue,
                    onChanged: (int value) {
                      _handleValorNegocioValueChanged(value);
                    },
                  ),
                  Text('Muito Alto'),
                  Radio(
                    value: 2,
                    groupValue: _valorNegocioGroupValue,
                    onChanged: (int value) {
                      _handleValorNegocioValueChanged(value);
                    },
                  ),
                  Text('Altíssimo'),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    labelText: 'Tempo de desenvolvimento',
                    hintText: '8h',
                    helperText: 'h = horas, d = dias',
                    border: OutlineInputBorder()),
                controller: editingControllerTempo,
              )
            ],
          ),
        )));
  }
}
