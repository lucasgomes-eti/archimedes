import 'package:archimedes/dao/ENaoEFazNaoFaz/ProdutoEDAO.dart';
import 'package:archimedes/dao/ENaoEFazNaoFaz/ProdutoFazDAO.dart';
import 'package:archimedes/dao/ENaoEFazNaoFaz/ProdutoNaoEDAO.dart';
import 'package:archimedes/dao/ENaoEFazNaoFaz/ProdutoNaoFazDAO.dart';
import 'package:archimedes/model/produto_e_nao_e_faz_nao_faz/ProdutoE.dart';
import 'package:flutter/material.dart';

class ENaoEFazNaoFazPage extends StatefulWidget {
  final int projetoId;

  ENaoEFazNaoFazPage({Key key, this.projetoId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ENaoEFazNaoFazState();
}

class _ENaoEFazNaoFazState extends State<ENaoEFazNaoFazPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _controller;
  VoidCallback onChanged;

  ProdutoEDAO produtoEDAO = ProdutoEDAO();
  ProdutoNaoEDAO produtoNaoEDAO = ProdutoNaoEDAO();
  ProdutoFazDAO produtoFazDAO = ProdutoFazDAO();
  ProdutoNaoFazDAO produtoNaoFazDAO = ProdutoNaoFazDAO();

  TextEditingController editingControllerE;
  TextEditingController editingControllerNaoE;
  TextEditingController editingControllerFaz;
  TextEditingController editingControllerNaoFaz;

  void _salvarProdutoE() async {
    await produtoEDAO.create(ProdutoE(
        projetoId: widget.projetoId, produtoE: editingControllerE.text));
    editingControllerE.text = '';
  }

  void _updateProdutoE(ProdutoE newProdutoE) async {
    await produtoEDAO.update(newProdutoE);
    editingControllerE.text = '';
  }

  void _showDialogProdutoE([int produtoEId, String text]) {
    editingControllerE.text = text;
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('O que o produto é?'),
            content: TextField(
              autofocus: true,
              controller: editingControllerE,
              onEditingComplete: () {
                if (produtoEId == null) {
                  _salvarProdutoE();
                } else {
                  _updateProdutoE(ProdutoE(
                      produtoEId: produtoEId,
                      projetoId: widget.projetoId,
                      produtoE: editingControllerE.text));
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
                  if (produtoEId == null) {
                    _salvarProdutoE();
                  } else {
                    _updateProdutoE(ProdutoE(
                        produtoEId: produtoEId,
                        projetoId: widget.projetoId,
                        produtoE: editingControllerE.text));
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

    editingControllerE = TextEditingController();
    editingControllerNaoE = TextEditingController();
    editingControllerFaz = TextEditingController();
    editingControllerNaoFaz = TextEditingController();

    _controller = new TabController(initialIndex: 0, length: 4, vsync: this);
    onChanged = () {
      setState(() {
        _currentIndex = this._controller.index;
        print(_controller.index);
      });
    };
    _controller.addListener(onChanged);
  }

  @override
  void dispose() {
    editingControllerE.dispose();
    editingControllerNaoE.dispose();
    editingControllerFaz.dispose();
    editingControllerNaoFaz.dispose();

    _controller.removeListener(onChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('O Produto É / Não é / Faz / Não faz'),
        bottom: TabBar(
          controller: _controller,
          tabs: <Widget>[
            Tab(text: 'É'),
            Tab(text: 'Não É'),
            Tab(text: 'Faz'),
            Tab(text: 'Não Faz'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          FutureBuilder<List<ProdutoE>>(
              future: produtoEDAO.readAll(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProdutoE>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var produtoE = snapshot.data[index];
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(color: Colors.red),
                          onDismissed: (direction) async {
                            await produtoEDAO.delete(produtoE.produtoEId);
                          },
                          child: ListTile(
                            title: Text(produtoE.produtoE),
                            onTap: () {
                              _showDialogProdutoE(
                                  produtoE.produtoEId, produtoE.produtoE);
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
          Container(color: Colors.pink),
          Container(color: Colors.blue),
          Container(color: Colors.green),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Adicionar Item',
        onPressed: () {
          switch (_currentIndex) {
            case 0:
              {
                //É

                break;
              }
            case 1:
              {
                //Não É
                _showDialogProdutoE();
                break;
              }
            case 2:
              {
                //Faz
                showDialog(
                    context: context,
                    builder: (BuildContext buildContext) {
                      return AlertDialog(
                        title: Text('O que o produto faz?'),
                        content: TextField(
                          controller: editingControllerFaz,
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
                            onPressed: () {},
                          )
                        ],
                      );
                    });
                break;
              }
            case 3:
              {
                //Não Faz
                showDialog(
                    context: context,
                    builder: (BuildContext buildContext) {
                      return AlertDialog(
                        title: Text('O que o produto não faz?'),
                        content: TextField(
                          controller: editingControllerNaoFaz,
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
                            onPressed: () {},
                          )
                        ],
                      );
                    });
                break;
              }
          }
        },
      ),
    );
  }
}
