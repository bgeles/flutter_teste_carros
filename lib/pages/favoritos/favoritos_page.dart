import 'package:flutter/material.dart';
import 'package:flutter_carros/main.dart';
import 'package:flutter_carros/pages/carros/carro.dart';
import 'package:flutter_carros/pages/carros/carros_listview.dart';
import 'package:flutter_carros/pages/favoritos/favoritos_bloc.dart';
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

    FavoritosBloc favoritosBloc =
        Provider.of<FavoritosBloc>(context, listen: false);
    favoritosBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: Provider.of<FavoritosBloc>(context).stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: TextError(
              "Não foi possível buscar os carros",
            ),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosListView(carros),
        );
      },
    );
  }

  Future<void> _onRefresh() {
    return Provider.of<FavoritosBloc>(context).fetch();
  }
}
