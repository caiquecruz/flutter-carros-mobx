import 'package:flutter_carros_mobx/base_bloc.dart';
import 'package:flutter_carros_mobx/pages/carro/carro.dart';
import 'package:flutter_carros_mobx/pages/carro/carros_api.dart';

class CarrosBloc extends BaseBloc<List<Carro>> {
  fetch(String tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);

      add(carros);
    } catch (e) {
      addError(e);
    }
  }
}
