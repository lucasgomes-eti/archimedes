import 'package:archimedes/dao/PersonaDAO.dart';
import 'package:archimedes/model/persona/Persona.dart';
import 'package:archimedes/ui/PersonaMenuPage.dart';
import 'package:flutter/material.dart';

class PersonasPage extends StatefulWidget {
  final projetoId;
  PersonasPage({Key key, this.projetoId}) : super(key: key);

  @override
  createState() => _PersonasState();
}

class _PersonasState extends State<PersonasPage> {
  final dao = PersonaDAO();

  TextEditingController editingControllerNome;

  void _salvarPersona() async {
    await dao.create(
        Persona(projetoId: widget.projetoId, nome: editingControllerNome.text));
    editingControllerNome.text = '';
  }

  void _updatePersona(Persona newPersona) async {
    await dao.update(newPersona);
    editingControllerNome.text = '';
  }

  void _showDialogPersona([int personaId, String text]) {
    void saveOrUpdate() {
      if (personaId == null) {
        _salvarPersona();
      } else {
        _updatePersona(Persona(
            personaId: personaId,
            projetoId: widget.projetoId,
            nome: editingControllerNome.text));
      }
      Navigator.pop(context);
    }

    editingControllerNome.text = text;
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('Como se chama essa persona?'),
            content: TextField(
              autofocus: true,
              controller: editingControllerNome,
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

    editingControllerNome = TextEditingController();
  }

  @override
  void dispose() {
    editingControllerNome.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personas'),
      ),
      body: FutureBuilder<List<Persona>>(
          future: dao.readAll(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Persona>> snapshot) {
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
                        await dao.delete(item.personaId);
                      },
                      child: ListTile(
                        title: Text(item.nome),
                        trailing: GestureDetector(
                          child: Container(
                            width: 48,
                            height: 48,
                            child: Tooltip(
                              message: 'Editar',
                              child: Icon(
                                Icons.edit,
                                size: 20,
                              ),
                            ),
                          ),
                          onTap: () {
                            _showDialogPersona(item.personaId, item.nome);
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PersonaMenuPage(
                                        persona: item,
                                      )));
                        },
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                    'Você ainda não criou nenhuma persona =/',
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
        onPressed: _showDialogPersona,
        tooltip: 'Criar Persona',
        child: Icon(Icons.add),
      ),
    );
  }
}
