import 'dart:convert' as convert;

import 'package:flutter_carros/pages/carro/carro.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    //try {

    var url =
        'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

    print("GET > $url");

    var response = await http.get(url);

    String json = response.body;

    print("status code : ${response.statusCode}");
    print(json);
    List list = convert.json.decode(json);

    final carros = list.map<Carro>((map) => Carro.fromJson(map)).toList();

    return carros;
    //} catch (error) {
    //  print(error);
    // }
  }
}
