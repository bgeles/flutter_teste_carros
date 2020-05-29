import 'package:flutter_carros/pages/carros/carro.dart';
import 'package:flutter_carros/pages/carros/carro_dao.dart';
import 'package:flutter_carros/pages/favoritos/favorito.dart';
import 'package:flutter_carros/pages/favoritos/favorito_dao.dart';

class FavoritoService {
  static Future<bool> favoritar(Carro c) async {
    Favorito f = Favorito.fromCarro(c);

    final dao = FavoritoDAO();

    final exists = await dao.exists(c.id);

    if (exists) {
      // Remove dos favoritos
      dao.delete(c.id);
      print("FAVORRITOS DELETADO");
      return false;
    } else {
      dao.save(f);
      print("FAVORITOS SALVO");

      return true;
    }
  }

  static Future<List<Carro>> getCarros() async {
    // select * from carro c, favorito f where c.id = f.id
    List<Carro> carros = await CarroDAO()
        .query('select * from carro c, favorito f where c.id = f.id');
    return carros;
  }

  static Future<bool> isFavorito(Carro c) async {
    final dao = FavoritoDAO();

    final exists = await dao.exists(c.id);
    print('FAVORITO -> $exists ');
    return exists;
  }
}
