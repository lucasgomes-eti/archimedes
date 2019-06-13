import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class CanvasPage extends StatefulWidget {
  @override
  createState() => _CanvasState();
}

class _CanvasState extends State<CanvasPage> {
  GlobalKey _globalKey = GlobalKey();
  Uint8List imageInMemory;

  Future<Uint8List> _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      imageInMemory = pngBytes;
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(content: prefix0.Image.memory(pngBytes),);
      });
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Canvas MVP'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.file_download),
              onPressed: _capturePng,
              tooltip: 'Download',
            )
          ],
        ),
        body: RepaintBoundary(
          key: _globalKey,
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1,
            padding: EdgeInsets.all(8),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[Text('Personas')],
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[Text('Visão de produto')],
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[Text('Objetivo e Características')],
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[Text('Jornadas')],
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[Text('Funcionalidades')],
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[Text('Custo e cronograma')],
                ),
              )
            ],
          ),
        ));
  }
}
