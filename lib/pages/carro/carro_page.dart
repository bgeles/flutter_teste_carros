import 'package:flutter/material.dart';
import 'package:flutter_carros/widgets/text.dart';

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
    switch (value) {
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
      child: ListView(
        children: <Widget>[
          Image.network(carro.urlFoto),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  text(
                    carro.nome,
                    fontSize: 20,
                    bold: true,
                  ),
                  text(
                    carro.nome,
                    fontSize: 16,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 40,
                    ),
                    onPressed: _onClickFavorito(),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.black,
                      size: 40,
                    ),
                    onPressed: _onClickShare(),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onClickShare() => _onClickShare;

  _onClickFavorito() => _onClickFavorito;

  void _onClickMapa() {}

  void _onClickVideo() {}
}
