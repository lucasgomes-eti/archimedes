import 'package:archimedes/model/persona/Persona.dart';
import 'package:flutter/material.dart';

class PersonaMenuPage extends StatelessWidget {
  final Persona persona;

  const PersonaMenuPage({Key key, this.persona}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(persona.nome)),
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
                    'Tipo de persona',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  )),
                ),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             VisaoProdutoPage(projetoId: projetoId)));
                },
              ),
            ),
            Card(
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                      child: Text(
                    'Mapa de empatia',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  )),
                ),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) =>
                  //           ENaoEFazNaoFazPage(projetoId: projetoId),
                  //     ));
                },
              ),
            ),
            Card(
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                      child: Text(
                    'Jornada',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  )),
                ),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             ObjetivoCaracteriscaPage(projetoId: projetoId)));
                },
              ),
            )
          ],
        ));
  }
}
