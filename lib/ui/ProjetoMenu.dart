import 'package:flutter/material.dart';

import 'VisaoProdutoPage.dart';

class ProjetoMenu extends StatelessWidget {
  String title;
  int projetoId;

  ProjetoMenu({this.title, this.projetoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1,
          padding: EdgeInsets.all(16),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: <Widget>[
            Card(
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                      child: Text(
                    'Visão do produto',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  )),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VisaoProdutoPage(projetoId: projetoId)));
                },
              ),
            ),
            Card(
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                      child: Text(
                    'O Produto É / Não é / Faz / Não faz',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  )),
                ),
                onTap: () {},
              ),
            ),
            Card(
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                      child: Text(
                    'Objetivos e Características',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  )),
                ),
                onTap: () {},
              ),
            ),
            Card(
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                      child: Text(
                    'Personas',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  )),
                ),
                onTap: () {},
              ),
            ),
            Card(
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                      child: Text(
                    'Funcionalidades',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  )),
                ),
                onTap: () {},
              ),
            )
          ],
        ));
  }
}
