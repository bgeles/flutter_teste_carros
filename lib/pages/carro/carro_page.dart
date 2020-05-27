import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_carros/pages/carro/loripsum_api.dart';
import 'package:flutter_carros/widgets/text.dart';

import 'carro.dart';

class CarroPage extends StatefulWidget {
  Carro carro;


  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumApiBloc = LoripsumApiBloc();

  @override
  void initState(){
    super.initState();

    _loripsumApiBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
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
          Image.network(widget.carro.urlFoto),
          _bloco1(),
          Divider(),
          _bloco2(),
                  ],
                ),
              );
            }

            Row _bloco1() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      text(
                        widget.carro.nome,
                        fontSize: 16,
                        bold: true,
                      ),
                      text(
                        widget.carro.tipo,
                        fontSize: 12,
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
              );
            }

          
            _bloco2() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  text(widget.carro.descricao,fontSize: 16, bold: true),
                  SizedBox(height: 20,),
                  StreamBuilder<String>(
                    stream: _loripsumApiBloc.stream,
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if(!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator(),);
                      }
                      return text(snapshot.data, fontSize: 16);
                    },
                  ),
                ],
              );
            }
              _onClickShare() => _onClickShare;

            _onClickFavorito() => _onClickFavorito;

            void _onClickMapa() {}

            void _onClickVideo() {}

            @override 
            void dispose(){
              super.dispose();
              _loripsumApiBloc.dispose();
            }

}
