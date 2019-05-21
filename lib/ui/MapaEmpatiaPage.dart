import 'package:archimedes/dao/MapaEmpatia/FaloDAO.dart';
import 'package:archimedes/dao/MapaEmpatia/OucoDAO.dart';
import 'package:archimedes/dao/MapaEmpatia/PensoDAO.dart';
import 'package:archimedes/dao/MapaEmpatia/VejoDAO.dart';
import 'package:archimedes/model/persona/mapa_empatia/Falo.dart';
import 'package:archimedes/model/persona/mapa_empatia/Ouco.dart';
import 'package:archimedes/model/persona/mapa_empatia/Penso.dart';
import 'package:archimedes/model/persona/mapa_empatia/Vejo.dart';
import 'package:flutter/material.dart';

class MapaEmpatiaPage extends StatefulWidget {
  final int personaId;
  const MapaEmpatiaPage({Key key, this.personaId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapaEmpatiaState();
}

class _MapaEmpatiaState extends State<MapaEmpatiaPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _controller;
  VoidCallback onChanged;

  PensoDAO pensoDAO = PensoDAO();
  OucoDAO oucoDAO = OucoDAO();
  FaloDAO faloDAO = FaloDAO();
  VejoDAO vejoDAO = VejoDAO();

  TextEditingController editingControllerPenso;
  TextEditingController editingControllerOuco;
  TextEditingController editingControllerFalo;
  TextEditingController editingControllerVejo;

  void _salvarVejo() async {
    await vejoDAO.create(
        Vejo(personaId: widget.personaId, vejo: editingControllerVejo.text));
    editingControllerVejo.text = '';
  }

  void _updateVejo(Vejo newVejo) async {
    await vejoDAO.update(newVejo);
    editingControllerVejo.text = '';
  }

  void _showDialogVejo([int vejoId, String text]) {
    editingControllerVejo.text = text;
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('O que a persona Vê?'),
            content: TextField(
              autofocus: true,
              controller: editingControllerVejo,
              onEditingComplete: () {
                if (vejoId == null) {
                  _salvarVejo();
                } else {
                  _updateVejo(Vejo(
                      vejoId: vejoId,
                      personaId: widget.personaId,
                      vejo: editingControllerVejo.text));
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
                  if (vejoId == null) {
                    _salvarVejo();
                  } else {
                    _updateVejo(Vejo(
                        vejoId: vejoId,
                        personaId: widget.personaId,
                        vejo: editingControllerVejo.text));
                  }
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void _salvarOuco() async {
    await oucoDAO.create(
        Ouco(personaId: widget.personaId, ouco: editingControllerOuco.text));
    editingControllerOuco.text = '';
  }

  void _updateOuco(Ouco newOuco) async {
    await oucoDAO.update(newOuco);
    editingControllerOuco.text = '';
  }

  void _showDialogOuco([int oucoId, String text]) {
    editingControllerOuco.text = text;
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('O que a persona Ouve?'),
            content: TextField(
              autofocus: true,
              controller: editingControllerOuco,
              onEditingComplete: () {
                if (oucoId == null) {
                  _salvarOuco();
                } else {
                  _updateOuco(Ouco(
                      oucoId: oucoId,
                      personaId: widget.personaId,
                      ouco: editingControllerVejo.text));
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
                  if (oucoId == null) {
                    _salvarOuco();
                  } else {
                    _updateOuco(Ouco(
                        oucoId: oucoId,
                        personaId: widget.personaId,
                        ouco: editingControllerOuco.text));
                  }
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void _salvarFalo() async {
    await faloDAO.create(
        Falo(personaId: widget.personaId, falo: editingControllerFalo.text));
    editingControllerFalo.text = '';
  }

  void _updateFalo(Falo newFalo) async {
    await faloDAO.update(newFalo);
    editingControllerFalo.text = '';
  }

  void _showDialogFalo([int faloId, String text]) {
    editingControllerFalo.text = text;
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('O que a persona Fala?'),
            content: TextField(
              autofocus: true,
              controller: editingControllerFalo,
              onEditingComplete: () {
                if (faloId == null) {
                  _salvarFalo();
                } else {
                  _updateFalo(Falo(
                      faloId: faloId,
                      personaId: widget.personaId,
                      falo: editingControllerFalo.text));
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
                  if (faloId == null) {
                    _salvarFalo();
                  } else {
                    _updateFalo(Falo(
                        faloId: faloId,
                        personaId: widget.personaId,
                        falo: editingControllerFalo.text));
                  }
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void _salvarPenso() async {
    await pensoDAO.create(
        Penso(personaId: widget.personaId, penso: editingControllerPenso.text));
    editingControllerPenso.text = '';
  }

  void _updatePenso(Penso newPenso) async {
    await pensoDAO.update(newPenso);
    editingControllerPenso.text = '';
  }

  void _showDialogPenso([int pensoId, String text]) {
    editingControllerPenso.text = text;
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('O que a persona Pensa?'),
            content: TextField(
              autofocus: true,
              controller: editingControllerPenso,
              onEditingComplete: () {
                if (pensoId == null) {
                  _salvarPenso();
                } else {
                  _updatePenso(Penso(
                      pensoId: pensoId,
                      personaId: widget.personaId,
                      penso: editingControllerPenso.text));
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
                  if (pensoId == null) {
                    _salvarPenso();
                  } else {
                    _updatePenso(Penso(
                        pensoId: pensoId,
                        personaId: widget.personaId,
                        penso: editingControllerPenso.text));
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

    _controller = new TabController(initialIndex: 0, length: 4, vsync: this);
    onChanged = () {
      setState(() {
        _currentIndex = this._controller.index;
        print(_controller.index);
      });
    };
    _controller.addListener(onChanged);

    editingControllerPenso = TextEditingController();
    editingControllerOuco = TextEditingController();
    editingControllerFalo = TextEditingController();
    editingControllerVejo = TextEditingController();
  }

  @override
  void dispose() {
    _controller.removeListener(onChanged);
    _controller.dispose();
    editingControllerPenso.dispose();
    editingControllerOuco.dispose();
    editingControllerFalo.dispose();
    editingControllerVejo.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Empatia'),
        bottom: TabBar(
          controller: _controller,
          tabs: <Widget>[
            Tab(text: 'Penso'),
            Tab(text: 'Ouço'),
            Tab(text: 'Falo'),
            Tab(text: 'Vejo')
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          // Penso List
          FutureBuilder<List<Penso>>(
              future: pensoDAO.readAll(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Penso>> snapshot) {
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
                            await pensoDAO.delete(item.pensoId);
                          },
                          child: ListTile(
                            title: Text(item.penso),
                            onTap: () {
                              _showDialogPenso(item.pensoId, item.penso);
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
          // Ouço List
          FutureBuilder<List<Ouco>>(
              future: oucoDAO.readAll(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Ouco>> snapshot) {
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
                            await oucoDAO.delete(item.oucoId);
                          },
                          child: ListTile(
                            title: Text(item.ouco),
                            onTap: () {
                              _showDialogOuco(item.oucoId, item.ouco);
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
          // Falo List
          FutureBuilder<List<Falo>>(
              future: faloDAO.readAll(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Falo>> snapshot) {
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
                            await faloDAO.delete(item.faloId);
                          },
                          child: ListTile(
                            title: Text(item.falo),
                            onTap: () {
                              _showDialogFalo(item.faloId, item.falo);
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
          // Vejo List
          FutureBuilder<List<Vejo>>(
              future: vejoDAO.readAll(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Vejo>> snapshot) {
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
                            await faloDAO.delete(item.vejoId);
                          },
                          child: ListTile(
                            title: Text(item.vejo),
                            onTap: () {
                              _showDialogFalo(item.vejoId, item.vejo);
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
                //Penso
                _showDialogPenso();
                break;
              }
            case 1:
              {
                //Ouço
                _showDialogOuco();
                break;
              }
            case 2:
              {
                //Falo
                _showDialogFalo();
                break;
              }
            case 3:
              {
                //Vejo
                _showDialogVejo();
                break;
              }
          }
        },
      ),
    );
  }
}
