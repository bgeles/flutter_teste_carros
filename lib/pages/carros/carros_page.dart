import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_carros/pages/carros/carro.dart';
import 'package:flutter_carros/pages/carros/carros_bloc.dart';
import 'package:flutter_carros/pages/carros/carros_listview.dart';
import 'package:flutter_carros/utils/event_bus.dart';
import 'package:flutter_carros/widgets/text_error.dart';
import 'package:provider/provider.dart';

class CarrosPage extends StatefulWidget {
  String tipo;
  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  List<Carro> carros;

  StreamSubscription<Event> subscription;

  final _bloc = CarrosBloc();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _bloc.fetch(widget.tipo);

    final bus = EventBus.get(context);
    subscription = bus.stream.listen((Event e) {
      print("Event $e");

      CarroEvent carroEvent = e;
      if (carroEvent.tipo == widget.tipo) {
        _bloc.fetch(widget.tipo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
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
    return _bloc.fetch(widget.tipo);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    subscription.cancel();
  }
}
