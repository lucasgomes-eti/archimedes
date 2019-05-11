import 'package:archimedes/dao/ENaoEFazNaoFaz/ProdutoEDAO.dart';
import 'package:archimedes/dao/ENaoEFazNaoFaz/ProdutoFazDAO.dart';
import 'package:archimedes/dao/ENaoEFazNaoFaz/ProdutoNaoEDAO.dart';
import 'package:archimedes/dao/ENaoEFazNaoFaz/ProdutoNaoFazDAO.dart';
import 'package:archimedes/model/produto_e_nao_e_faz_nao_faz/ProdutoE.dart';
import 'package:archimedes/model/produto_e_nao_e_faz_nao_faz/ProdutoFaz.dart';
import 'package:archimedes/model/produto_e_nao_e_faz_nao_faz/ProdutoNaoE.dart';
import 'package:archimedes/model/produto_e_nao_e_faz_nao_faz/ProdutoNaoFaz.dart';
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

  void _salvarProdutoNaoE() async {
    await produtoNaoEDAO.create(ProdutoNaoE(
        projetoId: widget.projetoId, produtoNaoE: editingControllerNaoE.text));
    editingControllerNaoE.text = '';
  }

  void _updateProdutoNaoE(ProdutoNaoE newProdutoNaoE) async {
    await produtoNaoEDAO.update(newProdutoNaoE);
    editingControllerNaoE.text = '';
  }

  void _showDialogProdutoNaoE([int produtoNaoEId, String text]) {
    editingControllerNaoE.text = text;
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('O que o produto não é?'),
            content: TextField(
              autofocus: true,
              controller: editingControllerNaoE,
              onEditingComplete: () {
                if (produtoNaoEId == null) {
                  _salvarProdutoNaoE();
                } else {
                  _updateProdutoNaoE(ProdutoNaoE(
                      produtoNaoEId: produtoNaoEId,
                      projetoId: widget.projetoId,
                      produtoNaoE: editingControllerNaoE.text));
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
                  if (produtoNaoEId == null) {
                    _salvarProdutoNaoE();
                  } else {
                    _updateProdutoNaoE(ProdutoNaoE(
                        produtoNaoEId: produtoNaoEId,
                        projetoId: widget.projetoId,
                        produtoNaoE: editingControllerNaoE.text));
                  }
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void _salvarProdutoFaz() async {
    await produtoFazDAO.create(ProdutoFaz(
        projetoId: widget.projetoId, produtoFaz: editingControllerFaz.text));
    editingControllerFaz.text = '';
  }

  void _updateProdutoFaz(ProdutoFaz newProdutoFaz) async {
    await produtoFazDAO.update(newProdutoFaz);
    editingControllerFaz.text = '';
  }

  void _showDialogProdutoFaz([int produtoFazId, String text]) {
    editingControllerFaz.text = text;
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('O que o produto faz?'),
            content: TextField(
              autofocus: true,
              controller: editingControllerFaz,
              onEditingComplete: () {
                if (produtoFazId == null) {
                  _salvarProdutoFaz();
                } else {
                  _updateProdutoFaz(ProdutoFaz(
                      produtoFazId: produtoFazId,
                      projetoId: widget.projetoId,
                      produtoFaz: editingControllerFaz.text));
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
                  if (produtoFazId == null) {
                    _salvarProdutoFaz();
                  } else {
                    _updateProdutoFaz(ProdutoFaz(
                        produtoFazId: produtoFazId,
                        projetoId: widget.projetoId,
                        produtoFaz: editingControllerFaz.text));
                  }
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void _salvarProdutoNaoFaz() async {
    await produtoNaoFazDAO.create(ProdutoNaoFaz(
        projetoId: widget.projetoId,
        produtoNaoFaz: editingControllerNaoFaz.text));
    editingControllerNaoFaz.text = '';
  }

  void _updateProdutoNaoFaz(ProdutoNaoFaz newProdutoNaoFaz) async {
    await produtoNaoFazDAO.update(newProdutoNaoFaz);
    editingControllerNaoFaz.text = '';
  }

  void _showDialogProdutoNaoFaz([int produtoNaoFazId, String text]) {
    editingControllerNaoFaz.text = text;
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('O que o produto não faz?'),
            content: TextField(
              autofocus: true,
              controller: editingControllerNaoFaz,
              onEditingComplete: () {
                if (produtoNaoFazId == null) {
                  _salvarProdutoNaoFaz();
                } else {
                  _updateProdutoNaoFaz(ProdutoNaoFaz(
                      produtoNaoFazId: produtoNaoFazId,
                      projetoId: widget.projetoId,
                      produtoNaoFaz: editingControllerNaoFaz.text));
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
                  if (produtoNaoFazId == null) {
                    _salvarProdutoNaoFaz();
                  } else {
                    _updateProdutoNaoFaz(ProdutoNaoFaz(
                        produtoNaoFazId: produtoNaoFazId,
                        projetoId: widget.projetoId,
                        produtoNaoFaz: editingControllerNaoFaz.text));
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
          // Produto É List
          FutureBuilder<List<ProdutoE>>(
              future: produtoEDAO.readAll(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProdutoE>> snapshot) {
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
                            await produtoEDAO.delete(item.produtoEId);
                          },
                          child: ListTile(
                            title: Text(item.produtoE),
                            onTap: () {
                              _showDialogProdutoE(
                                  item.produtoEId, item.produtoE);
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
          //Produto Não é List
          FutureBuilder<List<ProdutoNaoE>>(
              future: produtoNaoEDAO.readAll(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProdutoNaoE>> snapshot) {
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
                            await produtoNaoEDAO.delete(item.produtoNaoEId);
                          },
                          child: ListTile(
                            title: Text(item.produtoNaoE),
                            onTap: () {
                              _showDialogProdutoNaoE(
                                  item.produtoNaoEId, item.produtoNaoE);
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
          //Produto Faz List
          FutureBuilder<List<ProdutoFaz>>(
              future: produtoFazDAO.readAll(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProdutoFaz>> snapshot) {
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
                            await produtoFazDAO.delete(item.produtoFazId);
                          },
                          child: ListTile(
                            title: Text(item.produtoFaz),
                            onTap: () {
                              _showDialogProdutoFaz(
                                  item.produtoFazId, item.produtoFaz);
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
          //Produto Não Faz List
          FutureBuilder<List<ProdutoNaoFaz>>(
              future: produtoNaoFazDAO.readAll(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProdutoNaoFaz>> snapshot) {
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
                            await produtoNaoFazDAO.delete(item.produtoNaoFazId);
                          },
                          child: ListTile(
                            title: Text(item.produtoNaoFaz),
                            onTap: () {
                              _showDialogProdutoNaoFaz(
                                  item.produtoNaoFazId, item.produtoNaoFaz);
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
                _showDialogProdutoE();
                break;
              }
            case 1:
              {
                //Não É
                _showDialogProdutoNaoE();
                break;
              }
            case 2:
              {
                //Faz
                _showDialogProdutoFaz();
                break;
              }
            case 3:
              {
                //Não Faz
                _showDialogProdutoNaoFaz();
                break;
              }
          }
        },
      ),
    );
  }
}
