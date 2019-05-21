import 'package:archimedes/dao/TipoPersona/ComportamentoDAO.dart';
import 'package:archimedes/dao/TipoPersona/NecessidadeDAO.dart';
import 'package:archimedes/dao/TipoPersona/PerfilDAO.dart';
import 'package:archimedes/model/persona/tipo_pernosa/Comportamento.dart';
import 'package:archimedes/model/persona/tipo_pernosa/Necessidade.dart';
import 'package:archimedes/model/persona/tipo_pernosa/Perfil.dart';
import 'package:flutter/material.dart';

class TipoPersonaPage extends StatefulWidget {
  final int personaId;
  const TipoPersonaPage({Key key, this.personaId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TipoPersonaState();
}

class _TipoPersonaState extends State<TipoPersonaPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _controller;
  VoidCallback onChanged;

  ComportamentoDAO comportamentoDAO = ComportamentoDAO();
  PerfilDAO perfilDAO = PerfilDAO();
  NecessidadeDAO necessidadeDAO = NecessidadeDAO();

  TextEditingController editingControllerComportamento;
  TextEditingController editingControllerPerfil;
  TextEditingController editingControllerNecessidade;

  void _salvarComportamento() async {
    await comportamentoDAO.create(Comportamento(
        personaId: widget.personaId,
        comportamento: editingControllerComportamento.text));
    editingControllerComportamento.text = '';
  }

  void _updateComportamento(Comportamento newComportamento) async {
    await comportamentoDAO.update(newComportamento);
    editingControllerComportamento.text = '';
  }

  void _showDialogComportamento([int comportamentoId, String text]) {
    editingControllerComportamento.text = text;
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('Qual é o comportamento da persona?'),
            content: TextField(
              autofocus: true,
              controller: editingControllerComportamento,
              onEditingComplete: () {
                if (comportamentoId == null) {
                  _salvarComportamento();
                } else {
                  _updateComportamento(Comportamento(
                      comportamentoId: comportamentoId,
                      personaId: widget.personaId,
                      comportamento: editingControllerComportamento.text));
                }
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('Adicionar'),
                onPressed: () {
                  if (comportamentoId == null) {
                    _salvarComportamento();
                  } else {
                    _updateComportamento(Comportamento(
                        comportamentoId: comportamentoId,
                        personaId: widget.personaId,
                        comportamento: editingControllerComportamento.text));
                  }
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void _salvarPerfil() async {
    await perfilDAO.create(Perfil(
        personaId: widget.personaId, perfil: editingControllerPerfil.text));
    editingControllerPerfil.text = '';
  }

  void _updatePerfil(Perfil newPerfil) async {
    await perfilDAO.update(newPerfil);
    editingControllerPerfil.text = '';
  }

  void _showDialogPerfil([int perfilId, String text]) {
    editingControllerPerfil.text = text;
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('Qual é o Perfil da persona?'),
            content: TextField(
              autofocus: true,
              controller: editingControllerPerfil,
              onEditingComplete: () {
                if (perfilId == null) {
                  _salvarPerfil();
                } else {
                  _updatePerfil(Perfil(
                      perfilId: perfilId,
                      personaId: widget.personaId,
                      perfil: editingControllerPerfil.text));
                }
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('Adicionar'),
                onPressed: () {
                  if (perfilId == null) {
                    _salvarPerfil();
                  } else {
                    _updatePerfil(Perfil(
                        perfilId: perfilId,
                        personaId: widget.personaId,
                        perfil: editingControllerPerfil.text));
                  }
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void _salvarNecessidade() async {
    await necessidadeDAO.create(Necessidade(
        personaId: widget.personaId,
        necessidade: editingControllerNecessidade.text));
    editingControllerNecessidade.text = '';
  }

  void _updateNecessidade(Necessidade newNecessidade) async {
    await necessidadeDAO.update(newNecessidade);
    editingControllerNecessidade.text = '';
  }

  void _showDialogNecessidade([int necessidadeId, String text]) {
    editingControllerNecessidade.text = text;
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('Qual é a Necessidade da persona?'),
            content: TextField(
              autofocus: true,
              controller: editingControllerNecessidade,
              onEditingComplete: () {
                if (necessidadeId == null) {
                  _salvarNecessidade();
                } else {
                  _updateNecessidade(Necessidade(
                      necessidadeId: necessidadeId,
                      personaId: widget.personaId,
                      necessidade: editingControllerNecessidade.text));
                }
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('Adicionar'),
                onPressed: () {
                  if (necessidadeId == null) {
                    _salvarNecessidade();
                  } else {
                    _updateNecessidade(Necessidade(
                        necessidadeId: necessidadeId,
                        personaId: widget.personaId,
                        necessidade: editingControllerNecessidade.text));
                  }
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();

    _controller = new TabController(initialIndex: 0, length: 3, vsync: this);
    onChanged = () {
      setState(() {
        _currentIndex = this._controller.index;
        print(_controller.index);
      });
    };
    _controller.addListener(onChanged);

    editingControllerComportamento = TextEditingController();
    editingControllerPerfil = TextEditingController();
    editingControllerNecessidade = TextEditingController();
  }

  @override
  void dispose() {
    _controller.removeListener(onChanged);
    _controller.dispose();
    editingControllerComportamento.dispose();
    editingControllerPerfil.dispose();
    editingControllerNecessidade.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tipo de Persona'),
        bottom: TabBar(
          controller: _controller,
          tabs: <Widget>[
            Tab(text: 'Comportamentos'),
            Tab(text: 'Perfil'),
            Tab(text: 'Necessidades')
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          // Comportamento List
          FutureBuilder<List<Comportamento>>(
              future: comportamentoDAO.readAll(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Comportamento>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = snapshot.data[index];
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(color: Colors.red),
                          onDismissed: (direction) async {
                            await comportamentoDAO.delete(item.comportamentoId);
                          },
                          child: ListTile(
                            title: Text(item.comportamento),
                            onTap: () {
                              _showDialogComportamento(
                                  item.comportamentoId, item.comportamento);
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Lista vazia =/',
                        style: Theme.of(context).textTheme.display1,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          // Perfil List
          FutureBuilder<List<Perfil>>(
              future: perfilDAO.readAll(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Perfil>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = snapshot.data[index];
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(color: Colors.red),
                          onDismissed: (direction) async {
                            await perfilDAO.delete(item.perfilId);
                          },
                          child: ListTile(
                            title: Text(item.perfil),
                            onTap: () {
                              _showDialogPerfil(item.perfilId, item.perfil);
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Lista vazia =/',
                        style: Theme.of(context).textTheme.display1,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          // Necessidades List
          FutureBuilder<List<Necessidade>>(
              future: necessidadeDAO.readAll(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Necessidade>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = snapshot.data[index];
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(color: Colors.red),
                          onDismissed: (direction) async {
                            await necessidadeDAO.delete(item.necessidadeId);
                          },
                          child: ListTile(
                            title: Text(item.necessidade),
                            onTap: () {
                              _showDialogNecessidade(
                                  item.necessidadeId, item.necessidade);
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Lista vazia =/',
                        style: Theme.of(context).textTheme.display1,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar Items',
        child: Icon(Icons.add),
        onPressed: () {
          switch (_currentIndex) {
            case 0:
              {
                //Comportamentos
                _showDialogComportamento();
                break;
              }
            case 1:
              {
                //Perfil
                _showDialogPerfil();
                break;
              }
            case 2:
              {
                //Necessidades
                _showDialogNecessidade();
              }
          }
        },
      ),
    );
  }
}
