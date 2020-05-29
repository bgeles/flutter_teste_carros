import 'package:flutter_carros/pages/carros/carro.dart';
import 'package:flutter_carros/pages/favoritos/favorito.dart';
import 'package:flutter_carros/pages/favoritos/favorito_dao.dart';

class FavoritoService {
  static favoritar(Carro c) async {
    Favorito f = Favorito.fromCarro(c);

    final dao = FavoritoDAO();

    final exists = await dao.exists(c.id);

    if (exists) {
      // Remove dos favoritos
      dao.delete(c.id);
    } else {
      dao.save(f);
    }
  }
}
