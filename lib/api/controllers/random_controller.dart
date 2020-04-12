import 'dart:math';

import 'package:car_drivers/data/mappers/car_mapper.dart';
import 'package:car_drivers/data/mappers/driver_mapper.dart';
import 'package:car_drivers/domain/usecase/collect_random_pair_usecase.dart';

import '../../car_drivers.dart';

class RandomController extends ResourceController {

  RandomController(this.collectRandomPairUsecase);

  final CollectRandomPairUsecase collectRandomPairUsecase;

  /// Получить рандомную пару водитель-авто
  @Operation.get()
  Future<Response> getRandomMatch() async {
    
    final result = await collectRandomPairUsecase();

    // тут конечно не фонтан, лень было
    return Response.ok(
      {
        "car": CarMapper.mapEntityToModel(result.car)?.asMap(),
        "driver": DriverMapper.mapEntityToModel(result.driver)?.asMap(),
      },
      headers: {'Content-type': 'application/json'},
    );
  }
}
