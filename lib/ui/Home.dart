import 'package:archimedes/dao/ProjetoDAO.dart';
import 'package:archimedes/model/Projeto.dart';
import 'package:archimedes/ui/NovoProjeto.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dao = ProjetoDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Projeto>>(
          future: dao.readAll(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Projeto>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var projeto = snapshot.data[index];
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.delete),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Icon(Icons.delete)
                            ],
                          ),
                        ),
                      ),
                      onDismissed: (direction) async {
                        await dao.delete(projeto.projetoId);
                      },
                      child: ListTile(
                        title: Text(projeto.nome),
                        subtitle: Text(projeto.descricao),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                        onLongPress: () {
                          showBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.edit),
                                      title: Text('Editar'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NovoProjeto(
                                                      editing: true,
                                                      title: projeto.nome,
                                                      projetoId:
                                                          projeto.projetoId,
                                                      nomeProjeto: projeto.nome,
                                                      descricaoProjeto:
                                                          projeto.descricao,
                                                    )));
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                    'Você ainda não criou nenhum projeto =/',
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
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NovoProjeto(
                        title: 'Novo Projeto',
                        editing: false,
                        nomeProjeto: "",
                        descricaoProjeto: ""
                      )));
        },
        tooltip: 'Criar Projeto',
        child: Icon(Icons.add),
      ),
    );
  }
}
