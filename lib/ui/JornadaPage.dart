import 'package:archimedes/dao/JornadaDAO.dart';
import 'package:archimedes/model/Jornada.dart';
import 'package:flutter/material.dart';

class JornadaPage extends StatefulWidget {
  final personaId;
  JornadaPage({Key key, this.personaId}) : super(key: key);

  @override
  createState() => _JornadaState();
}

class _JornadaState extends State<JornadaPage> {
  final dao = JornadaDAO();

  TextEditingController editingControllerJornada;

  void _salvarJornada() async {
    await dao.create(Jornada(
        personaId: widget.personaId, jornada: editingControllerJornada.text));
    editingControllerJornada.text = '';
  }

  void _updateJornada(Jornada newJornada) async {
    await dao.update(newJornada);
    editingControllerJornada.text = '';
  }

  void _showDialogJornada([int jornadaId, String text]) {
    void saveOrUpdate() {
      if (jornadaId == null) {
        _salvarJornada();
      } else {
        _updateJornada(Jornada(
            jornadaId: jornadaId,
            personaId: widget.personaId,
            jornada: editingControllerJornada.text));
      }
      Navigator.pop(context);
    }

    editingControllerJornada.text = text;
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('O que acontece na jornada da persona?'),
            content: TextField(
              autofocus: true,
              controller: editingControllerJornada,
              onEditingComplete: saveOrUpdate,
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
                onPressed: saveOrUpdate,
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();

    editingControllerJornada = TextEditingController();
  }

  @override
  void dispose() {
    editingControllerJornada.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jornada'),
      ),
      body: FutureBuilder<List<Jornada>>(
          future: dao.readAll(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Jornada>> snapshot) {
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
                        await dao.delete(item.jornadaId);
                      },
                      child: ListTile(
                        title: Text(item.jornada),
                        onTap: () {
                          _showDialogJornada(item.jornadaId, item.jornada);
                        },
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                    'Você ainda não criou nenhuma jornada =/',
                    style: Theme.of(context).textTheme.display1,
                    textAlign: TextAlign.center,
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialogJornada,
        tooltip: 'Criar Jornada',
        child: Icon(Icons.add),
      ),
    );
  }
}
