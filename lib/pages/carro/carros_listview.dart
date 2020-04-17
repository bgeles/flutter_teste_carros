import 'package:flutter/material.dart';
import 'package:flutter_carros/pages/carro/carro.dart';
import 'package:flutter_carros/pages/carro/carros_api.dart';

class CarrosListView extends StatefulWidget {
  String tipo;
  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {
    Future<List<Carro>> carros = CarrosApi.getCarros(widget.tipo);
    return FutureBuilder(
        future: carros,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text(
                "Não foi possível buscar os carros",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 22,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Carro> carros = snapshot.data;
          return _listView(carros);
        });
  }

  Container _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (
          context,
          index,
        ) {
          Carro c = carros[index];

          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      c.urlFoto ??
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
                          onPressed: () {},
                        ),
                        FlatButton(
                          child: const Text('SHARE'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
