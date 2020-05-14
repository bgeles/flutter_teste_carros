import 'package:flutter/material.dart';

import 'carro.dart';

class CarroPage extends StatelessWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
        actions: <Widget>[
          IconButton(
            onPressed: _onClickMapa,
            icon: Icon(
              Icons.place,
            ),
          ),
          IconButton(
            onPressed: _onClickVideo,
            icon: Icon(
              Icons.video_call,
            ),
          ),
          PopupMenuButton<String>(
            onSelected: _onClickPopupMenu,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: "Editar",
                  child: Text("Editar"),
                ),
                PopupMenuItem(
                  value: "Deletar",
                  child: Text("Deletar"),
                ),
                PopupMenuItem(
                  value: "Share",
                  child: Text("Share"),
                ),
              ];
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  void _onClickPopupMenu(String value) {

    switch(value){
      case "Editar":
      print("Editar !!!");
      break;
      case "Deletar":
      print("Deletar !!!");
      break;
      case "Share":
      print("Share !!!");
      break;
    }

  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Image.network(carro.urlFoto),
    );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}
}
