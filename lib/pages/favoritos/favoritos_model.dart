import 'package:flutter/cupertino.dart';
import 'package:flutter_carros/pages/carros/carro.dart';
import 'package:flutter_carros/pages/favoritos/favorito_service.dart';

class FavoritosModel extends ChangeNotifier {
  List<Carro> carros = [];

  void getCarros() async {
    carros = await FavoritoService.getCarros();

    notifyListeners();
  }
}
