import 'dart:async';
import 'package:flutter_carros/pages/favoritos/carro_dao.dart';

import 'carro.dart';
import 'carros_api.dart';

class CarrosBloc {
  final _streamController = StreamController<List<Carro>>();

  get stream => _streamController.stream;

  Future<List<Carro>> fetch(String tipo) async {
    try {
      bool networkOn = false;

      if (!networkOn) {
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        return carros;
      }

      List<Carro> carros = await CarrosApi.getCarros(tipo);
      _streamController.add(carros);
    } catch (e) {
      _streamController.addError(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
