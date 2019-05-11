import 'package:archimedes/dao/CaracteristicaDAO.dart';
import 'package:archimedes/dao/ObjetivoDAO.dart';
import 'package:archimedes/model/Caracteristica.dart';
import 'package:archimedes/model/Objetivo.dart';
import 'package:flutter/material.dart';

class ObjetivoCaracteriscaPage extends StatefulWidget {
  final int projetoId;
  const ObjetivoCaracteriscaPage({Key key, this.projetoId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ObjetivoCaracteriscaState();
}

class _ObjetivoCaracteriscaState extends State<ObjetivoCaracteriscaPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _controller;
  VoidCallback onChanged;

  ObjetivoDAO objetivoDAO = ObjetivoDAO();
  CaracteristicaDAO caracteristicaDAO = CaracteristicaDAO();

  TextEditingController editingControllerObjetivo;
  TextEditingController editingControllerCaracteristica;

  void _salvarObjetivo() async {
    await objetivoDAO.create(Objetivo(
        projetoId: widget.projetoId, objetivo: editingControllerObjetivo.text));
    editingControllerObjetivo.text = '';
  }

  void _updateObjetivo(Objetivo newObjetivo) async {
    await objetivoDAO.update(newObjetivo);
    editingControllerObjetivo.text = '';
  }

  void _showDialogObjetivo([int objetivoId, String text]) {
    editingControllerObjetivo.text = text;
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('Qual é o objetivo do produto?'),
            content: TextField(
              autofocus: true,
              controller: editingControllerObjetivo,
              onEditingComplete: () {
                if (objetivoId == null) {
                  _salvarObjetivo();
                } else {
                  _updateObjetivo(Objetivo(
                      objetivoId: objetivoId,
                      projetoId: widget.projetoId,
                      objetivo: editingControllerObjetivo.text));
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
                  if (objetivoId == null) {
                    _salvarObjetivo();
                  } else {
                    _updateObjetivo(Objetivo(
                        objetivoId: objetivoId,
                        projetoId: widget.projetoId,
                        objetivo: editingControllerObjetivo.text));
                  }
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void _salvarCaracteristica() async {
    await caracteristicaDAO.create(Caracteristica(
        projetoId: widget.projetoId,
        caracteristica: editingControllerCaracteristica.text));
    editingControllerCaracteristica.text = '';
  }

  void _updateCaracteristica(Caracteristica newCaracteristica) async {
    await caracteristicaDAO.update(newCaracteristica);
    editingControllerCaracteristica.text = '';
  }

  void _showDialogCaracteristica([int caracteristicaId, String text]) {
    editingControllerCaracteristica.text = text;
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('Qual é a Caracteristica do produto?'),
            content: TextField(
              autofocus: true,
              controller: editingControllerCaracteristica,
              onEditingComplete: () {
                if (caracteristicaId == null) {
                  _salvarCaracteristica();
                } else {
                  _updateCaracteristica(Caracteristica(
                      caracteristicaId: caracteristicaId,
                      projetoId: widget.projetoId,
                      caracteristica: editingControllerCaracteristica.text));
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
                  if (caracteristicaId == null) {
                    _salvarCaracteristica();
                  } else {
                    _updateCaracteristica(Caracteristica(
                        caracteristicaId: caracteristicaId,
                        projetoId: widget.projetoId,
                        caracteristica: editingControllerCaracteristica.text));
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

    _controller = new TabController(initialIndex: 0, length: 2, vsync: this);
    onChanged = () {
      setState(() {
        _currentIndex = this._controller.index;
        print(_controller.index);
      });
    };
    _controller.addListener(onChanged);

    editingControllerObjetivo = TextEditingController();
    editingControllerCaracteristica = TextEditingController();
  }

  @override
  void dispose() {
    _controller.removeListener(onChanged);
    _controller.dispose();
    editingControllerObjetivo.dispose();
    editingControllerCaracteristica.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Objetivos e Características'),
        bottom: TabBar(
          controller: _controller,
          tabs: <Widget>[Tab(text: 'Objetivos'), Tab(text: 'Características')],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          // Objetivos List
          FutureBuilder<List<Objetivo>>(
              future: objetivoDAO.readAll(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Objetivo>> snapshot) {
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
                            await objetivoDAO.delete(item.objetivoId);
                          },
                          child: ListTile(
                            title: Text(item.objetivo),
                            onTap: () {
                              _showDialogObjetivo(
                                  item.objetivoId, item.objetivo);
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
          // Características List
          FutureBuilder<List<Caracteristica>>(
              future: caracteristicaDAO.readAll(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Caracteristica>> snapshot) {
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
                            await caracteristicaDAO
                                .delete(item.caracteristicaId);
                          },
                          child: ListTile(
                            title: Text(item.caracteristica),
                            onTap: () {
                              _showDialogCaracteristica(
                                  item.caracteristicaId, item.caracteristica);
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
                //Objetivo
                _showDialogObjetivo();
                break;
              }
            case 1:
              {
                //Característica
                _showDialogCaracteristica();
                break;
              }
          }
        },
      ),
    );
  }
}
