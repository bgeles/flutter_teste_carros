import 'package:flutter/material.dart';
import 'package:flutter_carros/main.dart';
import 'package:flutter_carros/pages/carros/carro.dart';
import 'package:flutter_carros/pages/carros/carros_listview.dart';
import 'package:flutter_carros/pages/favoritos/favoritos_bloc.dart';
import 'package:flutter_carros/pages/favoritos/favoritos_model.dart';
import 'package:flutter_carros/widgets/text_error.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  List<Carro> carros;

  //final _bloc = FavoritosBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    FavoritosModel model = Provider.of<FavoritosModel>(context, listen: false);
    model.getCarros();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    FavoritosModel model = Provider.of<FavoritosModel>(context);

    List<Carro> carros = model.carros;

    if (carros.isEmpty) {
      return Center(
        child: Text(
          "Nenhum carro nos favoritos",
          style: TextStyle(fontSize: 20),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CarrosListView(carros),
    );
  }

  Future<void> _onRefresh() {
    return Provider.of<FavoritosModel>(context, listen: false).getCarros();
  }
}
