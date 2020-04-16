import 'dart:convert' as convert;

import 'package:flutter_carros/pages/carro/carro.dart';
import 'package:http/http.dart' as http;

class CarrosApi {
  static Future<List<Carro>> getCarros() async {
    //try {
    var url = 'https://carros-springboot.herokuapp.com/api/v1/carros';

    var response = await http.get(url);

    String json = response.body;

    List mapResponse = convert.json.decode(response.body);

    return [];
    //} catch (error) {
    //  print(error);
    // }
  }
}
