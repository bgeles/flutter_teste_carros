import 'dart:convert' as convert;

import 'package:flutter_carros/pages/carros/carro.dart';
import 'package:flutter_carros/pages/favoritos/carro_dao.dart';
import 'package:http/http.dart' as http;

import '../login/usuario.dart';

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    //try {

    Usuario user = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    print(headers);

    var url =
        'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

    print("GET > $url");

    var response = await http.get(url, headers: headers);

    String json = response.body;

    print("status code : ${response.statusCode}");
    print(json);

    List list = convert.json.decode(json);

    final carros = list.map<Carro>((map) => Carro.fromMap(map)).toList();

    final dao = CarroDAO();

    //Salvar todos os carros no BD
    carros.forEach((c) => dao.save(c));

    return carros;

    //} catch (error) {
    //  print(error);
    // }
  }
}