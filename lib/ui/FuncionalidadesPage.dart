import 'package:archimedes/dao/FuncionalidadeDAO.dart';
import 'package:archimedes/model/Funcionalidade.dart';
import 'package:archimedes/ui/NovaFuncionalidadePage.dart';
import 'package:flutter/material.dart';

class FuncionalidadesPage extends StatefulWidget {
  final int projetoId;

  FuncionalidadesPage({Key key, this.projetoId}) : super(key: key);

  @override
  createState() => _FuncionalidadesState();
}

class _FuncionalidadesState extends State<FuncionalidadesPage> {
  final dao = FuncionalidadeDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Funcionalidades'),
      ),
      body: FutureBuilder<List<Funcionalidade>>(
          future: dao.readAll(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Funcionalidade>> snapshot) {
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
                        await dao.delete(item.funcionalidadeId);
                      },
                      child: ListTile(
                        title: Text(item.descricao),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NovaFuncionalidadePage(
                                        funcionalidade: item,
                                        editing: true,
                                      )));
                        },
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                    'Você ainda não criou nenhuma funcionalidade =/',
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
        child: Icon(Icons.add),
        tooltip: 'Criar funcionalidade',
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NovaFuncionalidadePage(
                        projetoId: widget.projetoId,
                        funcionalidade: null,
                        editing: false,
                      )));
        },
      ),
    );
  }
}
