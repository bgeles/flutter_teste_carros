import 'package:flutter/material.dart';
import 'package:flutter_carros/pages/carro/carro.dart';
import 'package:flutter_carros/pages/carro/carros_bloc.dart';
import 'package:flutter_carros/pages/carro/carros_listview.dart';
import 'package:flutter_carros/widgets/text_error.dart';

class CarrosPage extends StatefulWidget {
  String tipo;
  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  List<Carro> carros;

  final _bloc = CarrosBloc();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _bloc.fetch(widget.tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: TextError("Não foi possível buscar os carros",),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;
        return CarrosListView(carros);
      },
    );
  }


  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
