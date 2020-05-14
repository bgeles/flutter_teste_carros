import 'package:flutter/material.dart';
import 'package:flutter_carros/pages/carro/carro.dart';
import 'package:flutter_carros/pages/carro/carros_model.dart';
import 'package:flutter_carros/widgets/text_error.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../utils/nav.dart';
import 'carro_page.dart';

class CarrosListView extends StatefulWidget {
  String tipo;
  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  List<Carro> carros;

  final _model = CarrosModel();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _fetch();
  }

  void _fetch() {
    _model.fetch(widget.tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Observer(
      builder: (context) {
        List<Carro> carros = _model.carros;

        if (_model.error != null) {
          return Center(
            child: TextError(
              "Não foi possível buscar os carros \n\n Clique aqui para tentar novamente",
              onPressed: _fetch,
            ),
          );
        }
        if (carros == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return _listView(carros);
      },
    );
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
                          onPressed: () => _onClickCarros(c),
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

  _onClickCarros(Carro c) {
    push(context, CarroPage(c));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
