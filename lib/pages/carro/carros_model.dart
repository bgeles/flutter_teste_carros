import 'package:mobx/mobx.dart';
import 'carro.dart';
import 'carros_api.dart';

part 'carros_model.g.dart';

class CarrosModel = CarrosModelBase with _$CarrosModel;

abstract class CarrosModelBase with Store {
  @observable
  List<Carro> carros;

  @observable
  Exception error;

  @action
  fetch(String tipo) async {
    try {
      error = null;
      this.carros = await CarrosApi.getCarros(tipo);
    } catch (e) {
      error = e;
    }
  }
}
