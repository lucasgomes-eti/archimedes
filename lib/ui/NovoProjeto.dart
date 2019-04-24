import 'package:archimedes/dao/ProjetoDAO.dart';
import 'package:archimedes/model/Projeto.dart';
import 'package:flutter/material.dart';

class NovoProjeto extends StatelessWidget {
  get dao => ProjetoDAO();

  var nomeProjeto = "";
  var descricaoProjeto = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Novo Projeto'),
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
              onPressed: () async {
                int rowsAffected = await dao.create(
                    Projeto(nome: nomeProjeto, descricao: descricaoProjeto));
                if (rowsAffected >= 1) {
                  showDialog(
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
                onChanged: (String text) {
                  nomeProjeto = text;
                },
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Descrição',
                    hintText: 'Ser a arma perfeita',
                    helperText:
                        'Um breve resumo do principal objetivo do seu produto',
                    border: OutlineInputBorder()),
                onChanged: (String text) {
                  descricaoProjeto = text;
                },
              ),
            ],
          ),
        ));
  }
}
