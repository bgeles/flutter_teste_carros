import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carros/pages/carros/carro.dart';
import '../../utils/nav.dart';
import 'carro_page.dart';

class CarrosListView extends StatelessWidget {
  List<Carro> carros;

  CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (
          context,
          index,
        ) {
          Carro c = carros[index];

          return InkWell(
            onTap: () => {_onClickCarros(context, c)},
            onLongPress: () => {_onLongClickCarros(context, c)},
            child: Card(
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: c.urlFoto ??
                            "http://www.livroandroid.com.br/livro/carros/classicos/Chevrolet_BelAir.png",
                        width: 200,
                      ),
                    ),
                    Text(
                      c.nome ?? "VAZIO",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      "descricao ...",
                      style: TextStyle(fontSize: 16),
                    ),
                    ButtonTheme(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('DETALHES'),
                            onPressed: () => _onClickCarros(context, c),
                          ),
                          FlatButton(
                            child: const Text('SHARE'),
                            onPressed: () => _onClickShare(context, c),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onLongClickCarros(BuildContext context, Carro c) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(c.nome),
            children: <Widget>[
              ListTile(
                title: Text('Detalhes'),
                onTap: () {
                  pop(context);
                  _onClickCarros(context, c);
                },
              ),
              ListTile(
                title: Text('Share'),
                onTap: () {
                  pop(context);
                  _onClickShare(context, c);
                },
              )
            ],
          );
        });
  }

  _onClickCarros(context, Carro c) {
    push(context, CarroPage(c));
  }

  _onClickShare(BuildContext context, Carro c) {
    print("Share ${c.nome}");
  }
}
