import 'dart:async';
import 'package:flutter_carros/pages/carros/carro_dao.dart';
import 'package:flutter_carros/utils/network.dart';

import 'carro.dart';
import 'carros_api.dart';

class CarrosBloc {
  final _streamController = StreamController<List<Carro>>();

  get stream => _streamController.stream;

  Future<List<Carro>> fetch(String tipo) async {
    try {
      bool networkOn = await isNetworkOn();

      if (!networkOn) {
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        _streamController.add(carros);
        return carros;
      }

      List<Carro> carros = await CarrosApi.getCarros(tipo);

      if (carros.isNotEmpty) {
        final dao = CarroDAO();
        //Salvar todos os carros no BD
        carros.forEach((c) => dao.save(c));

        _streamController.add(carros);
      }
    } catch (e) {
      _streamController.addError(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
